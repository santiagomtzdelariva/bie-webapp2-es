<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><g:layoutTitle /></title>

    <r:require modules="bootstrap3, ekko, uk_bs3"/>
    <r:layoutResources/>
    <g:layoutHead />

    <script src="http://use.typekit.net/whd1tbp.js"></script>
    <script>try{Typekit.load();}catch(e){}</script>

    <!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body class="${pageProperty(name:'body.class')?:''}" id="${pageProperty(name:'body.id')}" onload="${pageProperty(name:'body.onload')}">
<div class="wrap">
    <!-- start UK header -->
    <div class="switcher-bar hidden-xs">
        <div class="site-switcher container">
            <ul>
                <li><a href="http://www.nbn.org.uk/">NBN</a></li>
                <li><a href="https://data.nbn.org.uk/">UK Gateway</a></li>
                <li class="active"><a href="/">UK Wildlife Portal</a></li>
                <li><a href="http://www.consultantsportal.uk/">Consultants Portal</a></li>
                <li><a href="http://forums.nbn.org.uk/">NBN Forum</a></li>
            </ul>
        </div>
    </div>
    <div class="header-bar">
        <header class="container">
            <h2><a href="/">UK Wildlife Portal</a></h2>
            <a class="nbn-logo hidden-sm hidden-xs" href="http://www.nbn.org.uk/"><img src="http://www.cerulean.co.nz/atlas/images/logo-nbn.png" alt="NBN: National Biodiversity Network"></a>
            <nav class="secondary-nav hidden-sm hidden-xs">
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
                    <form>
                        <input type="text" placeholder="Search everything...">
                        <input type="submit" value="Search">
                    </form>
                </div>
            </div>
            <nav class="navbar">
                <div class="navbar-header">
                    <div class="mobile-nav-button navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1"></div>
                </div>
                <div class="collapse navbar-collapse" id="navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="http://ala-demo.gbif.org/bie-webapp2/search">Species</a></li>
                        <li><a href="http://ala-demo.gbif.org/generic-hub/explore/your-area?default=true">Locations</a></li>
                        <li><a href="#">Habitats</a></li>
                        <li><a href="http://ala-demo.gbif.org/generic-hub/search">Records</a></li>
                        <li><a href="#">Data Providers</a></li>
                        <li class="visible-sm visible-xs"><a href="#">Getting Started</a></li>
                        <li class="visible-sm visible-xs"><a href="#">Examples of Use</a></li>
                        <li class="visible-sm visible-xs"><a href="#">Documentation</a></li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>

    <!-- end UK header -->
    <g:layoutBody/>

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
            <div class="div-rule"></div>
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
                    <li><a class="forum-icon text-hide" href="#" title="NBN Forum">NBN Forum</a></li>
                    <li><a class="facebook-icon text-hide" href="#" title="NBN on Facebook">NBN on Facebook</a></li>
                    <li><a class="twitter-icon text-hide" href="#" title="NBN on Twitter">NBN on Twitter</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-bar-bottom">
        <div class="container">
            <p>© National Biodiversity Network 2015 • By using this site you accept to be bound by the UK Wildlife Portal <a href="#">Terms &amp; Conditions</a> and our <a href="#">Cookies &amp; Privacy Policy</a>. Powered by <a href="http://www.ala.org.au/">Atlas of Living Australia</a>.</p>
        </div>
    </div>
</footer>
<!-- end global footer -->
<r:layoutResources/>

</body>
</html>