def appName = 'bie-webapp2'
def ENV_NAME = "${appName.toUpperCase()}_CONFIG"
default_config = "/data/${appName}/config/${appName}-config.properties"
if(!grails.config.locations || !(grails.config.locations instanceof List)) {
    grails.config.locations = []
}
if(System.getenv(ENV_NAME) && new File(System.getenv(ENV_NAME)).exists()) {
    println "[${appName}] Including configuration file specified in environment: " + System.getenv(ENV_NAME);
    grails.config.locations.add "file:" + System.getenv(ENV_NAME)
} else if(System.getProperty(ENV_NAME) && new File(System.getProperty(ENV_NAME)).exists()) {
    println "[${appName}] Including configuration file specified on command line: " + System.getProperty(ENV_NAME);
    grails.config.locations.add "file:" + System.getProperty(ENV_NAME)
} else if(new File(default_config).exists()) {
    println "[${appName}] Including default configuration file: " + default_config;
    grails.config.locations.add "file:" + default_config
} else {
    println "[${appName}] No external configuration file defined."
}

grails.project.groupId = 'au.org.ala'
/******************************************************************************\
 *  EXTERNAL SERVERS
 \******************************************************************************/
runWithNoExternalConfig = true

if(!bie.baseURL){
    bie.baseURL = "http://bie.ala.org.au"
}
if(!bie.searchPath){
    bie.searchPath = "/search"
}
if(!biocache.baseURL){
    biocache.baseURL = "http://biocache.ala.org.au"
}
if(!biocacheService.baseURL){
    biocacheService.baseURL = "http://biocache.ala.org.au/ws"
}
if(!spatial.baseURL){
    spatial.baseURL = "http://spatial.ala.org.au"
}
if(!ala.baseURL){
    ala.baseURL = "http://www.ala.org.au"
}
if(!collectory.baseURL){
    collectory.baseURL = "http://collections.ala.org.au"
}
if(!bhl.baseURL){
    bhl.baseURL = "http://bhlidx.ala.org.au"
}
if(!speciesList.baseURL){
    speciesList.baseURL = "http://lists.ala.org.au"
}
if(!userDetails.url){
    userDetails.url ="http://auth.ala.org.au/userdetails/userDetails/"
}
if(!userDetails.path){
    userDetails.path ="getUserList"
}
if(!alerts.baseUrl){
    alerts.baseUrl = "http://alerts.ala.org.au/ws/"
}
if(!brds.guidUrl){
    brds.guidUrl = "http://sightings.ala.org.au/"
}
if(!collectory.threatenedSpeciesCodesUrl){
    collectory.threatenedSpeciesCodesUrl = collectory.baseURL + "/public/showDataResource"
}
if(!ranking.readonly){
    ranking.readonly = true // revert when ranking of images is fixed
}
if(!headerAndFooter.baseURL){
    headerAndFooter.baseURL = 'http://www2.ala.org.au/commonui'
}

/******************************************************************************\
 *  SECURITY
 \******************************************************************************/
if(!security.cas.casServerName){
    security.cas.casServerName = 'https://auth.ala.org.au'
}
if(!security.cas.uriFilterPattern ){
    security.cas.uriFilterPattern = "/admin, /admin/.*"// pattern for pages that require authentication
}
if(!security.cas.uriExclusionFilterPattern){
    security.cas.uriExclusionFilterPattern = "/images.*,/css.*/less.*,/js.*,.*json,.*xml"
}
if(!security.cas.authenticateOnlyIfLoggedInPattern){
    security.cas.authenticateOnlyIfLoggedInPattern = "/species/.*" // pattern for pages that can optionally display info about the logged-in user
}
if(!security.cas.loginUrl){
    security.cas.loginUrl = 'https://auth.ala.org.au/cas/login'
}
if(!security.cas.logoutUrl){
    security.cas.logoutUrl = 'https://auth.ala.org.au/cas/logout'
}
if(!security.cas.casServerUrlPrefix){
    security.cas.casServerUrlPrefix = 'https://auth.ala.org.au/cas'
}
if(!security.cas.bypass){
    security.cas.bypass = false
}
if(!auth.admin_role){
    auth.admin_role = "ROLE_ADMIN"
}
if(!skin.layout){
    skin.layout = "generic"
}


nonTruncatedSources = ["http://www.environment.gov.au/biodiversity/abrs/online-resources/flora/main/index.html"]

springcache {
    defaults {
        // set default cache properties that will apply to all caches that do not override them
        eternal = false
        diskPersistent = false
        timeToLive = 600
        timeToIdle = 600
    }
    caches {
        userListCache {
            // set any properties unique to this cache
            memoryStoreEvictionPolicy = "LRU"
        }
    }
}

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      //xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      //json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

grails.project.war.file = "bie-webapp2.war"
// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart = false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// enable query caching by default
grails.hibernate.cache.queries = true

// set per-environment serverURL stem for creating absolute links
environments {
    development {
        grails.logging.jul.usebridge = true
        grails.host = "http://dev.ala.org.au"
        grails.serverURL = "${grails.host}:8080/${appName}"
        //bie.baseURL = grails.serverURL
        security.cas.appServerName = "${grails.host}:8090"
        security.cas.contextPath = "/${appName}"
        // cached-resources plugin - keeps original filenames but adds cache-busting params
        grails.resources.debug = true
      //  bie.baseURL = "http://diasbtest1-cbr.vm.csiro.au:8080/bie-service"
    }
    test {
        grails.logging.jul.usebridge = false
        grails.host = "bie-test.ala.org.au"
        grails.serverURL = "http://bie-test.ala.org.au"
        security.cas.appServerName = grails.serverURL
        security.cas.contextPath = ""
        //log4j.appender.'errors.File'="/var/log/tomcat/biewebapp2-stacktrace.log"
    }
    production {
        grails.logging.jul.usebridge = false
        grails.host = "bie.ala.org.au"
        grails.serverURL = "http://bie.ala.org.au"
        security.cas.appServerName = grails.serverURL
        security.cas.contextPath = ""
        //log4j.appender.'errors.File'="/var/log/tomcat6/biewebapp2-stacktrace.log"
    }
}

logging_dir = (System.getProperty('catalina.base') ? System.getProperty('catalina.base') + '/logs'  : '/var/log/tomcat6')

// log4j configuration
log4j = {
    appenders {
        environments {
            production {
                rollingFile name: "bie-prod",
                    maxFileSize: 104857600,
                    file: logging_dir + "/bie.log",
                    threshold: org.apache.log4j.Level.DEBUG,
                    layout: pattern(conversionPattern: "%-5p: %d [%c{1}]  %m%n")
                rollingFile name: "stacktrace",
                    maxFileSize: 1024,
                    file: logging_dir + "/bie-stacktrace.log"
            }
            development{
                console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}]  %m%n"),
                    threshold: org.apache.log4j.Level.DEBUG
            }
        }
    }

    root {
        debug  'bie-prod'
    }

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.springframework.jdbc',
           'org.springframework.transaction',
           'org.codehaus.groovy',
           'org.grails',
           'org.grails.plugin.resource',
           'org.apache',
           'grails.spring',
           'au.org.ala.cas',
           'grails.util.GrailsUtil',
           'net.sf.ehcache',
           'org.grails.plugin',
           'org.grails.plugin.resource',
           'org.grails.plugin.resource.ResourceTagLib',
           'org.grails.plugin.cachedresources',
           'grails.app.services.org.grails.plugin.resource',
           'grails.app.taglib.org.grails.plugin.resource',
           'grails.app.resourceMappers.org.grails.plugin.resource'
    debug  'au.org.ala.bie.webapp2'
}
// Uncomment and edit the following lines to start using Grails encoding & escaping improvements

/* remove this line 
// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside null
                scriptlet = 'none' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        filteringCodecForContentType {
            //'text/html' = 'html'
        }
    }
}
remove this line */
