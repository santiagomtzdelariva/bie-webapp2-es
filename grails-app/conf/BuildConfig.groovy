grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.work.dir = "target"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.fork = [
        test: false,
        run: false
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        mavenLocal()
        mavenRepo ("http://nexus.ala.org.au/content/groups/public/") {
            updatePolicy 'always'
        }
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        compile("au.org.ala:bie-profile:1.1-SNAPSHOT") {
            transitive = false
        }
        compile("au.org.ala:ala-name-matching:2.1") {
            excludes "lucene-core", "lucene-analyzers-common", "lucene-queryparser", "simmetrics"
        }

        compile "commons-httpclient:commons-httpclient:3.1",
//                "atg:json-taglib:0.4.1",
                "org.codehaus.jackson:jackson-core-asl:1.8.6",
                "org.codehaus.jackson:jackson-mapper-asl:1.8.6"
//        compile group:'au.org.ala',
//                name:'ala-cas-client',
//                version:'1.0-SNAPSHOT',
//                transitive:false
        compile 'org.jasig.cas.client:cas-client-core:3.1.12'
        runtime 'org.jsoup:jsoup:1.7.2'
        // runtime 'mysql:mysql-connector-java:5.1.16'
    }

    plugins {
        runtime ":hibernate:3.6.10.15"
        runtime ":jquery:1.7.2"
        runtime ":resources:1.2.8"
        // Uncomment these (or add new ones) to enable additional resources capabilities
        //runtime ":zipped-resources:1.0"
        //runtime ":yui-minify-resources:0.1.4"
        // Moved these plugins from application.properties file
        compile ':cache:1.0.1'
        //runtime ":cached-resources:1.1"
        //runtime ":cache-headers:1.1.6"
        runtime ":rest:0.8"

        compile(":ala-web-theme:[0.1,1.0)") {
            excludes "jquery","resources","cache","servlet-api"
        }

        build ":tomcat:7.0.53"
    }
}
