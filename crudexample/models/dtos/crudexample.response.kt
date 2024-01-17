package com.example.app.domains.crudexamples.models.dtos

import com.example.app.domains.crudexamples.models.entities.CrudExample

data class CrudExampleBriefResponse(
    val id: Long,
    val title: String
)

fun CrudExample.toBriefResponse(): CrudExampleBriefResponse =
    CrudExampleBriefResponse(
        id = this.id,
        title = this.title
    )

data class CrudExampleDetailResponse(
    val id: Long,
    val title: String,
    val description: String,
    val image: String?
)

fun CrudExample.toDetailResponse(): CrudExampleDetailResponse =
    CrudExampleDetailResponse(
        id = this.id,
        title = this.title,
        description = this.description,
        image = this.image
    )