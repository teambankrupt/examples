package com.example.app.domains.crudexamples.models.dtos

import com.example.app.domains.crudexamples.models.entities.CrudExample

data class CrudExampleReq(
    val title: String,
    val description: String,
    val image: String?
) {
    fun asCrudExample(crudExample: CrudExample = CrudExample()): CrudExample =
        this.let { req ->
            crudExample.apply {
                this.title = req.title
                this.description = req.description
                this.image = req.image
            }
        }
}