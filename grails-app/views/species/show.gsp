%{--
  - Copyright (C) 2014 Atlas of Living Australia
  - All Rights Reserved.
  -
  - The contents of this file are subject to the Mozilla Public
  - License Version 1.1 (the "License"); you may not use this file
  - except in compliance with the License. You may obtain a copy of
  - the License at http://www.mozilla.org/MPL/
  -
  - Software distributed under the License is distributed on an "AS
  - IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  - implied. See the License for the specific language governing
  - rights and limitations under the License.
  --}%
<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="alaUrl" value="${grailsApplication.config.ala.baseURL}"/>
<g:set var="biocacheUrl" value="${grailsApplication.config.biocache.baseURL}"/>
<g:set var="speciesListUrl" value="${grailsApplication.config.speciesList.baseURL}"/>
<g:set var="spatialPortalUrl" value="${grailsApplication.config.spatial.baseURL}"/>
<g:set var="collectoryUrl" value="${grailsApplication.config.collectory.baseURL}"/>
<g:set var="citizenSciUrl" value="${grailsApplication.config.brds.guidUrl}"/>
<g:set var="guid" value="${tc?.previousGuid?:tc?.taxonConcept?.guid?:''}"/>
<g:set var="sciNameFormatted"><bie:formatSciName name="${tc?.taxonConcept?.nameString}" rankId="${tc?.taxonConcept?.rankID?:0}"/></g:set>
<g:set var="synonymsQuery"><g:each in="${tc?.synonyms}" var="synonym" status="i">\"${synonym.nameString}\"<g:if test="${i < tc.synonyms.size() - 1}"> OR </g:if></g:each></g:set>
<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="${true}" />
    <title>${tc?.taxonConcept?.nameString} ${(tc?.commonNames) ? ' : ' + tc?.commonNames?.get(0)?.nameString : ''} | ${raw(grailsApplication.config.skin.orgNameLong)}</title>
    <r:script disposition='head'>
        // global var to pass GSP vars into JS file
        var SHOW_CONF = {
            biocacheUrl:        "${grailsApplication.config.biocache.baseURL}",
            biocacheServiceUrl: "${grailsApplication.config.biocacheService.baseURL}",
            collectoryUrl:      "${grailsApplication.config.collectory.baseURL}",
            guid:               "${guid}",
            scientificName:     "${tc?.taxonConcept?.nameString?:''}",
            synonymsQuery:      "${synonymsQuery}",
            citizenSciUrl:      "${citizenSciUrl}",
            serverName:         "${grailsApplication.config.grails.serverURL}",
            bieUrl:             "${grailsApplication.config.bie.baseURL}",
            alertsUrl:          "${grailsApplication.config.alerts.baseUrl}",
            remoteUser:         "${request.remoteUser?:''}",
            eolUrl:             "${createLink(controller: 'externalSite', action:'eol',params:[s:tc?.taxonConcept?.nameString?:''])}",
            genbankUrl:         "${createLink(controller: 'externalSite', action:'genbank',params:[s:tc?.taxonConcept?.nameString?:''])}",
            scholarUrl:         "${createLink(controller: 'externalSite', action:'scholar',params:[s:tc?.taxonConcept?.nameString?:''])}",
            soundUrl:           "${createLink(controller: 'species', action:'soundSearch',params:[s:tc?.taxonConcept?.nameString?:''])}"
        }
        // load google charts api
        google.load("visualization", "1", {packages:["corechart"]});

        $(function(){
            $.ajax({url: SHOW_CONF.eolUrl}).done(function ( data ) {
                console.log(data);
                console.log('Loading EOL content - ' + data.dataObjects.length);
                //clone a description template...
                if(data.dataObjects){
                    console.log('Loading EOL content - ' + data.dataObjects.length);
                    $.each(data.dataObjects, function(idx, dataObject){
                        if(dataObject.language == "${grailsApplication.config.eol.lang}"){
                            var $description = $('#descriptionTemplate').clone()
                            $description.css({'display':'block'});
                            $description.attr('id', dataObject.id);
                            $description.find(".title").html(dataObject.title);
                            $description.find(".content").html(dataObject.description);
                            $description.find(".sourceLink").attr('href',dataObject.source);
                            $description.find(".sourceLink").html(dataObject.rightsHolder)
                            $description.find(".rights").html(dataObject.rights)
                            $description.find(".providedBy").attr('href', 'http://eol.org/pages/' + data.identifier);
                            $description.find(".providedBy").html("Encyclopedia of Life")
                            $description.appendTo('#descriptiveContent');
                        }
                    });
                }
            });

            $.ajax({url: SHOW_CONF.genbankUrl}).done(function ( data ) {
                $('#genbankResultCount').html('-  <a href="' + data.resultsUrl + '"> view all results - ' + data.total + '</a>');
                if(data.results){
                    $.each(data.results, function(idx, result){
                       $('#genbank').append('<tr><td>'+
                            '<a class="externalLink" href="' + result.link + '">' + result.title + '</a><br/>' +
                            '<span class="">' + result.description + '</span><br/>' +
                            '<span class="">' + result.furtherDescription +'</span></td></tr>');
                    });
                }
            });

            $.ajax({url: SHOW_CONF.soundUrl}).done(function ( data ) {
                if(data.sounds){
                    $('#sounds').append('<h3 style="clear:left;">Sounds</h3>');
                    $('#sounds').append('<audio src="' + data.sounds[0].alternativeFormats['audio/mpeg'] + '" preload="auto" />' );
                    audiojs.events.ready(function() {
                        var as = audiojs.createAll();
                    });
                    var source = "";
                    if(data.processed.attribution.collectionName){
                        source = data.processed.attribution.collectionName
                    } else {
                        source = data.processed.attribution.dataResourceName
                    }
                    $('#sounds').append('<span>Source: ' + source + '</span><br/>' );
                    $('#sounds').append('<span><a href="${biocacheUrl}/occurrence/'+ data.raw.uuid +'">View more details of this audio</a></span>' );
                }
            }).fail(function(jqXHR, textStatus, errorThrown) {
                //alert( "error" + errorThrown);
            });

            loadMap();

            showSpeciesPage();
        })

        function loadMap() {

            //add an occurrence layer for macropus
            var macropus = L.tileLayer.wms("http://ala-demo.gbif.org/biocache-service/mapping/wms/reflect?q=" + SHOW_CONF.scientificName, {
                layers: 'ALA:occurrences',
                format: 'image/png',
                transparent: true,
                attribution: "${raw(orgNameLong)}",
                bgcolor: "0x000000",
                outline: "true",
                ENV: "color:5574a6;name:circle;size:4;opacity:1"
            });

            var speciesLayers = new L.LayerGroup();
            macropus.addTo(speciesLayers);

            var map = L.map('leafletMap', {
                center: [54.6, -3.2],
                zoom: 5,
                layers: [speciesLayers]
            });

            var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                    'Imagery © <a href="http://mapbox.com">Mapbox</a>';
            var mbUrl = 'https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png';
            var defaultBaseLayer = L.tileLayer(mbUrl, {id: 'examples.map-20v6611k', attribution: mbAttr});

            defaultBaseLayer.addTo(map);

            var baseLayers = {
                "Default": defaultBaseLayer
            };

            var overlays = {
                "Species layer": macropus
            };

            L.control.layers(baseLayers, overlays).addTo(map);

            map.on('click', onMapClick);
            map.invalidateSize(false);
        }

        function onMapClick(e) {
            $.ajax({
                url: SHOW_CONF.biocacheServiceUrl + "/occurrences/info",
                jsonp: "callback",
                dataType: "jsonp",
                data: {
                    q: SHOW_CONF.scientificName,
                    zoom: "6",
                    lat: e.latlng.lat,
                    lon: e.latlng.lng,
                    radius: 20,
                    format: "json"
                },
                success: function (response) {
                    var popup = L.popup()
                            .setLatLng(e.latlng)
                            .setContent("Occurrences at this point: " + response.count)
                            .openOn(map);
                }
            });
        }
    </r:script>
    <r:require module="show"/>
</head>
<body class="species-page">

        <header id="page-header" class="heading-bar">
            <div class="inner row-fluid">
                <div id="breadcrumb" class="span12">
                    <ol class="breadcrumb">
                        <li><a href="${alaUrl}">Home</a> <span class=" icon icon-arrow-right"></span></li>
                        <li><g:link controller="species" action="search">Species</g:link> <span class=" icon icon-arrow-right"></span></li>
                        <li class="active"><bie:formatSciName name="${tc?.taxonConcept?.nameString}" rankId="${tc?.taxonConcept?.rankID?:0}"/></li>
                    </ol>
                </div>
            </div>
            <hgroup class="row-fluid">
                <div class="span9">
                    <h1><bie:formatSciName name="${tc?.taxonConcept?.nameString}" rankId="${tc?.taxonConcept?.rankID?:0}"/>
                        <span>${tc?.taxonConcept?.author?:""}</span>
                    </h1>
                    <g:if test="${tc?.commonNames}">
                        <h2>${(tc?.commonNames) ? tc?.commonNames?.opt(0)?.nameString : '<br/>'}</h2>
                    </g:if>
                    <h4>Name authority: ${tc?.taxonConcept.infoSourceName}</h4>
                </div>
                <div class="span3" id="actionButtons">
                    <a href="${citizenSciUrl}${guid}" class="btn btn-ala" title="Record a sighting">Record a sighting</a>
                    <a id="alertsButton" class="btn btn-ala" href="#">Alerts <i class="icon-bell"></i></a>
                </div>
            </hgroup>
        </header>

        <div class="row-fluidXX">
            <div class="tabbable tabs-belowZ">
                <ul class="nav nav-tabs">
                    <li class="active"><a id="t1" href="#overview" data-toggle="tab">Overview</a></li>
                    <g:if test="${tc.taxonConcept?.rankID?:0 >= 6000}"><li><a id="t2" href="#gallery" data-toggle="tab">Gallery</a></li></g:if>
                    <li><a id="t3" href="#names" data-toggle="tab">Names</a></li>
                    <li><a id="t4" href="#classification" data-toggle="tab">Classification</a></li>
                    <li><a id="t5" href="#records" data-toggle="tab">Records</a></li>
                    <li id="bhl"><a id="t6" href="#literature" data-toggle="tab">Literature</a></li>
                    <li><a id="t7" href="#other" data-toggle="tab">Sequences</a></li>
                </ul>
            </div>
            <div class="tab-content" style="min-height:700px;">
                <section  class="tab-pane active" id="overview">
                    <div class="row-fluid" >
                        <div class="span6">
                            <div id="noOverviewImages" class="row-fluid" style="height:400px;">
                                <div class="span12" style="background-color:#d3d3d3; width:100%; padding: 30px; border-radius: 5px; text-align: center; height:100%;">
                                    <h3>No images available</h3>
                                </div>
                            </div>

                            <div id="overviewImages" class="row-fluid hide">
                                <div class="span8">
                                    <img id="mainOverviewImage" src=""/>
                                    <p id="mainOverviewImageInfo" style="background-color:#f0f0e8; padding:10px;">
                                        Image metadata here
                                    </p>
                                </div>
                                <div class="span4">
                                    <img id="secondOverviewImage" style="margin-bottom:10px;" src=""/>
                                    <br/>
                                    <img id="thirdOverviewImage" src=""/>
                                </div>
                            </div>

                            <div id="descriptiveContent">
                                %{--Content added by jquery>--}%
                            </div>
                        </div>
                        <div class="span6">
                            <div id="leafletMap" style="height:500px;  border-radius: 5px;"> </div>
                            <a href="${biocacheUrl}/occurrences/search?q=${tc?.taxonConcept?.nameString}#tab_mapView" class="btn btn-large pull-right">View Interactive Map</a>
                            <a href="${biocacheUrl}/occurrences/search?q=${tc?.taxonConcept?.nameString}#tab_recordsView" class="btn btn-large pull-right">View Locations</a>
                            %{--<div id="expertDistroDiv" style="display:none;margin-bottom: 10px;">--}%
                                %{--<h2>Compiled distribution map</h2>--}%
                                %{--<img id="distroMapImage" src="${resource(dir: 'images', file: 'noImage.jpg')}" class="distroImg" style="width:316px;" alt="occurrence map" onerror="this.style.display='none'"/>--}%
                                %{--<div class="mapAttribution">Compiled distribution map provided by <span id="dataResource">[data resource not known]</span></div>--}%
                            %{--</div>--}%
                        </div>
                    </div>
                </section>
                <section id="sounds">
                </section>
                    <div class="clearfix"></div>
                    <g:set var="descriptionBlock">
                        <g:set var="counter" value="${0}"/>
                        <g:each var="textProperty" in="${textProperties}" status="status">
                            <g:if test="${textProperty.name?.endsWith("hasDescriptiveText") && counter < 3 && textProperty.infoSourceId != '1051'}">
                                <g:set var="counter" value="${counter + 1}"/>
                                <p>${textProperty.value} <cite>source:
                                    <a href="${textProperty.identifier}" class="external" target="_blank" title="${textProperty.title}">${textProperty.infoSourceName}</a></cite>
                                </p>
                            </g:if>
                        </g:each>
                    </g:set>
                    <g:if test="${descriptionBlock?.trim().length() > 0}">
                        <section>
                            <h2>Description</h2>
                            ${descriptionBlock}
                        </section>
                    </g:if>
                    <g:if test="${tc.identificationKeys}">
                        <h3>Identification Keys</h3>
                        <ul>
                            <g:each var="idKey" in="${tc.identificationKeys}">
                                <li>
                                    <a href="${idKey?.url}" target="_blank" class="external">${idKey?.title}</a>
                                    <g:if test="${idKey?.infoSourceURL}">(source: ${idKey?.infoSourceName})</g:if>
                                </li>
                            </g:each>
                        </ul>
                    </g:if>
                    <g:if test="${infoSources}">
                        <section id="resources" class="clearfix">
                            <h2>Online resources</h2>
                            <dd>
                                <g:each var="is" in="${infoSources}" status="status">
                                %{--<g:set var="infoSource" value="${entry.value}"/>--}%<!--code>${is}</code-->
                                    <dt><a href="${is.value?.infoSourceURL}" target="_blank" class="infosource">${is.value?.infoSourceName}</a></dt>
                                    <dd>
                                        <g:each in="${is.value?.sections}" var="s" status="i">
                                            <g:set var="section"><g:message code="${s}"/></g:set>
                                            ${section}${section && i>1 && is.value?.sections?.size()>1 ?', ':''}
                                        </g:each>
                                        %{--${is.value?.sections.join(",")}--}%
                                    </dd>
                                </g:each>
                            </dd>
                        </section>
                    </g:if>
                    <g:elseif test="${infoSourceMap}">
                        <section id="resources" class="clearfix">
                            <h2>Online resources</h2>
                            <dl>
                                <g:each var="ism" in="${infoSourceMap}" status="status">
                                %{--<g:set var="infoSource" value="${entry.value}"/>--}%<!--code>${ism}</code-->
                                    <dt><a href="${ism.key}" target="_blank" class="infosource">${ism.value?.name}</a></dt>
                                    <dd>
                                        <g:set var="sections" value="${ism.value?.sections?.minus(["hasOccurrenceRowKey","hasImageLicenseInfo"])}"/>
                                        <g:each in="${sections}" var="s" status="i">
                                            <g:set var="section"><g:message code="${s}"/></g:set>
                                            ${section}${section && i < sections.size() - 1?', ':''}
                                        </g:each>
                                        %{--${is.value?.sections.join(",")}--}%
                                    </dd>
                                </g:each>
                            </dl>
                        </section>
                    </g:elseif>
                    <g:if test="${speciesList}">
                        <h2>Species Lists</h2>
                        <dl id="speciesLists">
                            <g:each in="${speciesList}" var="list">
                                <dt>
                                    <a href="${speciesListUrl}/speciesListItem/list/${list.dataResourceUid}">${list?.list?.listName}</a>
                                </dt>
                                <g:if test="${list.kvpValues}">
                                    <g:each in="${list.kvpValues}" var="kvp">
                                        <dd>
                                            <span>${kvp.key}:</span>
                                                ${kvp.vocabValue?:kvp.value}
                                        </dd>
                                    </g:each>
                                </g:if>
                            </g:each>
                        </dl>
                    </g:if>
                    </table>
                </section><!--#overview-->
                <!-- Gallery tab content -->
                <g:if test="${tc.taxonConcept?.rankID?:0 >= 6000}">
                    <section class="tab-pane" id="gallery">
                        <%-- Gallery divs populated via AJAX --%>
                        <div id="cat_type" class="hide">
                            <h2>Type Images</h2>
                            <div class="subGallery"></div>
                        </div>
                        <div id="cat_specimen" class="hide">
                            <h2>Specimen Images</h2>
                            <div class="subGallery"></div>
                        </div>
                        <div id="cat_other" class="hide">
                            <h2>Images</h2>
                            <div class="subGallery"></div>
                        </div>
                        <%-- template used by AJAX code --%>
                        <div class="imgConTmpl hide">
                            <div class="imgCon">
                                <a class="cbLink" rel="thumbs" href="" id="thumb">
                                    <img src="" alt="${tc?.taxonConcept?.nameString} image thumbnail"/>
                                    <div class="meta brief"></div>
                                    <div class="meta detail hide"></div>
                                </a>
                            </div>
                        </div>
                        <div id="gallerySpinner" style="display: none;">
                            Loading gallery <img src="${resource(dir: "images", file:"spinner.gif")}" />
                        </div>
                        <g:if test="${tc.screenshotImages}">
                            <h2 style="margin-top:20px;">Videos</h2>
                            <div id="videosGallery">
                                <g:each var="screenshot" in="${tc.screenshotImages}" status="status">
                                    <g:set var="thumbUri">${screenshot.repoLocation}</g:set>
                                    <g:set var="screenshotUri"><g:if
                                            test="${screenshot.identifier}">${screenshot.identifier}</g:if><g:elseif
                                            test="${screenshot.isPartOf}">${screenshot.isPartOf}</g:elseif><g:else>${screenshot.infoSourceURL}</g:else></g:set>
                                    <table>
                                        <tr>
                                            <td>
                                                <a class="screenshotThumb" title="${screenshot.title}" href="${screenshotUri}" target="_blank"
                                                   class="external"><img src="${thumbUri}" alt="${screenshot.infoSourceName}" title="${imageTitle}"
                                                                         width="120px" height="120px" style="width:120px;height:120px;padding-right:3px;"/></a>
                                            </td>
                                            <td>
                                                <g:if test="${screenshot.title}">
                                                    ${screenshot.title}<br/>
                                                </g:if>
                                                <g:if test="${screenshot.creator}">
                                                    Video by: ${screenshot.creator}<br/>
                                                </g:if>
                                                <g:if test="${screenshot.locality}">
                                                    Locality: ${screenshot.locality}<br/>
                                                </g:if>
                                                <g:if test="${screenshot.licence}">
                                                    Licence: ${screenshot.licence}<br/>
                                                </g:if>
                                                <g:if test="${screenshot.rights}">
                                                    Rights: ${screenshot.rights}<br/>
                                                </g:if>
                                                Source: <a href="${screenshotUri}" target="_blank" class="external">${screenshot.infoSourceName}</a>
                                            </td>
                                        </tr>
                                    </table>
                                </g:each>
                            </div>
                        </g:if>
                    </section><!--#gallery-->
                </g:if>

                <section class="tab-pane" id="names">
                    <h2>Names and sources</h2>
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <th>Accepted name</th>
                                <th>Source</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${sciNameFormatted} ${authorship}</td>
                                <td class="source">
                                    <ul><li><a href="${tc.taxonConcept.infoSourceURL}" target="_blank" class="external">${tc.taxonConcept.infoSourceName}</a></li></ul>
                                </td>
                            </tr>
                            <g:if test="${(tc.taxonName && tc.taxonName.publishedIn) || tc.taxonConcept.publishedIn}">
                                <tr class="cite">
                                    <td colspan="2">
                                        <cite>Published in: <a href="#" target="_blank" class="external">${tc.taxonName?.publishedIn?:tc.taxonConcept.publishedIn}</a></cite>
                                    </td>
                                </tr>
                            </g:if>
                        </tbody>
                    </table>
                    <g:if test="${tc.synonyms}">
                        <h2>Synonyms</h2>
                        <table class="outline table table-condensed">
                            <thead>
                                <tr>
                                    <th>Synonyms</th>
                                    <th>Source</th>
                                </tr>
                            </thead>
                            <tbody>
                    </g:if>
                    <g:each in="${tc.synonyms}" var="synonym">
                        <tr>
                            <td><bie:formatSciName name="${synonym.nameString}" rankId="${tc.taxonConcept?.rankID}"/> ${synonym.author}</td>
                            <td class="source">
                                <ul>
                                    <g:if test="${!synonym.infoSourceURL}"><li><a href="${tc.taxonConcept.infoSourceURL}" target="_blank" class="external">${tc.taxonConcept.infoSourceName}</a></li></g:if>
                                    <g:else><li><a href="${synonym.infoSourceURL}" target="_blank" class="external">${synonym.infoSourceName}</a></li></g:else>
                                </ul>
                            </td>
                        </tr>
                        <g:if test="${synonym.publishedIn || synonym.referencedIn}">
                            <tr class="cite">
                                <td colspan="2">
                                    <cite>Published in: <span class="publishedIn">${synonym.publishedIn?:synonym.referencedIn}</span></cite>
                                </td>
                            </tr>
                        </g:if>
                    </g:each>
                    <g:if test="${tc.synonyms}">
                        </tbody></table>
                    </g:if>
                    <g:if test="${tc.commonNames}">
                        <h2>Common Names</h2>
                        <table class="outline table table-condensed">
                            <thead>
                                <tr>
                                    <th>Common name</th>
                                    <th>Source</th>
                                </tr>
                            </thead>
                            <tbody>
                    </g:if>
                    <g:each in="${sortCommonNameSources}" var="cn">
                        <g:set var="cNames" value="${cn.value}" />
                        <%-- special treatment for <div> id and cookie name/value. matchup with Ranking Controller.rankTaxonCommonNameByUser --%>
                        <g:set var="nkey" value="${cn.key}" />
                        <g:set var="fName" value="${nkey?.trim()?.hashCode()}" />
                        <%-- javascript treatment: manual translate special character, because string:encodeURL cannot handle non-english character --%>
                        <g:set var="enKey" value="${nkey?.encodeAsJavaScript()}" />
                        <tr>
                            <td>
                                ${nkey}
                                <g:if test="${!isReadOnly}">
                                    <g:if test="${!rankedImageUris?.contains(fName)}">
                                        <g:if test="${cNames}">
                                            <div id='cnRank-${fName}' class="rankCommonName">
                                                Is this a preferred common name for this ${tc.taxonConcept.rankString}?
                                                <a class="isrepresent" href="#" onclick="rankThisCommonName('${guid}','${fName}',false,true,'${enKey.trim()}');return false;">YES</a>
                                                |
                                                <a class="isnotrepresent" href="#" onclick="rankThisCommonName('${guid}','${fName}',false,false,'${enKey.trim()}');return false;">NO</a>
                                            </div>
                                        </g:if>
                                    </g:if>
                                </g:if>
                            </td>
                            <td class="source">
                                <ul>
                                <g:each in="${sortCommonNameSources?.get(nkey)}" var="commonName">
                                    <li><a href="${commonName.infoSourceURL}" onclick="window.open(this.href); return false;">${commonName.infoSourceName}</a></li>
                                </g:each>
                                </ul>
                            </td>
                        </tr>
                    </g:each>
                    <g:if test="${tc.commonNames}">
                        </tbody></table>
                    </g:if>
                </section><!--#names-->
                <section class="tab-pane" id="classification">
                    <h2>Working classification</h2>
                    <div id="isAustralianSwitch"></div>
                        <g:each in="${taxonHierarchy}" var="taxon">
                            <!-- taxon = ${taxon} -->
                            <%-- Note: check for rankId is here due to some taxonHierarchy including taxa at higher rank than requested taxon (bug)--%>
                            <g:if test="${taxon.rankId?:0 <= tc.taxonConcept.rankID && taxon.guid != tc.taxonConcept.guid}">
                                <dl><dt>${taxon.rank}</dt>
                                    <dd><a href="${request?.contextPath}/species/${taxon.guid}#classification" title="${taxon.rank}">
                                        <bie:formatSciName name="${taxon.scientificName}" rankId="${taxon.rankId?:0}"/>
                                        <g:if test="${taxon.commonNameSingle}">: ${taxon.commonNameSingle}</g:if></a>
                                    </dd>
                            </g:if>
                            <g:elseif test="${taxon.guid == tc.taxonConcept.guid}">
                                <dl><dt id="currentTaxonConcept">${taxon.rank}</dt>
                                    <dd><span><bie:formatSciName name="${taxon.scientificName}" rankId="${taxon.rankId?:0}"/>
                                        <g:if test="${taxon.commonNameSingle}">: ${taxon.commonNameSingle}</g:if></span>
                                        <g:if test="${taxon.isAustralian || tc.isAustralian}">
                                            &nbsp;<span><img src="${grailsApplication.config.ala.baseURL}/wp-content/themes/ala2011/images/status_native-sm.png" alt="Recorded in Australia" title="Recorded in Australia" width="21" height="21"></span>
                                        </g:if>
                                    </dd>
                            </g:elseif>
                            <g:else><!-- Taxa ${taxon}) should not be here! --></g:else>
                        </g:each>
                        <dl class="childClassificationXXX">
                            <g:set var="currentRank" value=""/>
                            <g:each in="${childConcepts}" var="child" status="i">
                                <g:set var="currentRank" value="${child.rank}"/>
                                <dt>${child.rank}</dt>
                                <g:set var="taxonLabel"><bie:formatSciName name="${child.nameComplete ? child.nameComplete : child.name}"
                                           rankId="${child.rankId?:0}"/><g:if test="${child.commonNameSingle}">: ${child.commonNameSingle}</g:if></g:set>
                                <dd><a href="${request?.contextPath}/species/${child.guid}#classification">${taxonLabel.trim()}</a>&nbsp;
                                    <span>
                                        <g:if test="${child.isAustralian}">
                                            <img src="${grailsApplication.config.ala.baseURL}/wp-content/themes/ala2011/images/status_native-sm.png" alt="Recorded in Australia" title="Recorded in Australia" width="21" height="21">
                                        </g:if>
                                        <g:else>
                                            <g:if test="${child.guid?.startsWith('urn:lsid:catalogueoflife.org:taxon')}">
                                                <span class="inferredPlacement" title="Not recorded in Australia">[inferred placement]</span>
                                            </g:if>
                                            <g:else>
                                                <span class="inferredPlacement" title="Not recorded in Australia"></span>
                                            </g:else>
                                        </g:else>
                                    </span>
                                </dd>
                            </g:each>
                        </dl>
                        <g:each in="${taxonHierarchy}" var="taxon">
                            </dl>
                        </g:each>
                </section><!--classificatio-->
                <section class="tab-pane" id="records">
                    <h2>Occurrence records</h2>
                    <div id="occurrenceRecords">
                        <p><a href="${biocacheUrl}/occurrences/search?q=${tc?.taxonConcept?.nameString?:''}">View
                        list of all <span id="occurenceCount"></span> occurrence records for this taxon</a></p>
                        <div id="recordBreakdowns" style="display: block;">
                            <h2>Charts showing breakdown of occurrence records</h2>
                            <div id="chartsHint">Hint: click on chart elements to view that subset of records</div>
                            <div id="charts" class=""></div>
                        </div>
                    </div>

                    <%-- Distribution map images --%>
                    <g:if test="${tc.distributionImages}">
                        <h2>Record maps from other sources</h2>
                        <g:each in="${tc.distributionImages}" var="distribImage">
                            <div class="recordMapOtherSource" style="display: block">
                                <g:set var="imageLink">${distribImage.isPartOf ? distribImage.isPartOf : distribImage.infoSourceURL}</g:set>
                                <a href="${imageLink}">
                                    <img src="${distribImage.repoLocation}" alt="3rd party distribution map"/>
                                </a>
                                <br/>
                                <cite>Source:
                                    <a href="${imageLink}" onclick="window.open(this.href); return false;">${distribImage.infoSourceName}</a>
                                </cite>
                            </div>
                        </g:each>
                    </g:if>
                </section><!--#records-->
                <section class="tab-pane" id="literature">
                    <h2>Name references found in the Biodiversity Heritage Library</h2>
                    <div id="status-box" class="column-wrap" style="display: none;">
                        <div id="search-status" class="column-wrap" >
                            <span style="vertical-align: middle; ">
                                Searching, please wait...
                                <img src="${resource(dir: 'css/images', file: 'indicator.gif')}" alt="Searching" style="vertical-align: middle;"/>
                            </span>
                        </div>
                    </div>
                    <div id="results-home" class="column-wrap">
                        <div id="synonyms" style="display: none">
                        </div>
                        <div class="column-wrap" id="solr-results">
                        </div>
                    </div>

                    <div class="section" id="trove-container" style="padding-top:20px;">
                        <h2>Name references found in the TROVE - NLA </h2>
                        <div id="trove-results-home" class="column-wrap">
                        </div>
                        <input type="button" class="btn" id="previousTrove" value="Previous page"/>
                        <input type="button" class="btn" id="nextTrove" value="Next page"/>
                    </div>
                    <style type="text/css">
                    .trove-results-home .titleInfo { height:15px; }
                    </style>
            </section><!--#literature-->
            <section class="tab-pane" id="other">
                <h2>Genbank <span id="genbankResultCount"></span></h2>
                <table id="genbank" class="table">
                </table>
            </section>
            </div><!--tabs-panes-noborder-->
        </div><!--col-wide last-->
    </div><!--inner-->

    <div id="descriptionTemplate" class="well" style="display:none;">
        <h4 class="title"></h4>
        <p class="content"></p>
        <cite class="citation">
            <a class="sourceLink" href=""></a><br/>
            <span class="rights"></span><br/>
            <a href="" class="providedBy"></a>
        </cite>
    </div>

</body>

</html>