use bie;

-- taxonomic sources
INSERT INTO infosource (id, name, uri, logo_url, dataset_type, description) VALUES
(1, "Australian Faunal Directory", "http://www.environment.gov.au/biodiversity/abrs/online-resources/fauna/afd/home",
"LOGO_URL", 1, "The Australian Faunal Directory is an online catalogue of taxonomic and biological information on all animal species known to occur within Australia."),
(2, "Australian Plant Names Index", "http://www.anbg.gov.au/apni/",
"LOGO_URL", 1, "APNI is a tool for the botanical community that deals with plant names and their usage in the scientific literature, whether as a current name or synonym. APNI does not recommend any particular taxonomy or nomenclature."),
(3, "Catalogue of Life: 2009 Annual Checklist", "http://www.catalogueoflife.org/",
"LOGO_URL", 1, "The Species 2000 & ITIS Catalogue of Life is planned to become a comprehensive catalogue of all known species of organisms on Earth."),
(4, "Interim Register of Marine and Non-marine Genera", "http://www.cmar.csiro.au/datacentre/irmng/",
"LOGO_URL", 1, "The Interim Register of Marine and Nonmarine Genera (IRMNG) is a project of OBIS Australia designed to assist in the provision of marine species data to OBIS, by permitting the discrimination of marine from nonmarine (and extant from fossil) species records on the basis of the genus name portion of their scientific name (normally, genus + species, or genus + species + infraspecies if applicable)"),
(5, "Australian Plant Census", "http://www.anbg.gov.au/chah/apc/",
"LOGO_URL", 1, "The Australian Plant Census (APC) provides a list of currently accepted names for the Australian vascular flora, both native and introduced, but DOES NOT provide full details of their usage in the taxonomic literature.");

-- external web sources
INSERT INTO infosource (id, name, dataset_type, uri, document_mapper, harvester_id, connection_params) VALUES
(1000,"Australian Biological Resources Study - Species Bank",2, "http://www.environment.gov.au/biodiversity/abrs/online-resources/species-bank/index.html","org.ala.documentmapper.AbrsDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/abrs/siteMap.txt""}"),
(1001,"ABRS Flora of Australia Online",2,"http://www.environment.gov.au/biodiversity/abrs/online-resources/flora/main/index.html","org.ala.documentmapper.AbrsFloraOfOzOnlineDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/abrsfloraozonline/siteMap.txt""}"),
(1002,"Ants Down Under",2,"http://anic.ento.csiro.au/ants/index.aspx","org.ala.documentmapper.AduDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/adu/siteMap.txt""}"),
(1003,"Australian Insect Common Names",2,"http://www.ento.csiro.au/aicn/index.htm","org.ala.documentmapper.AicnDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/aicn/siteMap.txt""}"),
(1004,"Online Photographic Guide to Marine Invertebrates of Southern Australia",2,"http://www.ausmarinverts.net/index.html","org.ala.documentmapper.AusmarinvDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/ausmarinv/siteMap.txt""}"),
-- (1005,"Australian Moths Online",3,"http://www.ento.csiro.au/gallery/moths/","org.ala.documentmapper.AmoDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/ausmoths/siteMap.txt""}"),
(1006,"Australian Moths Online",3,"http://www1.ala.org.au/gallery2/main.php","org.ala.documentmapper.AusmothsDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/ausmothsonline/siteMap.txt""}"),
(1007,"Australian Museum Factsheets",2,"http://australianmuseum.net.au/","org.ala.documentmapper.AmfDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/ausmus/siteMap.txt""}"),
(1008,"Birds in Backyards",2,"http://www.birdsinbackyards.net/","org.ala.documentmapper.BibDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/bib/siteMap.txt""}"),
(1009,"Department of Environment and Conservation - NSW threatened species ",2,"http://www.threatenedspecies.environment.nsw.gov.au/tsprofile/index.aspx","org.ala.documentmapper.DecDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/dec/siteMap.txt""}"),
(1010,"Desert Fishes Council",2,"http://www.desertfishes.org/australia/index.html","org.ala.documentmapper.AdfdDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/desertfishes/siteMap.txt""}"),
(1011,"Species Profile and Threats Database",2,"http://www.environment.gov.au/cgi-bin/sprat/public/sprat.pl","org.ala.documentmapper.EpbcDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/epbc/siteMap.txt""}"),
(1012,"Seafood Services Australia",2,"http://www.fishnames.com.au/","org.ala.documentmapper.FishnamesDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/fishnames/siteMap.txt""}"),
(1013,"Flickr EOL",3,"http://www.flickr.com/groups/encyclopedia_of_life/","org.ala.documentmapper.FlickrDocumentMapper",2,"{""endpoint"":""http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=08f5318120189e9d12669465c0113351&page=1"",""eolGroupId"":""806927@N20"",""flickrRestBaseUrl"":""http://api.flickr.com/services/rest"",""flickrApiKey"":""08f5318120189e9d12669465c0113351"",""recordsPerPage"":""50""}"),
(1014,"FloraBase - the Western Australian Flora",2,"http://florabase.dec.wa.gov.au/","org.ala.documentmapper.FloraBaseHtmlDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/florabase/siteMap.txt""}"),
(1015,"Plant NET Flora Online",2,"http://plantnet.rbgsyd.nsw.gov.au/floraonline.htm","org.ala.documentmapper.PlantNETFloraOnlineDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/floraonline/siteMap.txt""}"),
(1016,"Fishes of Australia Online",2,"http://www.marine.csiro.au/caab/","org.ala.documentmapper.FaoDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/foa/siteMap.txt""}"),
(1017,"Internet Bird Collection",2,"http://ibc.lynxeds.com/","org.ala.documentmapper.IbcDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/ibc/siteMap.txt""}"),
(1018,"Australian Museum - Larval Fishes",2,"http://larval-fishes.australianmuseum.net.au/","org.ala.documentmapper.AmlfDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/larvalfishes/siteMap.txt""}"),
(1019,"Ladybirds of Australia",2,"http://www.ento.csiro.au/biology/ladybirds/ladybirds.htm","org.ala.documentmapper.LoAHtmlDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/loa/siteMap.txt""}"),
(1020,"A Guide to the Marine Molluscs of Tasmania",2,"http://www.molluscsoftasmania.net/","org.ala.documentmapper.MotHtmlDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/mot/siteMap.txt""}"),
(1021,"National Introduced Marine Pest Information System (NIMPIS)",2,"http://www.marinepests.gov.au/","org.ala.documentmapper.NimpisDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/nimpis/siteMap.txt""}"),
(1022,"EucaLink - A Web Guide to the Eucalypts",2,"http://plantnet.rbgsyd.nsw.gov.au/PlantNet/Euc/index.html","org.ala.documentmapper.NswEcualyptsDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/nswecualypts/siteMap.txt""}"),
(1023,"PaDIL",2,"http://www.padil.gov.au/","org.ala.documentmapper.PaDILDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/padil/siteMap.txt""}"),
(1024,"Prosea",2,"http://www.proseanet.org/","org.ala.documentmapper.ProseaDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/prosea/siteMap.txt""}"),
(1025,"Reptiles Down Under",2,"http://www.reptilesdownunder.com/","org.ala.documentmapper.RduDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/rdu/siteMap.txt""}"),
(1026,"Sea shells of New South Wales",2,"http://seashellsofnsw.org.au/","org.ala.documentmapper.SeashellsNSWDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/seashellsnsw/siteMap.txt""}"),
(1027,"Sea Slug Forum",2,"http://www.seaslugforum.net/","org.ala.documentmapper.SsfDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/seaslug/siteMap.txt""}"),
(1028,"New South Wales Flora Online - Weed Alert",2,"http://plantnet.rbgsyd.nsw.gov.au/floraonline.htm","org.ala.documentmapper.PlantNETFloraOnlineDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/weedalert/siteMap.txt""}"),
(1029,"World Thysanoptera",2,"http://anic.ento.csiro.au/thrips/","org.ala.documentmapper.WtaDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/wta/siteMap.txt""}"),
(1030,"Guide to the Marine Zooplankton of South Eastern Australia",2,"http://www.tafi.org.au/zooplankton/","org.ala.documentmapper.ZseaDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/zooplankton/siteMap.txt""}"),
(1031,"Queensland Government - Endangered (Department of Environment and Resource Management)",2,"http://www.derm.qld.gov.au/wildlife-ecosystems/wildlife/threatened_plants_and_animals/endangered/","org.ala.documentmapper.QgeDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/qge/siteMap.txt""}"),
(1032,"South Australian Biodiversity - Threatened Fauna",2,"http://www.environment.sa.gov.au/biodiversity/threatened-species/threatened.html","org.ala.documentmapper.SabDocumentMapper",1,"{""mimeType"":""application/pdf"",""sitemap"":""http://www2.ala.org.au/sitemaps/sab/siteMap.txt""}"),
(1033,"Northern Territory Threatened Species List",2,"http://www.nt.gov.au/nreta/wildlife/animals/threatened/","org.ala.documentmapper.NttsDocumentMapper",1,"{""mimeType"":""application/pdf"",""sitemap"":""http://www2.ala.org.au/sitemaps/ntts/siteMap.txt""}"),
(1034,"Australian Plant Image Index",3,"http://www.anbg.gov.au/anbg/photo-collection/index.html","org.ala.documentmapper.ApiiDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/apii/siteMap.txt""}"),
(1035,"Australian Native Plants Society (Australia)",2,"http://asgap.org.au/","org.ala.documentmapper.AnpsDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/anps/siteMap.txt""}"),
(1036,"Wikipedia",3,"http://en.wikipedia.org/","org.ala.documentmapper.WikipediaDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/wikipedia/siteMap.txt""}"),
(1037,"Weeds in Australia",2,"http://www.weeds.gov.au/","org.ala.documentmapper.WeedDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/weed/siteMap.txt""}"),
(1038,"Weeds Australia",2,"http://www.weeds.org.au/","org.ala.documentmapper.WeedsOrgDocumentMapper",1,"{""mimeType"":""text/html"",""sitemap"":""http://www2.ala.org.au/sitemaps/weedsorg/siteMap.txt""}");
