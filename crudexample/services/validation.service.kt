package com.example.app.domains.crudexamples.services

import com.example.app.domains.crudexamples.models.entities.CrudExample
import com.example.common.validation.ValidationScope
import com.example.common.validation.genericValidation

val titleValidation = genericValidation<CrudExample>(
    message = "Title must be at least 3 characters long!",
    instruction = "Please provide a title with at least 3 characters!",
    scopes = setOf(ValidationScope.Write, ValidationScope.Modify)
) {
    it.title.length >= 3
}