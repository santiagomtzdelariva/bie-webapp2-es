package au.org.ala.bie.webapp2

class BiocacheService {

    def grailsApplication
    def webService

    def serviceMethod() {}

    def getSoundsForTaxon(taxonName){
        def queryUrl = grailsApplication.config.biocacheService.baseURL + "/occurrences/search?q=" + URLEncoder.encode(taxonName, "UTF-8") + "&fq=multimedia:\"Sound\""
        def data = webService.getJson(queryUrl)
        log.debug "sound data => " + data
        if(data.size() && data.get("occurrences").size()){
            def recordUrl = grailsApplication.config.biocacheService.baseURL + "/occurrence/" + data.get("occurrences").get(0).uuid
            webService.getJson(recordUrl)
        } else {
            null
        }
    }

    def getSpeciesImages(etc) {
        def guid = etc.taxonConcept?.guid?:guid
        def defaultTitle = etc.taxonConcept?.nameString
        def queryUrl = grailsApplication.config.biocacheService.baseURL + "/occurrences/search?q=lsid:" + URLEncoder.encode(guid, "UTF-8") + "&fq=multimedia:\"Image\"&pageSize=100&facet=off"
        def data = webService.getJson(queryUrl)
        def imageData = []

        if(data.size() && data.get("occurrences").size()){
            data.occurrences.each { rec ->
                def img = [:]
                img.title = defaultTitle // TODO index title from image
                img.creator = rec.collector
                img.infoSourceURL = rec.occurrenceID // TODO: check its a URL
                img.infoSourceName = rec.dataResourceName
                img.occurrenceUid = rec.uuid
                img.largeImageUrl = rec.largeImageUrl
                img.smallImageUrl = rec.smallImageUrl
                imageData.add(img)
            }
        } else {
            log.info "No image records found for guid: ${guid} = ${data.totalRecords}"
        }

        imageData
    }
}
