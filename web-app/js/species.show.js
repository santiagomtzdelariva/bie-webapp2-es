/*
 * Copyright (C) 2012 Atlas of Living Australia
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */

/**
 *
 * Javascript for species "show" page.
 *
 * User: nick
 * Date: 12/06/12
 * Time: 2:15 PM
 */

/**
 * jQuery page onload callback
 */
function showSpeciesPage() {

    console.log("Starting show species page");

    loadOverviewImages();

    var bhlInit = false;
    var galleryInit = false;
    $('a[data-toggle="tab"]').on('shown', function(e) {
        //console.log("this", $(this).attr('id'));
        var id = $(this).attr('id');
        if (id == "t6" && !bhlInit) {
            doBhlSearch(0, 10, false);
            bhlInit = true;
        } else if (id == "t2" && !galleryInit) {
            loadGalleries();
            galleryInit = true;
        }
        if (id != "t1") {
            location.hash = 'tab_'+ $(e.target).attr('href').substr(1);
        } else {
            location.hash = '';
        }
    });
    //setup tabs
    if (location.hash !== '') {
        $('.nav-tabs a[href="' + location.hash.replace('tab_','') + '"]').tab('show');
    }
    $(window).on('hashchange', function() {
        //console.log('hashchange');
        var currentHash = location.hash.replace('tab_','');
        if (location.hash !== '') {
            //console.log('changing tab to ' + currentHash);
            $('.nav-tabs a[href="' + currentHash + '"]').tab('show');
        } else {
            $('.nav-tabs a:first').tab('show');
        }
    });

    // Gallery image popups using ColorBox
    $('body').on('click', '.thumbImage', function() {
        $("a.thumbImage").colorbox({
            title: function () {
                var titleBits = this.title.split("|");
                return "<a href='" + titleBits[1] + "'>" + titleBits[0] + "</a>";
            },
            opacity: 0.5,
            photo: true,
            maxWidth: "80%",
            maxHeight: "80%",
            preloading: false,
            onComplete: function () {
                $("#cboxTitle").html(""); // Clear default title div
                //console.log('colorbox onComplete', $(this));
                var contentElement = $(this).find('.detail').clone();
                var uuid = $(this).data('occurrenceuid');
                $('#' + uuid).remove(); // clear previous data
                var extraData = '<div class="rights">&nbsp;</div><div class="recordLink"><a href="' + SHOW_CONF.biocacheUrl + '/occurrences/' + uuid + '">View details of this record</a></div>';
                contentElement.attr('id', $(this).data('id'));
                contentElement.append(extraData);
                //console.log("contentElement", contentElement.html(), uuid);
                var titleHtml = contentElement.html(); // use index to load meta data
                $("<div class='titleText' id='" + uuid + "'>" + titleHtml + "</div>").insertAfter("img.cboxPhoto");
                $("div.titleText").css("padding-top", "8px");
                var cbox = $.fn.colorbox;
                if (cbox != undefined) {
                    cbox.resize();
                }

                // load extra data via JSON GET
                if (uuid) {
                    var url = SHOW_CONF.biocacheServiceUrl + "/occurrences/" + uuid + ".json?callback=?";
                    //console.log('occurrenceUid', occurrenceUid, url);
                    $.ajax({
                        url: url,
                        dataType: "jsonp",
                        async: false
                    }).done(function (data) {
                        //console.log('data.raw', data.raw);
                        if (data.raw && data.raw.occurrence && data.raw.occurrence.rights) {
                            //console.log('rights', data.raw.occurrence.rights, $('#' + uuid).html());
                            $('#' + uuid).find('.rights').html('Rights: ' + data.raw.occurrence.rights);
                        }
                    });
                }
            }
        });
    });


    // Charts via collectory charts.js
    var chartOptions = {
        query: SHOW_CONF.scientificName,
        biocacheServicesUrl: SHOW_CONF.biocacheServiceUrl,
        collectionsUrl: SHOW_CONF.collectoryUrl,
        totalRecordsSelector: "span#occurenceCount",
        chartsDiv: "recordBreakdowns",
        error: chartsError,
        width: 540,
        charts: ['collection_uid','state','month','occurrence_year'],
        collection_uid: {title: 'By collection'},
        state: {title: 'By state & territory'},
        month: {chartType: "column"},
        occurrence_year: {chartType: "column"}
    };

    console.log("Charts showSpeciesPage");
    console.log(SHOW_CONF);
    console.log("chartOptions");
    console.log(chartOptions);

    loadFacetCharts(chartOptions);
    //facetChartGroup.loadAndDrawFacetCharts(chartOptions);

    // alerts button
    $("#alertsButton").click(function(e) {
        e.preventDefault();
        //console.log("alertsButton");
        var query = "Species: " + SHOW_CONF.scientificName;
        var searchString = "?q=" + SHOW_CONF.guid;
        //console.log("fqueries",fqueries, query);
        var url = SHOW_CONF.alertsUrl + "createBiocacheNewRecordsAlert?";
        url += "queryDisplayName=" + encodeURIComponent(query);
        url += "&baseUrlForWS=" + encodeURIComponent(SHOW_CONF.biocacheUrl);
        url += "&baseUrlForUI=" + encodeURIComponent(SHOW_CONF.serverName);
        url += "&webserviceQuery=%2Fws%2Foccurrences%2Fsearch" + encodeURIComponent(searchString);
        url += "&uiQuery=%2Foccurrences%2Fsearch%3Fq%3D*%3A*";
        url += "&resourceName=" + encodeURIComponent("Atlas of Living Australia");
        window.location.href = url;
    });

    $(".thumbImageBrowse").tooltip();
    $(".col-narrow a").tooltip({ position: "bottom right", offset: [0, -20], opacity: 0.9});

    // mouse over affect on thumbnail images
    $('#gallery').on('hover', '.imgCon', function() {
        $(this).find('.brief, .detail').toggleClass('hide');
    });

    // add expert distrobution map
    addExpertDistroMap();


    //Trove search results
    setupTrove(SHOW_CONF.scientificName,'trove-container','trove-results-home','previousTrove','nextTrove');
}

function chartsError() {
    $("#chartsError").html("An error occurred and charts cannot be displayed at this time.");
}

/**
 * Trigger loading of the 3 gallery sections
 */
function loadGalleries() {
    //alert('loading galleries');
    $('#gallerySpinner').show();
    loadGalleryType('type', 0)
    loadGalleryType('specimen', 0)
    loadGalleryType('other', 0)
}

function loadOverviewImages(){

    //TODO a toggle between LSID based searches and names searches
    var url = SHOW_CONF.biocacheServiceUrl  +
        '/occurrences/search.json?q=' +
        SHOW_CONF.scientificName +
        '&fq=multimedia:"Image"&facet=off&pageSize=4&start=0&callback=?';

    console.log('Loading images from: ' + url);

    $.getJSON(url, function(data){
        if (data && data.totalRecords > 0) {

            $('#noOverviewImages').addClass('hide');

            var $categoryTmpl = $('#overviewImages');
            $categoryTmpl.removeClass('hide');

            var $mainOverviewImage = $('.mainOverviewImage');
            $mainOverviewImage.attr('src', data.occurrences[0].largeImageUrl);
            $mainOverviewImage.parent().attr('href', data.occurrences[0].largeImageUrl);
            $mainOverviewImage.parent().attr('data-title', data.occurrences[0].dataResourceName);
            $mainOverviewImage.parent().attr('data-footer', data.occurrences[0].dataResourceName);

            $('.mainOverviewImageInfo').html(data.occurrences[0].dataResourceName);

            var $secondOverviewImage = $('.secondOverviewImage');
            $secondOverviewImage.attr('src', data.occurrences[1].smallImageUrl);

            var $thirdOverviewImage = $('.thirdOverviewImage');
            $thirdOverviewImage.attr('src', data.occurrences[2].smallImageUrl);

            $('.lightbox-img').ekkoLightbox(options);
        }
    }).fail(function(jqxhr, textStatus, error) {
        alert('Error loading gallery: ' + textStatus + ', ' + error);
    }).always(function() {
        $('#gallerySpinner').hide();
    });
}

/**
 * AJAX loading of gallery images from biocache-service
 *
 * @param category
 * @param start
 */
function loadGalleryType(category, start) {
    // type: &fq=multimedia:"Image"&fq=type_status:*&pageSize=100&facet=off
    // specimen: &fq=multimedia:"Image"&fq=basis_of_record:PreservedSpecimen&fq=-type_status:*&pageSize=100&facet=off
    // other: &fq=multimedia:"Image"&fq=-type_status:*&fq=-basis_of_record:PreservedSpecimen&pageSize=100&facet=off

    var imageCategoryParams = {
        type: '&fq=type_status:*',
        specimen: '&fq=basis_of_record:PreservedSpecimen&fq=-type_status:*',
        other: '&fq=-type_status:*&fq=-basis_of_record:PreservedSpecimen'
    };
    var pageSize = 20;

    if (start > 0) {
        $('.loadMore.' + category + ' button').addClass('disabled');
        $('.loadMore.' + category + ' img').removeClass('hide');
    }

    //TODO a toggle between LSID based searches and names searches
    var url = SHOW_CONF.biocacheServiceUrl  + '/occurrences/search.json?q=' +
        SHOW_CONF.scientificName +
        '&fq=multimedia:"Image"&pageSize=' + pageSize +
        '&facet=off&start=' + start + imageCategoryParams[category] + '&callback=?';

    $.getJSON(url, function(data){
        if (data && data.totalRecords > 0) {
            var br = "<br>";
            var $categoryTmpl = $('#cat_' + category);
            $categoryTmpl.removeClass('hide');

            $.each(data.occurrences, function(i, el) {
                // clone template div & populate with metadata
                var $ImgConTmpl = $('.imgConTmpl').clone();
                $ImgConTmpl.removeClass('imgConTmpl').removeClass('hide');
                var link = $ImgConTmpl.find('a.cbLink')
                link.attr('id','thumb_' + category + i);
                link.addClass('thumbImage tooltips');
                link.attr('href', el.largeImageUrl);
                link.attr('title', 'click to enlarge');
                link.attr('data-id', category + i);
                link.attr('data-occurrenceuid', el.uuid);
                link.attr('data-category', category);
                $ImgConTmpl.find('img').attr('src', el.smallImageUrl);
                // brief metadata
                var briefHtml = el.raw_scientificName;
                if (el.typeStatus) briefHtml += br + el.typeStatus;
                if (el.institutionName) briefHtml += ((el.typeStatus) ? ' | ' : br) + el.institutionName;
                $ImgConTmpl.find('.brief').html(briefHtml);
                // detail metadata
                var detailHtml = el.raw_scientificName;
                if (el.typeStatus) detailHtml += br + 'Type: ' + el.typeStatus;
                if (el.collector) detailHtml += br + 'By: ' + el.collector;
                if (el.eventDate) detailHtml += br + 'Date: ' + moment(el.eventDate).format('YYYY-MM-DD');
                if (el.institutionName) {
                    detailHtml += br + el.institutionName;
                } else {
                    detailHtml += br + el.dataResourceName;
                }

                // write to DOM
                $ImgConTmpl.find('.detail').html(detailHtml);
                $categoryTmpl.find('.subGallery').append($ImgConTmpl.html());
            });

            $('.loadMore.' + category).remove(); // remove 'load more images' button that was just clicked

            if (data.totalRecords > (start + pageSize)) {
                // add new 'load more images' button if required
                var spinnerLink = $('#gallerySpinner img').attr('src');
                var btn = '<div class="loadMore ' + category + '"><br><button class="btn" onCLick="loadGalleryType(\'' + category + '\','
                    + (start + pageSize)  + ');">Load more images <img src="' + spinnerLink + '" class="hide"/></button></div>';
                $categoryTmpl.find('.subGallery').append(btn);
            }
        }
    }).fail(function(jqxhr, textStatus, error) {
        alert('Error loading gallery: ' + textStatus + ', ' + error);
    }).always(function() {
        $('#gallerySpinner').hide();
    });
}

/**
 * BHL search to populate literature tab
 *
 * @param start
 * @param rows
 * @param scroll
 */
function doBhlSearch(start, rows, scroll) {
    if (!start) {
        start = 0;
    }
    if (!rows) {
        rows = 10;
    }
    // var url = "http://localhost:8080/bhl-ftindex-demo/search/ajaxSearch?q=" + $("#tbSearchTerm").val();
    var taxonName = SHOW_CONF.scientificName ;
    var synonyms = SHOW_CONF.synonymsQuery;
    var query = ""; // = taxonName.split(/\s+/).join(" AND ") + synonyms;
    if (taxonName) {
        var terms = taxonName.split(/\s+/).length;
        if (terms > 2) {
            query += taxonName.split(/\s+/).join(" AND ");
        } else if (terms == 2) {
            query += '"' + taxonName + '"';
        } else {
            query += taxonName;
        }
    }
    if (synonyms) {
        //synonyms = "  " + ((synonyms.indexOf("OR") != -1) ? "(" + synonyms + ")" : synonyms);
        query += (taxonName) ? ' OR ' + synonyms : synonyms;
    }

    if (!query) {
        return cancelSearch("No names were found to search BHL");
    }

    var url = "http://bhlidx.ala.org.au/select?q=" + query + '&start=' + start + "&rows=" + rows +
        "&wt=json&fl=name%2CpageId%2CitemId%2Cscore&hl=on&hl.fl=text&hl.fragsize=200&" +
        "group=true&group.field=itemId&group.limit=7&group.ngroups=true&taxa=false";
    var buf = "";
    $("#status-box").css("display", "block");
    $("#synonyms").html("").css("display", "none")
    $("#results").html("");

    $.ajax({
        url: url,
        dataType: 'jsonp',
        //data: null,
        jsonp: "json.wrf",
        success:  function(data) {
            var itemNumber = parseInt(data.responseHeader.params.start, 10) + 1;
            var maxItems = parseInt(data.grouped.itemId.ngroups, 10);
            if (maxItems == 0) {
                return cancelSearch("No references were found for <pre>" + query + "</pre>");
            }
            var startItem = parseInt(start, 10);
            var pageSize = parseInt(rows, 10);
            var showingFrom = startItem + 1;
            var showingTo = (startItem + pageSize <= maxItems) ? startItem + pageSize : maxItems ;
            //console.log(startItem, pageSize, showingTo);
            var pageSize = parseInt(rows, 10);
            buf += '<div class="results-summary">Showing ' + showingFrom + " to " + showingTo + " of " + maxItems +
                ' results for the query <pre>' + query + '</pre></div>'
            // grab highlight text and store in map/hash
            var highlights = {};
            $.each(data.highlighting, function(idx, hl) {
                highlights[idx] = hl.text[0];
                //console.log("highlighting", idx, hl);
            });
            //console.log("highlighting", highlights, itemNumber);
            $.each(data.grouped.itemId.groups, function(idx, obj) {
                buf += '<div class="result-box">';
                buf += '<b>' + itemNumber++;
                buf += '.</b> <a target="item" href="http://biodiversitylibrary.org/item/' + obj.groupValue + '">' + obj.doclist.docs[0].name + '</a> ';
                var suffix = '';
                if (obj.doclist.numFound > 1) {
                    suffix = 's';
                }
                buf += '(' + obj.doclist.numFound + '</b> matching page' + suffix + ')<div class="thumbnail-container">';

                $.each(obj.doclist.docs, function(idx, page) {
                    var highlightText = $('<div>'+highlights[page.pageId]+'</div>').htmlClean({allowedTags: ["em"]}).html();
                    buf += '<div class="page-thumbnail"><a target="page image" href="http://biodiversitylibrary.org/page/' +
                        page.pageId + '"><img src="http://biodiversitylibrary.org/pagethumb/' + page.pageId +
                        '" alt="Page Id ' + page.pageId + '"  width="60px" height="100px"/><div class="highlight-context">' +
                        highlightText + '</div></a></div>';
                })
                buf += "</div><!--end .thumbnail-container -->";
                buf += "</div>";
            })

            var prevStart = start - rows;
            var nextStart = start + rows;
            //console.log("nav buttons", prevStart, nextStart);

            buf += '<div id="button-bar">';
            if (prevStart >= 0) buf += '<input type="button" class="btn" value="Previous page" onclick="doBhlSearch(' + prevStart + ',' + rows + ', true)">';
            buf += '&nbsp;&nbsp;&nbsp;';
            if (nextStart <= maxItems) buf += '<input type="button" class="btn" value="Next page" onclick="doBhlSearch(' + nextStart + ',' + rows + ', true)">';
            buf += '</div>';

            $("#solr-results").html(buf);
            if (data.synonyms) {
                buf = "<b>Synonyms used:</b>&nbsp;";
                buf += data.synonyms.join(", ");
                $("#synonyms").html(buf).css("display", "block");
            } else {
                $("#synonyms").html("").css("display", "none");
            }
            $("#status-box").css("display", "none");

            if (scroll) {
                $('html, body').animate({scrollTop: '300px'}, 300);
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            $("#status-box").css("display", "none");
            $("#solr-results").html('An error has occurred, probably due to invalid query syntax');
        }
    });
} // end doSearch

function cancelSearch(msg) {
    $("#status-box").css("display", "none");
    $("#solr-results").html(msg);
    return true;
}

/**
 * Taken from bie-webapp (by Wai)
 * TODO needs to be improved to handle failed json GET (controller needs to return status code if failed?)
 *
 * @param guid
 * @param uri
 * @param infosourceId
 * @param documentId
 * @param blackList
 * @param positive
 * @param name
 */
function rankThisImage(guid, uri, infosourceId, documentId, blackList, positive, name){
    var encodedUri = escape(uri);
    var controllerSuffix = (SHOW_CONF.remoteUser) ? "WithUser" : "";
    var url = SHOW_CONF.bieUrl + "/rankTaxonImage" + controllerSuffix + ".json?guid="+guid+"&uri="+encodedUri+"&infosourceId="+infosourceId+"&blackList="+blackList+"&positive="+positive+"&name="+name+"&callback=?";
    $('.imageRank-'+documentId).html('Sending your ranking....');
    $.getJSON(url, function(data){ })
    $('.imageRank-'+documentId).each(function(index) {
        $(this).html('Thanks for your help!');
    }).error(function(jqXHR, textStatus, errorThrown) {
        // catch ajax errors (requires JQuery 1.5+) - usually 500 error
        $(this).html('An error occurred: ' + errorThrown + " (" + jqXHR.status + ")");
    });
}

function editThisImage(guid, uri){
    var encodedUri = escape(uri);
    var url = SHOW_CONF.bieUrl + "/admin/edit?guid="+guid+"&uri="+encodedUri;
    window.open(url);
}

function rankThisCommonName(guid, documentId, blackList, positive, name) {
    var controllerSuffix = (SHOW_CONF.remoteUser) ? "WithUser" : "";
    var url = SHOW_CONF.bieUrl + "/rankTaxonCommonName" + controllerSuffix + ".json?guid="+guid+"&blackList="+blackList+"&positive="+positive+"&name="+name+"&callback=?";
    var linkId = 'cnRank-'+documentId;
    $('#cnRank-'+documentId).html('Sending your ranking....');
    var jqxhr = $.getJSON(url, function(data){
        $('#cnRank-'+documentId).each(function(index) {
            $(this).html('Thanks for your help!');
        });
    }).error(function(jqXHR, textStatus, errorThrown) {
        // catch ajax errors (requires JQuery 1.5+) - usually 500 error
        $('#cnRank-'+documentId).html('An error occurred: ' + errorThrown + " (" + jqXHR.status + ")");
    });
}

function addExpertDistroMap() {
    var url = "http://spatial.ala.org.au/layers-service/distribution/map/" + SHOW_CONF.guid + "?callback=?";
    $.getJSON(url, function(data){
        if (data.available) {
            $("#expertDistroDiv img").attr("src", data.url);
            if (data.dataResourceName && data.dataResourceUrl) {
                var attr = $('<a>').attr('href', data.dataResourceUrl).text(data.dataResourceName)
                $("#expertDistroDiv #dataResource").html(attr);
            }
            $("#expertDistroDiv").show();
        }
    })
}