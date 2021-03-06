package com.example.app.domains.crudexample.controllers.web

import com.example.app.domains.crudexample.models.dtos.CrudExampleDto
import com.example.app.domains.crudexample.models.mappers.CrudExampleMapper
import com.example.app.domains.crudexample.services.CrudExampleService
import com.example.app.routing.Route
import com.example.common.utils.ExceptionUtil
import com.example.coreweb.domains.base.controllers.CrudWebControllerV3
import com.example.coreweb.domains.base.models.enums.SortByFields
import org.springframework.data.domain.Sort
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.*
import org.springframework.web.servlet.mvc.support.RedirectAttributes
import javax.validation.Valid
import com.example.coreweb.utils.PageableParams

@Controller
class CrudExampleWebController @Autowired constructor(
        private val crudExampleService: CrudExampleService,
        private val crudExampleMapper: CrudExampleMapper
) : CrudWebControllerV3<CrudExampleDto> {

    /*
        COPY THESE URLS TO ROUTE FILE AND ADJUST
        ------------------------------------------------------
        // CrudExamples (Web)
        const val WEB_SEARCH_CRUDEXAMPLES = "/crudexamples"
        const val WEB_CREATE_CRUDEXAMPLE_PAGE = "/crudexamples/create"
        const val WEB_CREATE_CRUDEXAMPLE = "/crudexamples"
        const val WEB_FIND_CRUDEXAMPLE = "/crudexamples/{id}"
        const val WEB_UPDATE_CRUDEXAMPLE_PAGE = "/crudexamples/{id}/update"
        const val WEB_UPDATE_CRUDEXAMPLE = "/crudexamples/{id}"
        const val WEB_DELETE_CRUDEXAMPLE = "/crudexamples/{id}/delete"
        ------------------------------------------------------
    */

    @GetMapping(Route.V1.WEB_SEARCH_CRUDEXAMPLES)
    override fun search(@RequestParam("q", required = false) query: String?,
                        @RequestParam("page", defaultValue = "0") page: Int,
                        @RequestParam("size", defaultValue = "10") size: Int,
                        @RequestParam("sort_by", defaultValue = "ID") sortBy: SortByFields,
                        @RequestParam("sort_direction", defaultValue = "DESC") direction: Sort.Direction,
                        model: Model): String {
        val entities = this.crudExampleService.search(PageableParams.of(query, page, size, sortBy, direction))
        model.addAttribute("crudexamples", entities.map { this.crudExampleMapper.map(it) })
        return "crudexamples/fragments/all"
    }

    @GetMapping(Route.V1.WEB_FIND_CRUDEXAMPLE)
    override fun find(@PathVariable("id") id: Long,
                      model: Model): String {
        val entity = this.crudExampleService.find(id).orElseThrow { ExceptionUtil.notFound("CrudExample", id) }
        model.addAttribute("crudexample", this.crudExampleMapper.map(entity))
        return "crudexamples/fragments/details"
    }

    @GetMapping(Route.V1.WEB_CREATE_CRUDEXAMPLE_PAGE)
    override fun createPage(model: Model): String {
        return "crudexamples/fragments/create"
    }

    @PostMapping(Route.V1.WEB_CREATE_CRUDEXAMPLE)
    override fun create(@Valid @ModelAttribute dto: CrudExampleDto,
                        redirectAttributes: RedirectAttributes): String {
        val entity = this.crudExampleService.save(this.crudExampleMapper.map(dto, null))
        redirectAttributes.addFlashAttribute("message", "Success!!")
        return "redirect:${Route.V1.WEB_FIND_CRUDEXAMPLE.replace("{id}", entity.id.toString())}"
    }

    @GetMapping(Route.V1.WEB_UPDATE_CRUDEXAMPLE_PAGE)
    override fun updatePage(@PathVariable("id") id: Long, model: Model): String {
        val entity = this.crudExampleService.find(id).orElseThrow { ExceptionUtil.notFound("CrudExample", id) }
        model.addAttribute("crudexample", this.crudExampleMapper.map(entity))
        return "crudexamples/fragments/create"
    }

    @PostMapping(Route.V1.WEB_UPDATE_CRUDEXAMPLE)
    override fun update(@PathVariable("id") id: Long,
                        @Valid @ModelAttribute dto: CrudExampleDto,
                        redirectAttributes: RedirectAttributes): String {
        var entity = this.crudExampleService.find(id).orElseThrow { ExceptionUtil.notFound("CrudExample", id) }
        entity = this.crudExampleService.save(this.crudExampleMapper.map(dto, entity))
        redirectAttributes.addFlashAttribute("message", "Success!!")
        return "redirect:${Route.V1.WEB_FIND_CRUDEXAMPLE.replace("{id}", entity.id.toString())}"
    }

    @PostMapping(Route.V1.WEB_DELETE_CRUDEXAMPLE)
    override fun delete(@PathVariable("id") id: Long,
                        redirectAttributes: RedirectAttributes): String {
        this.crudExampleService.delete(id, true)
        redirectAttributes.addFlashAttribute("message", "Deleted!!")
        return "redirect:${Route.V1.WEB_SEARCH_CRUDEXAMPLES}";
    }

}
