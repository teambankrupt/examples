package com.example.app.domains.crudexamples.models.entities

import com.example.coreweb.domains.base.entities.BaseEntityV2
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "crudexamples", schema = "app")
class CrudExample : BaseEntityV2() {

    @Column(name = "title", nullable = false)
    var title: String = ""

    @Column(name = "description", nullable = false)
    var description: String = ""

    @Column(name = "image")
    var image: String? = null

}