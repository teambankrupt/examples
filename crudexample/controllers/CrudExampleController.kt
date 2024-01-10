package com.example.app.domains.crudexamples.controllers

import arrow.core.flatMap
import com.example.app.domains.crudexamples.models.dtos.*
import com.example.app.domains.crudexamples.services.CrudExampleService
import com.example.app.routing.Route
import com.example.coreweb.domains.base.controllers.CrudControllerV4
import com.example.coreweb.domains.base.models.enums.SortByFields
import com.example.coreweb.utils.PageableParams
import com.example.coreweb.utils.ResponseData
import com.example.coreweb.utils.toResponse
import io.swagger.annotations.Api
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.env.Environment
import org.springframework.data.domain.Page
import org.springframework.data.domain.Sort
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.time.Instant
import javax.validation.Valid

@RestController
@Api(tags = ["CrudExamples"], description = "Description about CrudExamples")
class CrudExampleController @Autowired constructor(
    private val env: Environment,
    private val crudExampleService: CrudExampleService,
) : CrudControllerV4<CrudExampleReq, CrudExampleBriefResponse, CrudExampleDetailResponse> {

    /*
          COPY THESE URLS TO ROUTE FILE AND ADJUST
          ------------------------------------------------------
          object CrudExamples {
            const val SEARCH = "$API/crudexamples"
            const val CREATE = "$API/crudexamples"
            const val FIND = "$API/crudexamples/{id}"
            const val UPDATE = "$API/crudexamples/{id}"
            const val DELETE = "$API/crudexamples/{id}"
          }
          ------------------------------------------------------
     */

    @GetMapping(Route.V1.CrudExamples.SEARCH)
    override fun search(
        @RequestParam("username", required = false) username: String?,
        @RequestParam("from_date", required = false) fromDate: Instant?,
        @RequestParam("to_date", required = false) toDate: Instant?,
        @RequestParam("q", required = false) query: String?,
        @RequestParam("page", defaultValue = "0") page: Int,
        @RequestParam("size", defaultValue = "10") size: Int,
        @RequestParam("sort_by", defaultValue = "ID") sortBy: SortByFields,
        @RequestParam("sort_direction", defaultValue = "DESC") direction: Sort.Direction
    ): ResponseEntity<ResponseData<Page<CrudExampleBriefResponse>>> =
        this.crudExampleService.search(
            username = username,
            fromDate = fromDate ?: Instant.EPOCH,
            toDate = toDate ?: Instant.now(),
            params = PageableParams.of(query, page, size, sortBy, direction)
        ).toResponse { it.toBriefResponse() }

    @GetMapping(Route.V1.CrudExamples.FIND)
    override fun find(@PathVariable("id") id: Long): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
        this.crudExampleService.getAsEither(id)
            .toResponse(debug = debug()) {
                it.toDetailResponse()
            }

    @PostMapping(Route.V1.CrudExamples.CREATE)
    override fun create(
        @Valid @RequestBody req: CrudExampleReq
    ): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
        this.crudExampleService.save(req.asCrudExample())
            .toResponse(debug = debug()) {
                it.toDetailResponse()
            }

    @PatchMapping(Route.V1.CrudExamples.UPDATE)
    override fun update(
        @PathVariable("id") id: Long,
        @Valid @RequestBody req: CrudExampleReq
    ): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
        this.crudExampleService.getAsEither(id)
            .flatMap { this.crudExampleService.save(req.asCrudExample(it)) }
            .toResponse(debug = debug()) {
                it.toDetailResponse()
            }

    @DeleteMapping(Route.V1.CrudExamples.DELETE)
    override fun delete(
        @PathVariable("id") id: Long
    ): ResponseEntity<ResponseData<Boolean>> =
        this.crudExampleService.delete(id, true)
            .toResponse(debug = debug()) { it }

    override fun getEnv(): Environment = this.env

}
