%{--
  - Copyright (C) 2012 Atlas of Living Australia
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
<%@ page import="au.org.ala.BieTagLib" contentType="text/html;charset=UTF-8" %>
<g:set var="alaUrl" value="${grailsApplication.config.ala.baseURL}"/>
<g:set var="biocacheUrl" value="${grailsApplication.config.biocache.baseURL}"/>
<!doctype html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <title>${query} | Search | ${grailsApplication.config.skin.orgNameLong}</title>
    <r:require modules="search, pagination"/>
    <r:script disposition='head'>
        // global var to pass GSP vars into JS file
        SEARCH_CONF = {
            query: "${BieTagLib.escapeJS(query)}",
            serverName: "${grailsApplication.config.grails.serverURL}",
            bieUrl: "${grailsApplication.config.bie.baseURL}",
            biocacheUrl: "${grailsApplication.config.biocache.baseURL}",
            biocacheServicesUrl: "${grailsApplication.config.biocacheService.baseURL}",
            bhlUrl: "${grailsApplication.config.bhl.baseURL}"
        }
    </r:script>
</head>
<body class="species nav-species search content">
    <header id="page-header">
        <div class="inner row-fluid">
            <div id="breadcrumb" class="span12">
                <ol class="breadcrumb">
                    <li><a href="${alaUrl}">Home</a> <span class=" icon icon-arrow-right"></span></li>
                    <li class="active">Search the ${grailsApplication.config.skin.orgNameShort}</li>
                </ol>
            </div>
        </div>
        <hgroup class="row-fluid">
            <div class="span9">
                <g:if test="${searchResults.totalRecords}">
                    <h2>Search for "<b>${query.replaceFirst(/^\*$/, "[all records]")}</b>" returned <g:formatNumber number="${searchResults.totalRecords}" type="number"/> results</h2>
                </g:if>
                <g:else>
                    <h2>Search for <b>${query}</b> did not match any documents</h2>
                </g:else>
                <div class="hidden-desktopXXXX">
                    <form class="form-search" action="${grailsApplication.config.grails.serverURL}/search">
                        <div class="input-append">
                            <input type="text" class="search-query input-xxlarge" name="q" id="search-2013"  placeholder="Search the Atlas" autocomplete="off" value="${params.q}"/>
                            <button type="submit" class="btn"><i class="icon-search" style="margin-left:-3px;"></i></button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="span3 well well-small hidden-phone" id="relatedSearches">
                <!-- content inserted via jQuery -->
            </div>
        </hgroup>
    </header>

    <g:if test="${searchResults.totalRecords}">
        <g:set var="paramsValues" value="${[:]}"/>

        <div class="row-fluid">
            <div class="span4">
                <div class="well well-small">
                    <div class="facetLinks">
                        <h2 class="hidden-phone">Refine results</h2>
                        <h3 class="visible-phone">
                            <a href="#" id="toggleFacetDisplay"><i class="icon-chevron-down" id="facetIcon"></i>
                                Refine results</a>
                        </h3>
                        <div class="hidden-phone" id="accordion">
                            <g:if test="${query && filterQuery}">
                                <g:set var="queryParam">q=${query.encodeAsHTML()}<g:if test="${!filterQuery.isEmpty()}">&fq=${filterQuery?.join("&fq=")}</g:if></g:set>
                            </g:if>
                            <g:else>
                                <g:set var="queryParam">q=${query.encodeAsHTML()}<g:if test="${params.fq}">&fq=${fqList?.join("&fq=")}</g:if></g:set>
                            </g:else>
                            <g:if test="${searchResults.query}">
                                <g:set var="downloadParams">q=${searchResults.query?.encodeAsHTML()}<g:if test="${params.fq}">&fq=${params.list("fq")?.join("&fq=")?.trim()}</g:if></g:set>
                            </g:if>
                            <%-- is this init search? then add fq parameter in href --%>
                            <g:if test="${isAustralian}">
                                <g:set var="appendQueryParam" value="&fq=australian_s:recorded" />
                            </g:if>
                            <g:else>
                                <g:set var="appendQueryParam" value="" />
                            </g:else>
                            <g:if test="${facetMap}">
                                <h3><span class="FieldName">Current Filters</span></h3>
                                <div class="subnavlist" id="currentFilters">
                                    <ul>
                                        <g:each var="item" in="${facetMap}" status="facetIdx">
                                            <li>
                                                <g:set var="closeLink">&nbsp;[<b><a href="#" onClick="javascript:removeFacet(${facetIdx}); return true;" style="text-decoration: none" title="remove">X</a></b>]</g:set>
                                                <g:if test="${item.key?.contains("uid")}">
                                                    <g:set var="resourceType">${item.value}_resourceType</g:set>
                                                    ${collectionsMap?.get(resourceType)}:<b>&nbsp;${collectionsMap?.get(item.value)}</b>${closeLink}
                                                </g:if>
                                                <g:else>
                                                    <g:message code="facet.${item.key}"/>: <b><g:message code="${item.key}.${item.value}" default="${item.value}"/></b>${closeLink}
                                                </g:else>
                                            </li>
                                        </g:each>
                                    </ul>
                                </div>
                            </g:if>
                            <g:each var="facetResult" in="${searchResults.facetResults?:[]}">
                                <g:if test="${!facetMap?.get(facetResult.fieldName) && !filterQuery?.contains(facetResult.fieldResult?.opt(0)?.label) && !facetResult.fieldName?.contains('idxtype1')}">
                                    <h3><span class="FieldName"><g:message code="facet.${facetResult.fieldName}"/></span></h3>
                                    <div class="subnavlist" id="facet-${facetResult.fieldName}">
                                        <ul>
                                            <g:set var="lastElement" value="${facetResult.fieldResult?.get(facetResult.fieldResult.length()-1)}"/>
                                            <g:if test="${lastElement.label == 'before'}">
                                                <li><g:set var="firstYear" value="${facetResult.fieldResult?.opt(0)?.label.substring(0, 4)}"/>
                                                    <a href="?${queryParam}${appendQueryParam}&fq=${facetResult.fieldName}:[* TO ${facetResult.fieldResult.opt(0)?.label}]">Before ${firstYear}</a>
                                                    (<g:formatNumber number="${lastElement.count}" type="number"/>)
                                                </li>
                                            </g:if>
                                            <g:each var="fieldResult" in="${facetResult.fieldResult}" status="vs">
                                                <g:set var="dateRangeTo"><g:if test="${vs == lastElement}">*</g:if><g:else>${facetResult.fieldResult[vs+1]?.label}</g:else></g:set>
                                                <g:if test="${facetResult.fieldName?.contains("occurrence_date") && fieldResult.label?.endsWith("Z")}">
                                                    <li><g:set var="startYear" value="${fieldResult.label?.substring(0, 4)}"/>
                                                        <a href="?${queryParam}${appendQueryParam}&fq=${facetResult.fieldName}:[${fieldResult.label} TO ${dateRangeTo}]">${startYear} - ${startYear + 10}</a>
                                                        (<g:formatNumber number="${fieldResult.count}" type="number"/>)</li>
                                                </g:if>
                                                <g:elseif test="${fieldResult.label?.endsWith("before")}"><%-- skip --%></g:elseif>
                                                <g:elseif test="${fieldResult.label?.isEmpty()}">
                                                </g:elseif>
                                                <g:else>
                                                    <li><a href="?${request.queryString}&fq=${facetResult.fieldName}:%22${fieldResult.label}%22">
                                                        <g:message code="${facetResult.fieldName}.${fieldResult.label}" default="${fieldResult.label?:"[unknown]"}"/>
                                                    </a>
                                                        (<g:formatNumber number="${fieldResult.count}" type="number"/>)
                                                    </li>
                                                </g:else>
                                            </g:each>
                                        </ul>
                                    </div>
                                </g:if>
                            </g:each>
                        </div>
                    </div><!--end #facets-->
                </div><!--end .boxed-->
            </div><!--end .col-narrow-->
            <div class="span8">
                <div class="solrResults">
                    <div id="dropdownsXX">
                        <g:if test="${idxTypes.contains("TAXON")}">
                            <g:set var="downloadUrl" value="${grailsApplication.config.bie.baseURL}/ws/download/?${downloadParams}${appendQueryParam}&sort=${searchResults.sort}&dir=${searchResults.dir}"/>
                            <input type="button" onclick="window.location='${downloadUrl}'" value="Download" title="Download a list of taxa for your search" class="btn btn-small" style="float:left;"/>
                        </g:if>
                        <div id="sortWidgetXX" class="row-fluid form-horizontal">
                            <div class="span4 control-group">
                                <label class="control-label" for="per-page">Results per page</label>
                                <div class="controls">
                                    <select id="per-page" name="per-page" class="input-mini">
                                        <option value="10" ${(params.rows == '10') ? "selected=\"selected\"" : ""}>10</option>
                                        <option value="20" ${(params.rows == '20') ? "selected=\"selected\"" : ""}>20</option>
                                        <option value="50" ${(params.rows == '50') ? "selected=\"selected\"" : ""}>50</option>
                                        <option value="100" ${(params.rows == '100') ? "selected=\"selected\"" : ""} >100</option>
                                    </select>
                                </div>
                            </div>
                            <div class="span4 control-group">
                                <label class="control-label" for="sort">Sort by</label>
                                <div class="controls">
                                    <select id="sort" name="sort" class="input-medium">
                                        <option value="score" ${(params.sort == 'score') ? "selected=\"selected\"" : ""}>best match</option>
                                        <option value="commonNameSingle" ${(params.sort == 'commonNameSingle') ? "selected=\"selected\"" : ""}>common name</option>
                                        <option value="rank" ${(params.sort == 'rank') ? "selected=\"selected\"" : ""}>taxon rank</option>
                                    </select>
                                </div>
                            </div>
                            <div class="span4 control-group">
                                <label class="control-label" for="dir">Sort order</label>
                                <div class="controls">
                                    <select id="dir" name="dir" class="input-small">
                                        <option value="asc" ${(params.dir == 'asc') ? "selected=\"selected\"" : ""}>normal</option>
                                        <option value="desc" ${(params.dir == 'desc') ? "selected=\"selected\"" : ""}>reverse</option>
                                    </select>
                                </div>
                            </div>
                            <input type="hidden" value="${pageTitle}" name="title"/>
                        </div><!--sortWidget-->
                    </div><!--drop downs-->
                    <div class="results">
                        <g:each var="result" in="${searchResults.results}">
                            <g:set var="sectionText"><g:if test="${!facetMap.idxtype}"><span><b>Section:</b> <g:message code="idxType.${result.idxType}"/></span></g:if></g:set>
                                <g:if test="${result.has("idxType") && result.idxType == 'TAXON'}">
                                    <div class="row-fluid">
                                        <div class="span8">
                                            <h4>
                                            <g:set var="speciesPageLink">${request.contextPath}/species/${result.linkIdentifier?:result.guid}</g:set>

                                            <g:if test="${result.rank}"><span style="text-transform: capitalize; display: inline;">${result.rank}</span>:</g:if>
                                            <g:if test="${result.linkIdentifier}">
                                                <a href="${request.contextPath}/species/${result.linkIdentifier}" class="occurrenceLink"><bie:formatSciName rankId="${result.rankId}" name="${(result.nameComplete) ? result.nameComplete : result.name}" acceptedName="${result.acceptedConceptName}"/> </a>
                                            </g:if>
                                            <g:if test="${!result.linkIdentifier}">
                                                <a href="${request.contextPath}/species/${result.guid}" class="occurrenceLink"><bie:formatSciName rankId="${result.rankId}" name="${(result.nameComplete) ? result.nameComplete : result.name}" acceptedName="${result.acceptedConceptName}"/> </a>
                                            </g:if>
                                            <g:if test="${result.acceptedConceptName}">
                                                (accepted name: ${result.acceptedConceptName})
                                            </g:if>
                                            <g:if test="${result.commonNameSingle}"><span class="commonNameSummary">&nbsp;&ndash;&nbsp; ${result.commonNameSingle}</span></g:if>
                                            </h4>

                                            <p>
                                                <g:if test="${result.commonNameSingle && result.commonNameSingle != result.commonName}">
                                                    <span>${result.commonName}</span>
                                                </g:if>
                                                <g:if test="${false && result.highlight}">
                                                    <span><b>...</b> ${result.highlight} <b>...</b></span>
                                                </g:if>
                                                <g:if test="${result.kingdom}">
                                                    <span><strong class="resultsLabel">Kingdom</strong>: ${result.kingdom}</span>
                                                </g:if>
                                                <g:if test="${result.rankId && result.rankId > 5000}">
                                                    <span class="recordSighting" style="display:inline;">
                                                        <a href="${grailsApplication.config.brds.guidUrl}${result.guid}">Record a sighting/share a photo</a>
                                                    </span>&nbsp;
                                                    <g:if test="${result?.occCount?:0 > 0}">
                                                        <span class="recordSighting" style="display:inline;"><a href="${biocacheUrl}/occurrences/taxa/${result.guid}">Occurrences:
                                                            <g:formatNumber number="${result.occCount}" type="number"/></a></span>
                                                    </g:if>
                                                </g:if>
                                            </p>
                                        </div>
                                        <div class="span4">
                                            <g:if test="${result.smallImageUrl}">
                                                <a href="${speciesPageLink}" class="occurrenceLink"><img src="${result.smallImageUrl}" style="max-height: 150px; max-width: 300px; margin-top:10px;" alt="species image thumbnail"/></a>
                                            </g:if>
                                        </div>
                                    </div>

                                    <p>
                                    <!-- ${sectionText} -->
                                    </p>
                                </g:if>
                                <g:elseif test="${result.has("regionTypeName") && result.get("regionTypeName")}">
                                    <h4><g:message code="idxType.${result.idxType}"/>:
                                        <a href="${result.guid}">${result.name}</a></h4>
                                    <p>
                                        <span>Region type: ${result.regionTypeName}</span>
                                        <!-- ${sectionText} -->
                                    </p>
                                </g:elseif>
                                <g:elseif test="${result.has("institutionName") && result.get("institutionName")}">
                                    <h4><g:message code="idxType.${result.idxType}"/>:
                                        <a href="${result.guid}">${result.name}</a></h4>
                                    <p>
                                        <span>${result.institutionName}</span>
                                        <!-- ${sectionText} -->
                                    </p>
                                </g:elseif>
                                <g:elseif test="${result.has("acronym") && result.get("acronym")}">
                                    <h4><g:message code="idxType.${result.idxType}"/>:
                                        <a href="${result.guid}">${result.name}</a></h4>
                                    <p>
                                        <span>${result.acronym}</span>
                                        <!-- ${sectionText} -->
                                    </p>
                                </g:elseif>
                                <g:elseif test="${result.has("description") && result.get("description")}">
                                    <h4><g:message code="idxType.${result.idxType}"/>:
                                        <a href="${result.guid}">${result.name}</a></h4>
                                    <p>
                                        <span class="searchDescription">${result.description?.trimLength(500)}</span>
                                        <!-- ${sectionText} -->
                                    </p>
                                </g:elseif>
                                <g:elseif test="${result.has("highlight") && result.get("highlight")}">
                                    <h4><g:message code="idxType.${result.idxType}"/>:
                                        <a href="${result.guid}">${result.name}</a></h4>
                                    <p>
                                        <span>${result.highlight}</span>
                                        <!-- ${sectionText} -->
                                        %{--<br/>--}%
                                    </p>
                                </g:elseif>
                                <g:elseif test="${result.has("idxType") && result.idxType == 'LAYERS'}">
                                    <h4><g:message code="idxType.${result.idxType}"/>:
                                        <a href="${result.guid}">${result.name}</a></h4>
                                    <p>
                                        <span>${result.highlight}</span>
                                        <g:if test="${result.dataProviderName}"><strong>Source: ${result.dataProviderName}</strong></g:if>
                                    </p>
                                </g:elseif>
                                <g:else>
                                    <h4><g:message code="idxType.${result.idxType}"/>: <a href="${result.guid}">${result.name}</a></h4>
                                    <p><!-- ${sectionText} --></p>
                                </g:else>
                            <div class="resultSeparator">&nbsp;</div>
                        </g:each>
                    </div><!--close results-->
                    <g:if test="${false && searchResults && searchResults.totalRecords > searchResults.pageSize}">
                        <div id="searchNavBar">
                            <bie:searchNavigationLinks totalRecords="${searchResults?.totalRecords}" startIndex="${searchResults?.startIndex}"
                                      lastPage="${lastPage?:-1}" pageSize="${searchResults?.pageSize}"/>
                        </div>
                    </g:if>
                    <div id="searchNavBar" class="pagination">
                        <g:paginate total="${searchResults?.totalRecords}" action="list"  params="${[q: params.q, fq: params.fq, dir: params.dir ]}"/>
                    </div>
                </div><!--solrResults-->
            </div><!--end .col-wide last-->
        </div><!--end .inner-->
    </g:if>
</body>
</html>