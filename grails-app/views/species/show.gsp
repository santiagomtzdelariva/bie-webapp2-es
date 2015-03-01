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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${tc?.taxonConcept?.nameString} ${(tc?.commonNames) ? ' : ' + tc?.commonNames?.get(0)?.nameString : ''} | ${raw(grailsApplication.config.skin.orgNameLong)}</title>
    <meta name="layout" content="uk-bs3"/>
    <r:require module="show"/>
</head>
<body class="page-taxon">
        <section class="container">
        <header class="pg-header">
            <div class="taxonomy-bcrumb">
                <ol class="list-inline">
                    <g:each in="${taxonHierarchy}" var="taxon">
                        <li><g:link controller="species" action="show" params="[guid:taxon.guid]">${taxon.scientificName}</g:link></li>
                    </g:each>
                </ol>
            </div>
            <div class="header-inner">
                <h1>${sciNameFormatted} <span>${tc?.taxonConcept?.author?:""}</span></h1>
                <g:set var="commonNameDisplay" value="${(tc?.commonNames) ? tc?.commonNames?.opt(0)?.nameString : ''}"/>
                <g:if test="${commonNameDisplay}">
                    <h2>${commonNameDisplay}</h2>
                </g:if>
                <h5 class="inline-head taxon-rank">${tc.taxonConcept.rankString}</h5>
                <h5 class="inline-head"><strong>Name authority:</strong> ${tc?.taxonConcept.infoSourceName}</h5>
            </div>
        </header>

        <div class="main-content">
            <div class="taxon-tabs">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#overview" data-toggle="tab">Overview</a></li>
                    <li><a href="#gallery" data-toggle="tab">Gallery</a></li>
                    <li><a href="#names" data-toggle="tab">Names</a></li>
                    <li><a href="#classification" data-toggle="tab">Classification</a></li>
                    <li><a href="#records" data-toggle="tab">Records</a></li>
                    <li><a href="#literature" data-toggle="tab">Literature</a></li>
                    <li><a href="#sequences" data-toggle="tab">Sequences</a></li>
                    <li><a href="#data-providers" data-toggle="tab">Data Providers</a></li>
                </ul>
                <div class="tab-content">

                    <section class="tab-pane fade in active" id="overview">
                        <div class="row taxon-row">
                            <div class="col-md-6">


                                <div class="taxon-summary-gallery">
                                    <div class="main-img">

                                        <a class="lightbox-img"
                                           data-toggle="lightbox"
                                           data-gallery="taxon-summary-gallery"
                                           data-parent=".taxon-summary-gallery"
                                           data-title=""
                                           data-footer=""
                                           href="">
                                            <img class="mainOverviewImage img-responsive" src="">
                                        </a>
                                        <div class="caption mainOverviewImageInfo"></div>
                                    </div>


                                    <div class="thumb-row">
                                        <div class="taxon-summary-thumb" style="background-image:url(INSERT_URL)">
                                            <a data-toggle="lightbox"
                                               data-gallery="taxon-summary-gallery"
                                               data-parent=".taxon-summary-gallery"
                                               data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758"
                                               data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>"
                                               href="INSERT_URL"></a>
                                        </div>
                                        <div class="taxon-summary-thumb" style="background-image:url(INSERT_URL)">
                                            <a data-toggle="lightbox" data-gallery="taxon-summary-gallery" data-parent=".taxon-summary-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="INSERT_URL"></a>
                                        </div>
                                        <div class="taxon-summary-thumb" style="background-image:url(INSERT_URL)">
                                            <a data-toggle="lightbox" data-gallery="taxon-summary-gallery" data-parent=".taxon-summary-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="images/demo-taxon-thumb-3.jpg"></a>
                                        </div>
                                        <div class="taxon-summary-thumb" style="background-image:url(INSERT_URL)">
                                            <a class="more-photos tab-link" href="#gallery" title="More Photos"><span>+</span></a>
                                        </div>
                                    </div>
                                </div>



                                <div class="panel panel-default panel-description">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Description</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>The hedgehog is one of our most instantly recognisable native mammals, as it is the only British mammal to have spines (2). They are also characterised by their fairly short tails, long legs and small ears (6). Young hedgehogs are born with a coat of soft, white spines, which are underneath the skin to protect the mother during birth, but emerge after a few hours (7). A second coat of dark spines emerges after about 36 hours, and later on a third set develops. By 11 days of age the young hedgehogs can curl into a ball, and after 14 days the eyes open (8).</p>
                                    </div>
                                    <div class="panel-footer">
                                        <p>Source: <a href="#">Arkive</a>, © Wildscreen</p>
                                    </div>
                                </div>

                                <div class="panel panel-default panel-range">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Range</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p>This species is found in western Europe (9). In Britain it is widely distributed, and has been introduced to several islands (5).</p>
                                    </div>
                                    <div class="panel-footer">
                                        <p>Source: <a href="#">Arkive</a>, © Wildscreen</p>
                                    </div>
                                </div>

                                <div class="panel panel-default panel-resources">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Online Resources</h3>
                                    </div>
                                    <div class="panel-body">
                                        <ul>
                                            <li><a href="#">GBIF</a></li>
                                            <li><a href="#">Encyclopaedia of Life</a></li>
                                            <li><a href="#">Biodiversity Heritage Library</a></li>
                                            <li><a href="#">PESI</a></li>
                                            <li><a href="#">ARKive</a></li>
                                            <li><a href="#">Flickr</a></li>
                                            <li><a href="#">Wikipedia</a></li>
                                        </ul>
                                    </div>
                                </div>

                            </div><!-- end col 1 -->

                            <div class="col-md-6">

                                <div class="taxon-map">
                                    <div id="leafletMap"></div>
                                    <div class="map-buttons">
                                        <a class="btn btn-primary btn-lg" href="${biocacheUrl}/occurrences/search?q=${tc?.taxonConcept?.nameString}#tab_mapView" role="button">View Interactive Map</a>
                                        <a class="btn btn-primary btn-lg" href="${biocacheUrl}/occurrences/search?q=${tc?.taxonConcept?.nameString}#tab_recordsView" role="button">View Locations</a>
                                    </div>
                                </div>

                                <div class="panel panel-default panel-actions">
                                    <div class="panel-body">
                                        <ul class="list-unstyled">
                                            <li><a href="http://sightings.ala.org.au/NBNSYS0000005078"><span class="glyphicon glyphicon-map-marker"></span> Record a sighting</a></li>
                                            <li><a href="#"><span class="glyphicon glyphicon-camera"></span> Submit a photo</a></li>
                                            <li><a href="#"><span class="glyphicon glyphicon-download"></span> Download a fact sheet</a></li>
                                            <li><a href="#"><span class="glyphicon glyphicon-bell"></span> Receive alerts when new records are added</a></li>
                                            <li><a href="#"><span class="glyphicon glyphicon-comment"></span> Start a topic about this species on the forum</a></li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="panel panel-default panel-stats">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Statistics</h3>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <p>A donut chart will go here.</p>
                                            </div>
                                            <div class="col-sm-8">
                                                <p>Some information about statistics will go here.</p>
                                                <p><a class="tab-link" href="#records">More statistics</a></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <p><strong>39,769</strong> occurrence records</p>
                                            </div>
                                            <div class="col-sm-6">
                                                <p><strong>104</strong> datasets</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default panel-data-providers">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Data Providers</h3>
                                    </div>
                                    <div class="panel-body">
                                        <p><strong>116</strong> organisations have provided data to the UK Wildlife Portal for this [taxon rank].</p>
                                        <p><a class="tab-link" href="#data-providers">Browse the list of data providers</a> and find organisations you can join if you are interested in participating in a survey for [taxon rank] such as [taxon name].</p>
                                    </div>
                                </div>

                            </div><!-- end col 2 -->
                        </div>
                    </section>

                    <section class="tab-pane fade" id="gallery">
                        <h2>Images</h2>
                        <div class="taxon-gallery">
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/3004/0d77f107-a398-4859-975f-4e59c7b656a9/ac22d947b72ef34373ed82dc80095364__large.JPG">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/3004/0d77f107-a398-4859-975f-4e59c7b656a9/ac22d947b72ef34373ed82dc80095364__small.JPG" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/13889/2a42adb7-4c16-428a-b0b7-748cc50cecdc/a0bcff2b89973544d64c58994251dfe0__large.jpg" id="thumb_other1">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/13889/2a42adb7-4c16-428a-b0b7-748cc50cecdc/a0bcff2b89973544d64c58994251dfe0__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/8462/0fbb2255-e077-47e9-bc81-e25041257bf9/172d8284b3db4129de704ae02c67f072__large.jpg">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/8462/0fbb2255-e077-47e9-bc81-e25041257bf9/172d8284b3db4129de704ae02c67f072__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/4597/b6044ce3-0bf3-4f91-8943-35a1bbef6239/65f7fa84a893b6ba163741ad08ea78a1__large.jpg">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/4597/b6044ce3-0bf3-4f91-8943-35a1bbef6239/65f7fa84a893b6ba163741ad08ea78a1__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/28411/eb46aebf-d3cc-4235-bca1-3ff8d668d6e8/47893b7013a338af78df075726cfc6fb__large.jpg">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/28411/eb46aebf-d3cc-4235-bca1-3ff8d668d6e8/47893b7013a338af78df075726cfc6fb__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/1792/5aca5e65-8b0d-4c7f-b897-3015e21b9fb1/d0bf93db04526b9cf156058f892b5f31__large.jpg">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/1792/5aca5e65-8b0d-4c7f-b897-3015e21b9fb1/d0bf93db04526b9cf156058f892b5f31__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/28762/718b856d-156c-45d9-a405-2580df4f8d4c/c20a7fd22b66c232c158e4d35d1673c4__large.jpg">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/28762/718b856d-156c-45d9-a405-2580df4f8d4c/c20a7fd22b66c232c158e4d35d1673c4__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/12808/54966da1-5026-4219-b420-b1ab90011c6c/1af1f69644267b75591540ccc012dfd7__large.JPG">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/12808/54966da1-5026-4219-b420-b1ab90011c6c/1af1f69644267b75591540ccc012dfd7__small.JPG" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                            <a class="taxon-thumb" data-toggle="lightbox" data-gallery="taxon-gallery" data-title="<i>Erinaceus europaeus</i> Linnaeus, 1758" data-footer="Encyclopedia of Life<br><a href='#'>View details of this record</a>" href="http://ala-demo.gbif.org/biocache-media/dr1089/31551/78aec885-450e-406c-bb02-f5d072672ac6/ce9f19ed88245bacc19a33c86d081228__large.jpg">
                                <img src="http://ala-demo.gbif.org/biocache-media/dr1089/31551/78aec885-450e-406c-bb02-f5d072672ac6/ce9f19ed88245bacc19a33c86d081228__small.jpg" alt="Erinaceus europaeus image thumbnail">
                                <div class="thumb-caption caption-brief"><i>Erinaceus europaeus</i> Linnaeus, 1758</div>
                                <div class="thumb-caption caption-detail"><i>Erinaceus europaeus</i> Linnaeus, 1758<br>Encyclopedia of Life</div>
                            </a>
                        </div>
                    </section>

                    <section class="tab-pane fade" id="names">
                    <h2>Names and sources</h2>
                    <table class="table name-table  table-responsive">
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
                        <table class="table name-table table-responsive">
                            <thead>
                                <tr>
                                    <th>Synonyms</th>
                                    <th>Source</th>
                                </tr>
                            </thead>
                            <tbody>
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
                            </tbody>
                        </table>
                    </g:if>
                    <g:if test="${tc.commonNames}">
                        <table class="table name-table table-responsive">
                            <thead>
                                <tr>
                                    <th>Common name</th>
                                    <th>Source</th>
                                </tr>
                            </thead>
                            <tbody>
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
                        </tbody></table>
                    </g:if>
                    </section>

                    <section class="tab-pane fade" id="classification">

                        <style type="text/css">
                        section#classification dl#classificationList {
                            margin-left:0;
                        }
                        section#classification dl {
                            margin:4px 0 0 24px;
                        }
                        @media screen and (max-width: 600px) {
                            section#classification dl {
                                margin:4px 0 0 0px;
                            }
                        }
                        section#classification dl dt {
                            float:left;
                            padding-right:10px;
                        }
                        section#classification dl  dd {
                            /*float:left;*/
                            padding-top: 1px;
                            display: block;
                            /*margin: 0;*/
                        }
                        section#classification dd img {
                            vertical-align:middle;
                        }
                        section#classification dl.childClassification dt,section#classification dl.childClassification dd{
                            float:none;
                        }
                        </style>

                        <h2>
                            <g:if test="${grailsApplication.config.classificationSupplier}">${grailsApplication.config.classificationSupplier}</g:if>
                            Classification
                        </h2>
                        <g:each in="${taxonHierarchy}" var="taxon">
                            <!-- taxon = ${taxon} -->
                            <g:if test="${taxon.guid != tc.taxonConcept.guid}">
                                <dl><dt><g:if test="${taxon.rankId?:0 !=0}">${taxon.rank}</g:if></dt>
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
                        <dl class="child-taxa">
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
                    </section>

                    <section class="tab-pane fade" id="records">
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
                    </section>

                    <section class="tab-pane fade" id="literature">
                        <h2>Name references found in the Biodiversity Heritage Library</h2>
                        <p>Showing 1 to 10 of 937 results for the query <strong>"Erinaceus europaeus"</strong></p>
                        <div class="result-list">
                            <div class="result">
                                <h3><b>1.</b> <a href="http://biodiversitylibrary.org/item/35421" target="item">Checklist of Palaearctic and Indian mammals 1758 to 1946 / by J.R. Ellerman and T.C.S. Morrison-Scott.</a> (3 matching pages)</h3>
                                <div class="thumbnail-container">
                                    <div class="page-thumbnail">
                                        <a data-toggle="tooltip" data-placement="bottom" data-html="true" title="PALAEARCTIC AND INDIAN MAMMALS 1 758-1946 Erinaceus europael's nesiotes Bate, 1906 1906. <em>Erinaceus</em> <em>europaeus</em> nesiotes Bate, P.Z.S. igo^, 2: 316. Near Gonia, Western Crete. <em>Erinaceus</em>" href="http://biodiversitylibrary.org/page/8727615">
                                            <img alt="Page Id 8727615" src="http://biodiversitylibrary.org/pagethumb/8727615">
                                        </a>
                                    </div>
                                    <div class="page-thumbnail">
                                        <a data-toggle="tooltip" data-placement="bottom" data-html="true" title="Shensi, to Manchuria (part). <em>Erinaceus</em> <em>europaeus</em> hispanicus Barrett-Hamilton, 1900 1900. <em>Erinaceus</em> <em>europaeus</em> hispanicus Barrett-Hamilton, Ann. Mag. N.H. j.- 363. Seville, Spain. Range" href="http://biodiversitylibrary.org/page/8727614">
                                            <img alt="Page Id 8727615" src="http://biodiversitylibrary.org/pagethumb/8727614">
                                        </a>
                                    </div>
                                    <div class="page-thumbnail">
                                        <a data-toggle="tooltip" data-placement="bottom" data-html="true" title="<em>Erinaceus</em> <em>europaeus</em> europaeus Linnaeus, 1 758 1758. Ennacais tiiropaais Linnaeus, Syst. Xat. loth ed. /.• 52. Wamlingbo, South Gothland Island, Sweden (see Thomas, 191 1, P.Z.S. 142). 1779. Hvstrix" href="http://biodiversitylibrary.org/page/8727613">
                                            <img alt="Page Id 8727615" src="http://biodiversitylibrary.org/pagethumb/8727613">
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="result">
                                <h3><b>2.</b> <a href="http://biodiversitylibrary.org/item/35421" target="item">Checklist of Palaearctic and Indian mammals 1758 to 1946 / by J.R. Ellerman and T.C.S. Morrison-Scott.</a> (3 matching pages)</h3>
                                <div class="thumbnail-container">
                                    <div class="page-thumbnail">
                                        <a data-toggle="tooltip" data-placement="bottom" data-html="true" title="PALAEARCTIC AND INDIAN MAMMALS 1 758-1946 Erinaceus europael's nesiotes Bate, 1906 1906. <em>Erinaceus</em> <em>europaeus</em> nesiotes Bate, P.Z.S. igo^, 2: 316. Near Gonia, Western Crete. <em>Erinaceus</em>" href="http://biodiversitylibrary.org/page/8727615">
                                            <img alt="Page Id 8727615" src="http://biodiversitylibrary.org/pagethumb/8727615">
                                        </a>
                                    </div>
                                    <div class="page-thumbnail">
                                        <a data-toggle="tooltip" data-placement="bottom" data-html="true" title="Shensi, to Manchuria (part). <em>Erinaceus</em> <em>europaeus</em> hispanicus Barrett-Hamilton, 1900 1900. <em>Erinaceus</em> <em>europaeus</em> hispanicus Barrett-Hamilton, Ann. Mag. N.H. j.- 363. Seville, Spain. Range" href="http://biodiversitylibrary.org/page/8727614">
                                            <img alt="Page Id 8727615" src="http://biodiversitylibrary.org/pagethumb/8727614">
                                        </a>
                                    </div>
                                    <div class="page-thumbnail">
                                        <a data-toggle="tooltip" data-placement="bottom" data-html="true" title="<em>Erinaceus</em> <em>europaeus</em> europaeus Linnaeus, 1 758 1758. Ennacais tiiropaais Linnaeus, Syst. Xat. loth ed. /.• 52. Wamlingbo, South Gothland Island, Sweden (see Thomas, 191 1, P.Z.S. 142). 1779. Hvstrix" href="http://biodiversitylibrary.org/page/8727613">
                                            <img alt="Page Id 8727615" src="http://biodiversitylibrary.org/pagethumb/8727613">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pagination-buttons">
                            <input type="button" class="btn btn-default" onclick="doBhlSearch(10,10, true)" value="Next page">
                        </div>

                        <h2>Name references found in the TROVE - NLA </h2>
                        <p>Number of matches in TROVE: 75</p>
                        <div class="result-list">
                            <div class="result">
                                <h3><b>1.</b> <a href="http://trove.nla.gov.au/work/36747985">Diversity and dynamics of the mammalian fauna in Denmark throughout the last glacial-interglacial cycle, 115-0 kyr BP / by Kim Aaris-Sørensen</a></h3>
                                <p><strong>Contributors:</strong> Aaris-Sørensen, Kim</p>
                                <p><strong>Date issued:</strong> 2009</p>
                            </div>
                        </div>
                        <div class="pagination-buttons">
                            <input type="button" class="btn btn-default" value="Previous page" id="previousTrove">
                            <input type="button" class="btn btn-default" value="Next page" id="nextTrove">
                        </div>
                    </section>

                    <section class="tab-pane fade" id="sequences">
                        <h2>Genbank</h2>
                        <p>Results: 1 to 20 of 222381 – <a href="http://www.ncbi.nlm.nih.gov/nuccore/?term=%22Erinaceus+europaeus%22">View all results</a></p>
                        <div class="result-list">
                            <div class="result">
                                <h3><a href="http://www.ncbi.nlm.nih.gov/nuccore/XM_007532280.1">PREDICTED: Erinaceus europaeus myelin oligodendrocyte glycoprotein (MOG), mRNA</a></h3>
                                <p>813 bp linear mRNA</p>
                                <p><strong>Accession: </strong> XM_007532280.1</p>
                                <p><strong>GI:</strong> 617644691</p>
                            </div>
                            <div class="result">
                                <h3><a href="http://www.ncbi.nlm.nih.gov/nuccore/XM_007532280.1">PREDICTED: Erinaceus europaeus myelin oligodendrocyte glycoprotein (MOG), mRNA</a></h3>
                                <p>813 bp linear mRNA</p>
                                <p><strong>Accession: </strong> XM_007532280.1</p>
                                <p><strong>GI:</strong> 617644691</p>
                            </div>
                            <div class="result">
                                <h3><a href="http://www.ncbi.nlm.nih.gov/nuccore/XM_007532280.1">PREDICTED: Erinaceus europaeus myelin oligodendrocyte glycoprotein (MOG), mRNA</a></h3>
                                <p>813 bp linear mRNA</p>
                                <p><strong>Accession: </strong> XM_007532280.1</p>
                                <p><strong>GI:</strong> 617644691</p>
                            </div>
                        </div>
                    </section>

                    <section class="tab-pane fade" id="data-providers">
                        <h2>Data Providers</h2>
                    </section>

                </div>
            </div>
        </div><!-- end main-content -->
    </section>
<r:script>
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

            //load EOL content
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

            //load Genbank content
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

            //load sound content
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
            //add an occurrence layer for this taxon
            var taxonLayer = L.tileLayer.wms(SHOW_CONF.biocacheServiceUrl + "/mapping/wms/reflect?q=" + SHOW_CONF.scientificName, {
                layers: 'ALA:occurrences',
                format: 'image/png',
                transparent: true,
                attribution: "${raw(grailsApplication.config.skin.orgNameLong)}",
                bgcolor: "0x000000",
                outline: "true",
                ENV: "color:5574a6;name:circle;size:4;opacity:1"
            });

            var speciesLayers = new L.LayerGroup();
            taxonLayer.addTo(speciesLayers);

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
                "${sciNameFormatted}": taxonLayer
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

</body>
</html>