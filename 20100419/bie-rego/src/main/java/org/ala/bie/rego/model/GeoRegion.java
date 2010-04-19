package org.ala.bie.rego.model;


@javax.persistence.Entity
@org.springframework.roo.addon.javabean.RooJavaBean
@org.springframework.roo.addon.tostring.RooToString
@org.springframework.roo.addon.entity.RooEntity(identifierField = "id", identifierColumn = "id")
@javax.persistence.Table(name = "geo_region")
public class GeoRegion {

    @javax.validation.constraints.NotNull
    @javax.validation.constraints.Size(min = 2)
    private String name;

    @javax.validation.constraints.NotNull
    @javax.validation.constraints.Size(min = 2)
    private String regionType;
}
