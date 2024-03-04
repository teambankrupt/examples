package com.example.app.domains.crudexamples.models.dtos

import com.example.app.domains.crudexamples.models.entities.CrudExample

data class CrudExampleBriefResponse(
    val id: Long,

    @field:JsonProperty("created_at")
    val createdAt: Instant,

    @field:JsonProperty("updated_at")
    val updatedAt: Instant? = null,

    val title: String
)

fun CrudExample.toBriefResponse(): CrudExampleBriefResponse =
    CrudExampleBriefResponse(
        id = this.id,
        createdAt = this.createdAt,
        updatedAt = this.updatedAt,
        title = this.title
    )

data class CrudExampleDetailResponse(
    val id: Long,

    @field:JsonProperty("created_at")
    val createdAt: Instant,

    @field:JsonProperty("updated_at")
    val updatedAt: Instant? = null,

    val title: String,

    val description: String,

    val image: String?
)

fun CrudExample.toDetailResponse(): CrudExampleDetailResponse =
    CrudExampleDetailResponse(
        id = this.id,
        createdAt = this.createdAt,
        updatedAt = this.updatedAt,
        title = this.title,
        description = this.description,
        image = this.image
    )