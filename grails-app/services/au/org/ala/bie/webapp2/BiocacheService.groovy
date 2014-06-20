package au.org.ala.bie.webapp2

class BiocacheService {

    def grailsApplication
    def webService

    def getSoundsForTaxon(taxonName){
        def queryUrl = grailsApplication.config.biocacheService.baseURL + "/occurrences/search?q=" + URLEncoder.encode(taxonName, "UTF-8") + "&fq=multimedia:\"Sound\""
        def data = webService.getJson(queryUrl)
        //log.debug "sound data => " + data
        if(data.size() && data.get("occurrences").size()){
            def recordUrl = grailsApplication.config.biocacheService.baseURL + "/occurrence/" + data.get("occurrences").get(0).uuid
            webService.getJson(recordUrl)
        } else {
            null
        }
    }

    /**
     * @deprecated - done via AJAX now
     * @param etc
     * @return
     */
    def getSpeciesImages(etc) {
        def guid = etc.taxonConcept?.guid?:guid
        def defaultTitle = etc.taxonConcept?.nameString
        def queryUrl = grailsApplication.config.biocacheService.baseURL + "/occurrences/search?q=lsid:" + URLEncoder.encode(guid, "UTF-8") + "&fq=multimedia:\"Image\"&pageSize=100&facet=off&sort=type_status"
        def data = webService.getJson(queryUrl)
        def imageData = []

        if (data.size() && data.get("occurrences").size()) {
            data.occurrences.each { rec ->
                //log.debug "rec = ${rec}"
                def img = [:]
                // categorise the images... using an enum to make it type safe
                if (rec.typeStatus) {
                    img.category = ImageCategory.TYPE
                } else if (rec.basisOfRecord =~ /(?i)PreservedSpecimen/) {
                    img.category = ImageCategory.SPECIMEN
                } else {
                    img.category = ImageCategory.OTHER
                }
                //img.isBlackListed = false
                img.creator = rec.collector
                img.name = rec.raw_scientificName
                img.title = rec.raw_scientificName?:defaultTitle
                img.type = rec.typeStatus
                img.taxonRankID = rec.taxonRankID
                img.infoSourceURL = rec.occurrenceID // TODO: check its a URL
                img.infoSourceName = rec.dataResourceName
                img.institutionName = rec.institutionName
                img.occurrenceUid = rec.uuid
                img.catalogNumber = rec.raw_catalogNumber
                img.collectionCode = rec.raw_collectionCode
                img.eventDate = rec.eventDate ? new Date(rec.eventDate) : null
                img.largeImageUrl = rec.largeImageUrl
                img.smallImageUrl = rec.smallImageUrl
                imageData.add(img)
            }
        } else {
            log.info "No image records found for guid: ${guid} = ${data.totalRecords}"
        }

        imageData //  imageData.sort{ a, b -> b.type <=> a.type } // sort with type images first
    }

    /**
     * Enum for image categories
     */
    public enum ImageCategory {
        TYPE, SPECIMEN, OTHER
    }
}
