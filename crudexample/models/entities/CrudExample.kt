package com.example.app.domains.crudexample.models.entities

import com.example.coreweb.domains.base.entities.BaseEntityV2
import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "crudexamples")
class CrudExample : BaseEntityV2() {
}