package com.example.app.domains.crudexample.services.beans

import com.example.app.domains.crudexample.models.entities.CrudExample
import com.example.app.domains.crudexample.repositories.CrudExampleRepository
import com.example.app.domains.crudexample.services.CrudExampleService
import com.example.common.utils.ExceptionUtil
import com.example.coreweb.utils.PageAttr
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.stereotype.Service
import java.util.*
import com.example.coreweb.domains.base.models.enums.SortByFields
import org.springframework.data.domain.Sort
import com.example.coreweb.utils.PageableParams

@Service
class CrudExampleServiceBean @Autowired constructor(
    private val crudExampleRepository: CrudExampleRepository
) : CrudExampleService {

    override fun search(params: PageableParams): Page<CrudExample> {
        return this.crudExampleRepository.search(params.query, PageAttr.getPageRequest(params))
    }

    override fun save(entity: CrudExample): CrudExample {
        this.validate(entity)
        return this.crudExampleRepository.save(entity)
    }

    override fun find(id: Long): Optional<CrudExample> {
        return this.crudExampleRepository.find(id)
    }

    override fun delete(id: Long, softDelete: Boolean) {
        val entity = this.find(id).orElseThrow { ExceptionUtil.notFound("CrudExample", id) }
        if (SecurityContext.getCurrentUser().isAdmin.not() && !entity.isMine) {
            throw ExceptionUtil.forbidden("You are not allowed to delete it!")
        }
        if (softDelete) {
            entity.isDeleted = true
            this.crudExampleRepository.save(entity)
            return
        }
        this.crudExampleRepository.deleteById(id)
    }

    override fun validate(entity: CrudExample) {
        TODO("Not yet implemented")
    }
}