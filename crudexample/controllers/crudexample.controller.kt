package com.example.app.domains.crudexamples.controllers

import arrow.core.flatMap
import com.example.app.domains.crudexamples.models.dtos.CrudExampleBriefResponse
import com.example.app.domains.crudexamples.models.dtos.CrudExampleDetailResponse
import com.example.app.domains.crudexamples.models.dtos.CrudExampleReq
import com.example.app.domains.crudexamples.models.dtos.toBriefResponse
import com.example.app.domains.crudexamples.models.dtos.toDetailResponse
import com.example.app.domains.crudexamples.services.CrudExampleService
import com.example.app.routing.Route
import com.example.auth.config.security.SecurityContext
import com.example.coreweb.domains.base.controllers.CrudControllerV7
import com.example.coreweb.utils.PageableParamsV2
import com.example.coreweb.utils.ResponseData
import com.example.coreweb.utils.onSecuredContext
import com.example.coreweb.utils.toResponse
import io.swagger.annotations.Api
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.env.Environment
import org.springframework.data.domain.Page
import org.springframework.data.domain.Sort
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PatchMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import java.time.Instant
import javax.validation.Valid

@RestController
@Api(tags = ["CrudExamples"], description = "Description about CrudExamples")
class CrudExampleController @Autowired constructor(
	private val env: Environment,
	private val crudExampleService: CrudExampleService,
) : CrudControllerV7<CrudExampleReq, CrudExampleBriefResponse, CrudExampleDetailResponse> {

	@GetMapping(Route.V1.CrudExamples.UserApis.SEARCH)
	override fun search(
		@RequestParam("from_date", required = false) fromDate: Instant?,
		@RequestParam("to_date", required = false) toDate: Instant?,
		@RequestParam("q", required = false) query: String?,
		@RequestParam("page", defaultValue = "0") page: Int,
		@RequestParam("size", defaultValue = "10") size: Int,
		@RequestParam("sort_by", defaultValue = "ID") sortBy: String,
		@RequestParam("sort_direction", defaultValue = "DESC") direction: Sort.Direction,
		@RequestParam(required = false) extra: Map<String, String>,
	): ResponseEntity<ResponseData<Page<CrudExampleBriefResponse>>> =
		this.crudExampleService.search(
			username = SecurityContext.getLoggedInUsername(),
			fromDate = fromDate ?: Instant.EPOCH,
			toDate = toDate ?: Instant.now(),
			params = PageableParamsV2(query, page, size, sortBy, direction)
		).toResponse { it.toBriefResponse() }

	@GetMapping(Route.V1.CrudExamples.UserApis.FIND)
	override fun find(@PathVariable("id") id: Long): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
		onSecuredContext { auth ->
			this.crudExampleService.getAsEither(id, asUser = auth)
				.toResponse(debug = debug()) {
					it.toDetailResponse()
				}
		}

	@PostMapping(Route.V1.CrudExamples.UserApis.CREATE)
	override fun create(
		@Valid @RequestBody req: CrudExampleReq
	): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
		onSecuredContext { auth ->
			this.crudExampleService.save(
				entity = req.asCrudExample(),
				asUser = auth
			).toResponse(debug = debug()) {
				it.toDetailResponse()
			}
		}

	@PatchMapping(Route.V1.CrudExamples.UserApis.UPDATE)
	override fun update(
		@PathVariable("id") id: Long,
		@Valid @RequestBody req: CrudExampleReq
	): ResponseEntity<ResponseData<CrudExampleDetailResponse>> =
		onSecuredContext { auth ->
			this.crudExampleService.getAsEither(id, asUser = auth)
				.flatMap {
					this.crudExampleService.save(
						entity = req.asCrudExample(it),
						asUser = auth
					)
				}
				.toResponse(debug = debug()) {
					it.toDetailResponse()
				}
		}

	@DeleteMapping(Route.V1.CrudExamples.UserApis.DELETE)
	override fun delete(
		@PathVariable("id") id: Long
	): ResponseEntity<ResponseData<Boolean>> =
		onSecuredContext { auth ->
			this.crudExampleService.delete(
				id = id, softDelete = true, asUser = auth
			).toResponse(debug = debug()) { it }
		}


	override fun getEnv(): Environment = this.env

}
