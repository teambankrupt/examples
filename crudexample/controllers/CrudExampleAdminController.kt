package com.example.app.domains.crudexamples.controllers

import arrow.core.flatMap
import com.example.app.domains.crudexamples.models.dtos.*
import com.example.app.domains.crudexamples.services.CrudExampleService
import com.example.app.routing.Route
import com.example.auth.config.security.SecurityContext
import com.example.coreweb.domains.base.controllers.CrudControllerV5
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
class CrudExampleAdminController @Autowired constructor(
    private val env: Environment,
    private val crudExampleService: CrudExampleService,
) : CrudControllerV5<CrudExampleReq, CrudExampleBriefResponse, CrudExampleDetailResponse> {

    /*
          COPY THESE URLS TO ROUTE FILE AND ADJUST
          ------------------------------------------------------
          object CrudExamples {
            object AdminApis {
                const val SEARCH = "$API/admin/crudexamples"
                const val CREATE = "$API/admin/crudexamples"
                const val FIND = "$API/admin/crudexamples/{id}"
                const val UPDATE = "$API/admin/crudexamples/{id}"
                const val DELETE = "$API/admin/crudexamples/{id}"
            }
            object UserApis{}
          }
          ------------------------------------------------------
     */

    @GetMapping(Route.V1.CrudExamples.AdminApis.SEARCH)
    override fun search(
        @RequestParam("username", required = false) username: String?,
        @RequestParam("from_date", required = false) fromDate: Instant?,
        @RequestParam("to_date", required = false) toDate: Instant?,
        @RequestParam("q", required = false) query: String?,
        @RequestParam("page", defaultValue = "0") page: Int,
        @RequestParam("size", defaultValue = "10") size: Int,
        @RequestParam("sort_by", defaultValue = "ID") sortBy: SortByFields,
        @RequestParam("sort_direction", defaultValue = "DESC") direction: Sort.Direction,
        @RequestParam(required = false) extra: Map<String, String>,
    ): ResponseEntity<ResponseData<Page<CrudExampleBriefResponse>>> =
        this.crudExampleService.search(
            username = username,
            fromDate = fromDate ?: Instant.EPOCH,
            toDate = toDate ?: Instant.now(),
            params = PageableParams.of(query, page, size, sortBy, direction)
        ).toResponse { it.toBriefResponse() }

    @GetMapping(Route.V1.CrudExamples.AdminApis.FIND)
    override fun find(@PathVariable("id") id: Long): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
        SecurityContext.getCurrentUser().let { auth ->
            this.crudExampleService.getAsEither(id, asUser = auth)
                .toResponse(debug = debug()) {
                    it.toDetailResponse()
                }
        }

    @PostMapping(Route.V1.CrudExamples.AdminApis.CREATE)
    override fun create(
        @Valid @RequestBody req: CrudExampleReq
    ): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
        SecurityContext.getCurrentUser().let { auth ->
            this.crudExampleService.save(
                entity = req.asCrudExample(),
                asUser = auth
            ).toResponse(debug = debug()) {
                it.toDetailResponse()
            }
        }

    @PatchMapping(Route.V1.CrudExamples.AdminApis.UPDATE)
    override fun update(
        @PathVariable("id") id: Long,
        @Valid @RequestBody req: CrudExampleReq
    ): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
        this.crudExampleService.getAsEither(id, asUser = SecurityContext.getCurrentUser())
            .flatMap {
                this.crudExampleService.save(
                    entity = req.asCrudExample(it),
                    asUser = SecurityContext.getCurrentUser()
                )
            }
            .toResponse(debug = debug()) {
                it.toDetailResponse()
            }

    @DeleteMapping(Route.V1.CrudExamples.AdminApis.DELETE)
    override fun delete(
        @PathVariable("id") id: Long
    ): ResponseEntity<ResponseData<Boolean>> =
        this.crudExampleService.delete(
            id = id, softDelete = true, asUser = SecurityContext.getCurrentUser()
        ).toResponse(debug = debug()) { it }

    override fun getEnv(): Environment = this.env

}
