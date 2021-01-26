package com.example.app.domains.crudexample.models.mappers

import com.example.app.domains.crudexample.models.dtos.CrudExampleDto
import com.example.app.domains.crudexample.models.entities.CrudExample
import com.example.coreweb.domains.base.models.mappers.BaseMapper
import org.springframework.stereotype.Component

@Component
class CrudExampleMapper : BaseMapper<CrudExample, CrudExampleDto> {

    override fun map(entity: CrudExample): CrudExampleDto {
        val dto = CrudExampleDto()

        dto.apply {
            this.id = entity.id
            this.createdAt = entity.createdAt
            this.updatedAt = entity.updatedAt
        }

        return dto
    }

    override fun map(dto: CrudExampleDto, exEntity: CrudExample?): CrudExample {
        val entity = exEntity ?: CrudExample()

        entity.apply {

        }

        return entity
    }
}