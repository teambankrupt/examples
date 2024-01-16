package com.example.app.domains.crudexamples.services

import arrow.core.Option
import com.example.app.domains.crudexamples.models.entities.CrudExample
import com.example.app.domains.crudexamples.repositories.CrudExampleRepository
import com.example.auth.entities.UserAuth
import com.example.common.exceptions.toArrow
import com.example.common.validation.ValidationV2
import com.example.coreweb.domains.base.services.CrudServiceV5
import com.example.coreweb.utils.PageAttr
import com.example.coreweb.utils.PageableParams
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.domain.Page
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Service
import java.time.Instant

interface CrudExampleService : CrudServiceV5<CrudExample> {
    fun search(
        username: String?,
        fromDate: Instant, toDate: Instant,
        params: PageableParams
    ): Page<CrudExample>
}

@Service
class CrudExampleServiceBean @Autowired constructor(
    private val crudExampleRepository: CrudExampleRepository
) : CrudExampleService {
    override fun search(
        username: String?,
        fromDate: Instant,
        toDate: Instant,
        params: PageableParams
    ): Page<CrudExample> = this.crudExampleRepository.search(
        query = params.query,
        username = username,
        fromDate = fromDate,
        toDate = toDate,
        pageable = PageAttr.getPageRequest(params)
    )

    override fun validations(asUser: UserAuth): Set<ValidationV2<CrudExample>> = setOf(
        titleValidation
    )

    override fun find(id: Long, asUser: UserAuth): Option<CrudExample> =
        this.crudExampleRepository.find(id).toArrow()

    override fun getRepository(): JpaRepository<CrudExample, Long> = this.crudExampleRepository

}