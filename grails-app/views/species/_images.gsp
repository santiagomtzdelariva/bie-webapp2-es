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
<style type="text/css">
    .imgCon {
        display: inline-block;
        /* margin-right: 8px; */
        text-align: center;
        line-height: 1.3em;
        background-color: #DDD;
        color: #DDD;
        font-size: 12px;
        /*text-shadow: 2px 2px 6px rgba(255, 255, 255, 1);*/
        /* padding: 5px; */
        /* margin-bottom: 8px; */
        margin: 2px 0 2px 0;
        position: relative;
    }
    .imgCon .brief {
        color: black;
        background-color: white;
    }
    .imgCon .meta {
        opacity: 0.8;
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        overflow: hidden;
        text-align: left;
        padding: 4px 5px 2px 5px;
    }
</style>
<g:each var="image" in="${images}" status="status">
    <g:if test="${!image.isBlackListed}">
        <div class="imgCon">
            <a class="thumbImage" rel="thumbs" title="${image.title?:''}" href="${image.largeImageUrl}" data-occurrenceuid="${image.occurrenceUid}"
               id="thumb${status}"><img src="${image.smallImageUrl}" alt="${image.infoSourceName}"
                                        alt="${image.title}" height="100px"
                                        style="height:150px;padding-right:3px;"/>
                <g:if test="${includeName}">
                    <div class="meta brief">
                        <bie:formatSciName name="${image.name}" rankId="${image.taxonRankID}"/>
                        <g:if test="${image.type}"><br>Type: ${image.type}</g:if>
                    </div>
                </g:if>
                <g:else>
                    <div class="meta brief">
                        ${image.title} ${image.creator ? ' – ' + image.creator : ''}
                    </div>
                </g:else>
            </a>
        </div>
        <div id="thumbDiv${status}" style="display:none;">
            <g:if test="${image.title}">
                <span class="imageTitle">${image.title}</span><br/>
            </g:if>
            <g:if test="${image.creator}">
                <span class="imageMetadataField">Image by:</span>
                <bie:lookupUserName id="${image.creator}"/><br/>
            </g:if>
            <g:if test="${image.type}">
                <span class="imageMetadataField">Type:</span> ${image.type}<br/>
            </g:if>
            <g:if test="${image.locality}">
                <span class="imageMetadataField">Locality:</span> ${image.locality}<br/>
            </g:if>
            <g:if test="${image.licence}">
                <span class="imageMetadataField">Licence:</span> ${image.licence}<br/>
            </g:if>
            <g:else>
                <span class="hide imageMetadataField licence">Licence: <span class="imageLicence"></span><br/></span>
            </g:else>
            <g:if test="${image.rights}">
                <span class="imageMetadataField">Rights:</span> ${image.rights}<br/>
            </g:if>
            <g:else>
                <span class="hide imageMetadataField rights">Rights: <span class="imageRights"></span><br/></span>
            </g:else>
        <!-- Flickr images need to use identifier instead of isPartOf for the imageUri -->
            <g:set var="imageUri">
                <g:if test="${image.isPartOf && !image.identifier?.startsWith('http://www.flickr.com') }">
                    ${image.isPartOf}
                </g:if>
                <g:elseif test="${image.identifier}">
                    ${image.identifier}
                </g:elseif>
                <g:else>
                    ${image.infoSourceURL}
                </g:else>
            </g:set>
            <g:if test="${image.infoSourceURL == 'http://www.ala.org.au'}">
                <cite><span class="imageMetadataField">Source:</span> ${image.infoSourceName}</cite>
            </g:if>
            <g:elseif test="${image.infoSourceURL == 'http://www.elfram.com/'}">
                <cite><span class="imageMetadataField">Source:</span> <a href="${image.infoSourceURL}" target="_blank" class="external">${image.infoSourceName}</a></cite>
            </g:elseif>
            <g:else>
                <cite><span class="imageMetadataField">Source:</span> <a href="${imageUri}" target="_blank" class="external">${image.infoSourceName}</a></cite>
            </g:else>
            <g:if test="${image.occurrenceUid}">
                <p><a href="http://biocache.ala.org.au/occurrences/${image.occurrenceUid}" target="_blank">View more details for this image</a></p>
            </g:if>
            <g:if test="${!isReadOnly}">
                <p class="imageRank-${image.documentId}">
                %{--<cite>--}%
                    <g:if test="${rankedImageUris?.contains(image.identifier)}">
                        You have ranked this image as
                        <g:if test="${!rankedImageUriMap[image.identifier]}">
                            NOT
                        </g:if>
                        representative of ${tc.taxonConcept.nameString}
                    </g:if>
                    <g:else>
                        Is this image representative of ${tc.taxonConcept.rankString}?
                        <a class="isrepresent"
                           href="#" onclick="rankThisImage('${guid}','${image.identifier}','${image.infoSourceId}','${image.documentId}',false,true,'${tc.taxonConcept.nameString}');return false;">
                            YES
                        </a> |
                        <a class="isnotrepresent" href="#"
                           onclick="rankThisImage('${guid}','${image.identifier}','${image.infoSourceId}','${image.documentId}',false,false,'${tc.taxonConcept.nameString}');return false;">
                            NO
                        </a>
                        <g:if test="${isRoleAdmin}">
                            <br/><a class="isnotrepresent" href="#"
                                    onclick="rankThisImage('${guid}','${image.identifier}','${image.infoSourceId}','${image.documentId}',true,false,'${tc.taxonConcept.nameString}');return false;">
                            BlackList</a> |
                            <a class="isnotrepresent" href="#" onClick="editThisImage('${guid}', '${image.identifier}');return false;">Edit</a>
                        </g:if>
                    </g:else>
                %{--</cite>--}%
                </p>
            </g:if>
            <g:else>
                <p class="imageRank-${image.documentId}">
                    <b>Read Only Mode</b>
                </p>
            </g:else>
        </div>
    </g:if>
</g:each>