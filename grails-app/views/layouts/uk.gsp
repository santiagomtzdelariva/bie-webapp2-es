<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><g:layoutTitle /></title>
    <style>
    #page-header .inner { display: none;}
    .inner-search-form { display: none;}
    </style>
    <r:require modules="bootstrap2, pagination, uk"/>
    <r:layoutResources/>
    <g:layoutHead />
    <!-- Robins imports -->
    <script src="http://use.typekit.net/whd1tbp.js"></script>
    <script>try{Typekit.load();}catch(e){}</script>
    <script src="http://www.cerulean.co.nz/atlas/js/uk-wildlife.js"></script>
    <!-- end of Robins imports -->
    <!--[if lt IE 9]>
	<script src="bootstrap/js/html5shiv.js"></script>
    <![endif]-->
</head>
<body class="${pageProperty(name:'body.class')?:''}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">
<div class="wrap">
    <!-- start global header -->
    <div class="switcher-bar">
        <div class="site-switcher container">
            <ul>
                <li><a href="http://www.nbn.org.uk/">NBN</a></li>
                <li><a href="https://data.nbn.org.uk/">UK Gateway</a></li>
                <li class="active"><a href="/">${grailsApplication.config.skin.orgNameLong}</a></li>
                <li><a href="http://www.consultantsportal.uk/">Consultants Portal</a></li>
                <li><a href="http://forums.nbn.org.uk/">NBN Forum</a></li>
            </ul>
        </div>
    </div>
    <div class="header-bar">
        <header class="container">
            <h1><a href="/">${grailsApplication.config.skin.orgNameLong}</a></h1>
            <a class="nbn-logo" href="http://www.nbn.org.uk/"><img src="http://www.cerulean.co.nz/atlas/images/logo-nbn.png" alt="NBN: National Biodiversity Network"></a>
            <nav class="secondary-nav visible-desktop">
                <ul>
                    <li><a href="#">Getting Started</a></li>
                    <li><a href="#">Examples of Use</a></li>
                    <li><a href="#">Documentation</a></li>
                </ul>
            </nav>
        </header>
    </div>
    <div class="navigation-bar">
        <div class="container">
            <div class="global-search">
                <div class="global-search-box">
                    <g:form controller="species" action="search" method="get">
                        <input type="text" name="q" placeholder="Search everything..." value="${params.q}">
                        <input type="submit" value="Search">
                    </g:form>
                </div>
            </div>
            <div class="navbar">
                <div class="navbar-inner">
                    <div class="container">
                        <div class="mobile-nav-button hidden-desktop" data-toggle="collapse" data-target=".nav-collapse"></div>
                        <nav class="nav-collapse collapse">
                            <ul class="nav">
                                <li><g:link controller="species" action="search">Species</g:link></li>
                                <li><a href="${grailsApplication.config.biocache.baseURL}/explore/your-area?default=true">Locations</a></li>
                                <li><a href="#">Habitats</a></li>
                                <li><a href="${grailsApplication.config.biocache.baseURL}/search">Records</a></li>
                                <li><a href="${grailsApplication.config.collectory.baseURL}/datasets">Data Providers</a></li>
                                <li class="hidden-desktop"><a href="#">Getting Started</a></li>
                                <li class="hidden-desktop"><a href="#">Examples of Use</a></li>
                                <li class="hidden-desktop"><a href="#">Documentation</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end global header -->
    <div class="main-content container content">
        <g:layoutBody />
    </div><!-- end main-content -->
    <div class="push"></div>
 </div><!-- end wrap -->

<!-- start global footer -->
<footer class="site-footer">
    <div class="footer-bar-top">
        <div class="footer-row-1 container">
            <nav class="footer-nav-1">
                <ul>
                    <li><a href="http://ala-demo.gbif.org/bie-webapp2/search">Species</a></li>
                    <li><a href="http://ala-demo.gbif.org/generic-hub/explore/your-area?default=true">Locations</a></li>
                    <li><a href="#">Habitats</a></li>
                    <li><a href="http://ala-demo.gbif.org/generic-hub/search">Records</a></li>
                    <li><a href="#">Data Providers</a></li>
                </ul>
            </nav>
            <nav class="footer-nav-2">
                <ul>
                    <li><a href="#">Getting Started</a></li>
                    <li><a href="#">Examples of Use</a></li>
                    <li><a href="#">Documentation</a></li>
                </ul>
            </nav>
        </div>
        <div class="footer-row-2 container">
            <nav class="footer-nav-3">
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Terms &amp; Conditions</a></li>
                    <li><a href="#">Cookies &amp; Privacy Policy</a></li>
                    <li><a href="#">Website Credits</a></li>
                </ul>
            </nav>
            <div class="social-links">
                <h5>Join the Conversation:</h5>
                <ul>
                    <li><a class="forum-icon hide-text" href="#" title="NBN Forum">NBN Forum</a></li>
                    <li><a class="facebook-icon hide-text" href="#" title="NBN on Facebook">NBN on Facebook</a></li>
                    <li><a class="twitter-icon hide-text" href="#" title="NBN on Twitter">NBN on Twitter</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-bar-bottom">
        <div class="container">
            <p>© National Biodiversity Network 2015 • By using this site you accept to be bound by the ${grailsApplication.config.skin.orgNameLong} <a href="#">Terms &amp; Conditions</a> and our <a href="#">Cookies &amp; Privacy Policy</a>. Powered by <a href="http://www.ala.org.au/">Atlas of Living Australia</a>.</p>
        </div>
    </div>
</footer>
<!-- end global footer -->
<r:layoutResources/>
</body>
</html>