source("library_script.R")


## National platforms

Natl_D_text <- read_html("https://www.presidency.ucsb.edu/documents/2020-democratic-party-platform") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "col-sm-8", " " ))]') %>%
  html_text()  %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

Natl_D_text[[1]] <- Natl_D_text[[1]][-556:-560] #remove website note

Natl_D_text[[1]] <- Natl_D_text[[1]][-1:-29] #remove header, acknowledgement

Natl_D_text <- join_scrape(Natl_D_text, "Natl", "D")



Natl_R_text <- read_html("https://www.presidency.ucsb.edu/documents/2016-republican-party-platform") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "col-sm-8", " " ))]') %>%
  html_text()    %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

Natl_R_text[[1]] <- Natl_R_text[[1]][-504:-594] #remove committee members, website note

Natl_R_text[[1]] <- Natl_R_text[[1]][-1:-25] #remove header, acknowledgement

Natl_R_text <- join_scrape(Natl_R_text, "Natl", "R")


## Alabama (AL)
AL_D_text <- read_html("https://aldemocrats.org/our-party/principles") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "col-sm-12", " " ))]') %>%
  html_text() %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

AL_D_text <- AL_D_text[[-2]]

AL_D_text <- clean_scrape(AL_D_text, "Alabama", "D") 


AL_R_text <- read_html("https://algop.org/algop-party-platform/") %>%
  html_nodes(xpath = '//*[(@id = "post-22654")]') %>%
  html_text()

AL_R_text <- clean_scrape(AL_R_text, "Alabama", "R")

## Alaska AK

AK_D_text <- pdf_text(pdf_subset('https://static1.squarespace.com/static/54bee0c9e4b0441ce96c4681/t/5ec2f771a3129705530a523c/1589835635394/2020+Democratic+Party+Platform.pdf', pages = 4:21))

AK_D_text <- clean_scrape(AK_D_text, "Alaska", "D")


AK_R_text <- read_html("http://alaskagop.net/about/platform/") %>%
  html_nodes(xpath = '//*[(@id = "main")]') %>%
  html_text() 

AK_R_text <- clean_scrape(AK_R_text, "Alaska", "R")


## Arizona (AZ) -- AZ Republican party follows Nat'l party platform

AZ_D_text <- pdf_text(pdf_subset('https://azdem.org/wp-content/uploads/2020/03/2020-ADP-Platform-1-1.pdf', pages = 2:8))

AZ_D_text <- clean_scrape(AZ_D_text, "Arizona", "D")


## Arkansas - AR

AR_D_text <- pdf_text(pdf_subset('https://www.arkdems.org/wp-content/uploads/2020/10/DPA-2020-Platform.pdf', pages = 2:16))

AR_D_text <- clean_scrape(AR_D_text, "Arkansas", "D")


AR_R_text <- pdf_text('https://www.arkansasgop.org/uploads/1/0/5/0/105070189/2020-2022_platform.pdf')

AR_R_text <- clean_scrape(AR_R_text, "Arkansas", "R")


## California - CA -- Dem platform only available in draft form

CA_D_text <- pdf_text(pdf_subset('https://www.cdpconvention.org/root/CDP-Platform-2020-Draft.pdf', pages = 5:34))

CA_D_text <- clean_scrape(CA_D_text, "California", "D")


CA_R_text <- pdf_text('https://www.saccountygop.com/wp-content/uploads/2019/09/F2019Platform.pdf')

CA_R_text <- clean_scrape(CA_R_text, "California", "R")


## Colorado - CO --- No Republican platform

CO_D_text <- pdf_text(pdf_subset('https://coloradodems.org/wp-content/uploads/2020/04/Colorado-Democratic-Party-2020-Platform.pdf', pages = 4:25))

CO_D_text <- clean_scrape(CO_D_text, "Colorado", "D")

## Connecticut - CT -- No Republican platform

CT_D_text <- read_html("https://ctdems.org/your-party/platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "content", " " ))]') %>%
  html_text() 

CT_D_text <- clean_scrape(CT_D_text, "Connecticut", "D")


## Delaware - DE --- No Republican platform

DE_D_text <- pdf_text("https://www.deldems.org/sites/default/files/2017%20Delaware%20Democratic%20State%20Party%20Platform.pdf") %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:10) { #remove header
  DE_D_text[[i]] <- DE_D_text[[i]][-1]
}

for(i in 1:10) { #remove footer
  a <- length(DE_D_text[[i]])
  b <- a-1
  DE_D_text[[i]] <- DE_D_text[[i]][-b:-a]
}

DE_D_text <- join_scrape(DE_D_text, "Delaware", "D")

## District of Columbia - DC --- No Dem platform

DC_R_text <- read_html("https://www.dcgop.com/projects") %>%
  html_nodes(xpath = '//*[(@id = "block-d21197035ca50356de32")]') %>%
  html_text() 

DC_R_text <- clean_scrape(DC_R_text, "DC", "R")


## Florida - FL --- No platforms


## Georgia - GA --- No Republican platform

GA_D_text <- pdf_text(pdf_subset("https://www.georgiademocrat.org/wp-content/uploads/2019/09/DPG-Platform-approved-Dec-2011.pdf", pages = 4:16))

GA_D_text <- clean_scrape(GA_D_text, "Georgia", "D")



## Hawaii - HI


HI_D_text <- pdf_text(pdf_subset("https://hawaiidemocrats.org/wp-content/uploads/2018/10/2018-State-Platform-1-6-13-18.pdf", pages = 4:25))  %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:22) { #remove footer
  a <- length(HI_D_text[[i]])
  b <- a-1
  HI_D_text[[i]] <- HI_D_text[[i]][-b:-a]
}

HI_D_text <- join_scrape(HI_D_text, "Hawaii", "D")



HI_R_text <- read_html("https://www.gophawaii.com/platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "et_pb_row_1", " " ))]') %>%
  html_text() 

HI_R_text <- clean_scrape(HI_R_text, "Hawaii", "R")



## Idaho - ID

ID_D_text <- read_html("https://idahodems.org/about/platform/") %>%
  html_nodes(xpath = '//strong | //p') %>%
  html_text() 

ID_D_text <- clean_scrape(ID_D_text, "Idaho", "D")


ID_R_text <- pdf_text("https://www.idgop.org/wp-content/uploads/2018/07/2018-Idaho-GOP-Platform-Updated.pdf")

ID_R_text <- clean_scrape(ID_R_text, "Idaho", "R")



## Illinois - IL --- No Democratic platform

IL_R_text <- pdf_text(pdf_subset("https://illinois.gop/wp-content/uploads/2017/07/2016PlatformoftheIllinoisRepublicanParty.pdf", pages = 3:11))

IL_R_text <- clean_scrape(IL_R_text, "Ilinois", "R")


## Indiana - IN

IN_D_text <- pdf_text(pdf_subset("https://www.indems.org/wp-content/uploads/2020/04/2020-IDP-Platform-JZ.ZKedits-.pdf", pages = 2-18))

IN_D_text <- clean_scrape(IN_D_text, "Indiana", "D")

IN_R_text <- pdf_text(pdf_subset("http://indiana.gop/sites/default/files/2018%20Platform%20Final.pdf", pages = 2:10))

IN_R_text <- clean_scrape(IN_R_text, "Indiana", "R")


## Iowa - IA --- Iowa Dems left out due to extreme complexity 

IA_R_text <- pdf_text("http://d3n8a8pro7vhmx.cloudfront.net/iowagop/legacy_url/142/2018-Approved-RPI-Platform-.pdf?1567709781")

IA_R_text <- clean_scrape(IA_R_text, "Iowa", "R")


## Kansas - KS

KS_D_text <- pdf_text(pdf_subset("https://live-kansasdems.pantheonsite.io/wp-content/uploads/2018/11/KDP-2017-Platform-with-Addendum.pdf", pages = 2:13)) %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:12) { #remove footer
  a <- length(KS_D_text[[i]])
  b <- a-1
  KS_D_text[[i]] <- KS_D_text[[i]][-b:-a]
}

KS_D_text <- join_scrape(KS_D_text, "Kansas", "D")


KS_R_text <- pdf_text("https://www.kansas.gop/wp-content/uploads/2019/10/2018-Platform.pdf")

KS_R_text <- clean_scrape(KS_R_text, "Kansas", "R")


## Kentucky - KY --- No platforms


## Louisiana - LA --- No platforms


## Maine - ME

ME_D_text <- pdf_text("https://www.mainedems.org/sites/default/files/documents/2020%20MDP%20Platform%20with%20amendments.PDF")

ME_D_text <- clean_scrape(ME_D_text, "Maine", "D")

ME_R_text <- read_html("https://mainegop.com/our-party-platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "elementor-element-7de2059", " " ))]') %>%
  html_text() 

ME_R_text <- clean_scrape(ME_R_text, "Maine", "R")


## Maryland - MD --- No party platforms


## Massachusetts - MA

MA_D_text <- pdf_text("https://massdems.org/wp-content/uploads/2018/01/2017-Platform-Massachusetts-Democratic-Party.pdf")

MA_D_text <- clean_scrape(MA_D_text, "Massachusetts", "D")

MA_R_text <- pdf_text("https://d3n8a8pro7vhmx.cloudfront.net/massgop/pages/1756/attachments/original/1523035066/2018_MRSC_Platform.pdf?1523035066") 

MA_R_text <- clean_scrape(MA_R_text, "Massachusetts", "R")

## Michigan - MI --- No Republican platform

MI_D_text <- pdf_text(pdf_subset("MI_D.pdf", pages = 3:33)) %>% #unable to download directly from site
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:31) { #remove footer
  a <- length(MI_D_text[[i]])
  b <- a-1
  MI_D_text[[i]] <- MI_D_text[[i]][-b:-a]
}

MI_D_text <- join_scrape(MI_D_text, "Michigan", "D")


## Minnesota - MN

MN_D_text <- pdf_text("https://www.dfl.org/wp-content/uploads/2018/09/DFL-Ongoing-Platform.pdf")

MN_D_text <- clean_scrape(MN_D_text, "Minnesota", "D")

MN_R_text <- pdf_text("https://mngop.com/wp-content/uploads/2020/05/2018-MNGOP-Standing-Platform-Approved-6-2-2018.pdf")

MN_R_text <- clean_scrape(MN_R_text, "Minnesota", "R")

## Mississippi - MS

MS_D_text <- read_html("https://www.mississippidemocrats.org/party-platform/") %>%
  html_nodes(xpath = '//p') %>%
  html_text()

MS_D_text <- clean_scrape(MS_D_text, "Mississippi", "D")


MS_R_text <- read_html("https://msgop.org/mississippi-republican-party-platform/") %>%
  html_nodes(xpath = '//*[(@id = "mainBar")]') %>%
  html_text() 

MS_R_text <- clean_scrape(MS_R_text, "Mississippi", "R")


## Missouri - MO

MO_D_text <- pdf_text(pdf_subset("https://missouridemocrats.org/wp-content/uploads/2018/08/MSDCPlatform8.11.18.pdf", pages = 2:16)) 

MO_D_text <- clean_scrape(MO_D_text, "Missouri", "D")


MO_R_text <- read_html("https://missouri.gop/about/platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "inner-panel-div", " " ))]//*[contains(concat( " ", @class, " " ), concat( " ", "post", " " ))]') %>%
  html_text() 

MO_R_text <- clean_scrape(MO_R_text, "Missouri", "R")



## Montana - MT

MT_D_text <- pdf_text("https://montanademocrats.org/wp-content/uploads/MDP-Platform-2020.pdf")

MT_D_text <- clean_scrape(MT_D_text, "Montana", "D")

MT_R_text <- pdf_text(pdf_subset("https://mtgop.org/wp-content/uploads/2019/03/Preamble-Platform-2018.pdf", pages = 2:14)) %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:13) { #remove header
  MT_R_text[[i]] <- MT_R_text[[i]][-1]
}

MT_R_text <- join_scrape(MT_R_text, "Montana", "R")

## Nebraska - NE

NE_D_text <- pdf_text(pdf_subset("https://nebraskademocrats.org/wp-content/uploads/2018/06/2018-2020-NDP-Platform-Final.pdf", pages = 3:19))%>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:17) { #remove header
  NE_D_text[[i]] <- NE_D_text[[i]][-1]
}

NE_D_text <- join_scrape(NE_D_text, "Nebraska", "D")


NE_R_text <- pdf_text("https://ada73298-ea18-41b5-9b03-86110151db2a.filesusr.com/ugd/163c2a_ad42aa9585c84ea6a92e9be924d26573.pdf") %>% 
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")


for(i in 1:8) { #remove header
  NE_R_text[[i]] <- NE_R_text[[i]][-1:-2]
}

for(i in 1:8) { #remove footer
  a <- length(NE_R_text[[i]])
  b <- a-2
  NE_R_text[[i]] <- NE_R_text[[i]][-b:-a]
}

NE_R_text <- join_scrape(NE_R_text, "Nebraska", "R")


## Nevada - NV

NV_D_text <- pdf_text('NV_D.pdf') #unable to download directly from site

NV_D_text <- clean_scrape(NV_D_text, "Nevada", "D")

NV_R_text <- pdf_text("https://nevadagop.org/wp-content/uploads/2020/09/2020-NRP-Adopted-Platform.pdf")

NV_R_text <- clean_scrape(NV_R_text, "Nevada", "R")



## New Hampshire - NH

NH_D_text <- read_html("https://www.nhdp.org/platform") %>%
  html_nodes(xpath = '//*[(@id = "comp-izyhl3k8")]//span') %>%
  html_text()

NH_D_text <- NH_D_text[-1:-9] #header junk

NH_D_text <- NH_D_text[-300:-324] #committee names

NH_D_text <- clean_scrape(NH_D_text, "New Hampshire", "D")


NH_R_text <- read_html("https://secure.nh.gop/platform") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "w-richtext", " " ))]') %>%
  html_text()

NH_R_text <- clean_scrape(NH_R_text, "New Hampshire", "R")


## New Jersey - NJ --- No platforms


## New Mexico - NM --- No Republican platform

NM_D_text <- pdf_text(pdf_subset("http://www.dpnm-sparc.org/uploads/4/6/9/0/4690685/democratic_party_of_new_mexico_platform_v3.pdf", pages = 3:26)) %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:24) { #remove footer
  a <- length(NM_D_text[[i]])
  b <- a-2
  NM_D_text[[i]] <- NM_D_text[[i]][-b:-a]
}

NM_D_text <- join_scrape(NM_D_text, "New Mexico","D")


## New York - NY --- No Platforms



## North Carolina - NC

NC_D_text <-  pdf_text("https://www.ncdp.org/wp-content/uploads/2020/09/2020-NCDP-Platform-1.pdf") %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:20) { #remove footer
  a <- length(NC_D_text[[i]])
  b <- a-1
  NC_D_text[[i]] <- NC_D_text[[i]][-b:-a]
}

NC_D_text[[1]] <- NC_D_text[[1]][-1:-18] # remove TOC

NC_D_text <- join_scrape(NC_D_text, "North Carolina", "D")


NC_R_text <- pdf_text(pdf_subset('https://d3n8a8pro7vhmx.cloudfront.net/ncgop/pages/4317/attachments/original/1597764911/NCGOP_Platform_2020_Final_Committee_Report.pdf?1597764911', pages = 4:12)) %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:9) { #remove footer
  a <- length(NC_R_text[[i]])
  b <- a-1
  NC_R_text[[i]] <- NC_R_text[[i]][-b:-a]
}

NC_R_text <- join_scrape(NC_R_text, "North Carolina", "R")


## North Dakota - ND

#every section is a different page for ND DemNPL.

ND_D_text <- read_html("https://demnpl.com/platform/") %>% ##preample: platform is spread on separate pages
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text()

ND_D_text <- clean_scrape(ND_D_text, "North Dakota", "D")

ND_D_text <- read_html("https://demnpl.com/platform/agriculture/") %>% ##preample: platform is spread on separate pages
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text()

ND_D_text <- clean_scrape(ND_D_text, "North Dakota", "D")

ND_D_biz <- read_html("https://demnpl.com/platform/business-labor-and-economic-development/") %>% #biz and labor
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_biz, "North Dakota", "D"))

ND_D_ed <- read_html("https://demnpl.com/platform/education/") %>% #education
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_ed, "North Dakota", "D"))

ND_D_gov <- read_html("https://demnpl.com/platform/effective-government/") %>% #government
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_gov, "North Dakota", "D"))

ND_D_energy <- read_html("https://demnpl.com/platform/energy-environment-and-natural-resources/") %>% #energy
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_energy, "North Dakota", "D"))

ND_D_for <- read_html("https://demnpl.com/platform/foreign-policy/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_for, "North Dakota", "D"))

ND_D_health <- read_html("https://demnpl.com/platform/health-and-human-services/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_health, "North Dakota", "D"))

ND_D_home <- read_html("https://demnpl.com/platform/housing-childcare-and-quality-of-life/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_home, "North Dakota", "D"))

ND_D_human <- read_html("https://demnpl.com/platform/human-rights/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_human, "North Dakota", "D"))

ND_D_infra <- read_html("https://demnpl.com/platform/infrastructure/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_infra, "North Dakota", "D"))

ND_D_safety <- read_html("https://demnpl.com/platform/public-safety/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_safety, "North Dakota", "D"))

ND_D_taxes <- read_html("https://demnpl.com/platform/public-safety/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "dem-content", " " ))]') %>%
  html_text() 

ND_D_text <- rbind(ND_D_text, clean_scrape(ND_D_taxes, "North Dakota", "D")) #thirteen webpages later, complete

ND_D_text <- join_scrape(ND_D_text, "North Dakota","D")

ND_R_text <- read_html("https://ndgop.org/platform/#1509721314727-a1a1905b-6ddb") %>%
  html_nodes(xpath = '//p') %>%
  html_text() 

ND_R_text <- ND_R_text[1:10] #platform adjacent to resolution/rules, isolating only platform content

ND_R_text <- clean_scrape(ND_R_text, "North Dakota", "R")



## Ohio - OH --- No platforms


## Oklahoma - OK

OK_D_text <- pdf_text(pdf_subset("https://okdemocrats.org/wp-content/uploads/2020/08/ODP-Platform-2019.pdf",pages = 6:26)) %>% 
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")


for(i in 1:21) { #remove header
  OK_D_text[[i]] <- OK_D_text[[i]][-1]
}

for(i in 1:21) { #remove footer
  a <- length(OK_D_text[[i]])
  b <- a-1
  OK_D_text[[i]] <- OK_D_text[[i]][-b:-a]
}

OK_D_text <- join_scrape(OK_D_text, "Oklahoma","D")


OK_R_text <- pdf_text(pdf_subset('https://static1.squarespace.com/static/5ceddd23e7a490000141538e/t/5d6035458989fe00015f7a72/1566586182314/2019_OKGOP_Platform.pdf', pages = 2:34))

OK_R_text <- clean_scrape(OK_R_text, "Oklahoma", "R")



## Oregon - OR

OR_D_text <- pdf_text("OR_D.pdf") %>% #pdf housed on Google Drive, manually downloaded
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:13) { #remove footer
  a <- length(OR_D_text[[i]])
  b <- a-1
  OR_D_text[[i]] <- OR_D_text[[i]][-b:-a]
}

OR_D_text <- join_scrape(OR_D_text, "Oregon","D")


OR_R_text <- pdf_text(pdf_subset("https://aa25e0d8-4b65-4802-b334-5ccc140f980a.filesusr.com/ugd/cf64a0_f38475c298454c92823a28f6c20e64d4.pdf", pages = 2:12)) %>% 
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")


for(i in 1:11) { #remove header
  OR_R_text[[i]] <- OR_R_text[[i]][-1:-2]
}

for(i in 1:11) { #remove footer
  a <- length(OR_R_text[[i]])
  b <- a-1
  OR_R_text[[i]] <- OR_R_text[[i]][-b:-a]
}

OR_R_text <- join_scrape(OR_R_text, "Oregon","R")


## Pennsylvania - PA --- No platforms


## Rhode Island - RI

RI_D_text <- pdf_text(pdf_subset("https://www.ridemocrats.org/wp-content/uploads/2019/02/Rhode-Island-Democratic-Party-Platform.pdf",pages = 3:11, output = "OR_R.pdf"))

RI_D_text <- clean_scrape(RI_D_text, "Rhode Island", "D")

RI_R_text <- read_html("http://www.ri.gop/platform") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "col-md-8", " " ))]') %>%
  html_text() 

RI_R_text <- clean_scrape(RI_R_text, "Rhode Island", "R")



## South Carolina - SC --- No Democratic Platform

SC_R_text <- pdf_text(pdf_subset("https://www.sc.gop/wp-content/uploads/2019/05/SCGOP-platform.pdf",pages = 2:17)) %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:16) { #remove footer
  a <- length(SC_R_text[[i]])
  b <- a-12
  SC_R_text[[i]] <- SC_R_text[[i]][-b:-a]
}

SC_R_text <- join_scrape(SC_R_text, "South Carolina", "R")



## South Dakota - SD

SD_D_text <- pdf_text("https://sddp.org/wp-content/uploads/2020/07/2020-SDDP-Platform.pdf") %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:12) { #remove header
  SD_D_text[[i]] <- SD_D_text[[i]][-1]
}

SD_D_text <- join_scrape(SD_D_text, "South Dakota", "D")


SD_R_text <- read_html("https://sdgop.com/about-the-party/our-platform/") %>%
  html_nodes(xpath = '//*[(@id = "post-81")]') %>%
  html_text()

SD_R_text <- clean_scrape(SD_R_text, "South Dakota", "R")



## Tennessee - TN --- No platforms


## Texas - TX

TX_D_text <- read_html("https://www.texasdemocrats.org/our-party/texas-democratic-party-platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "full-content", " " ))]//*[contains(concat( " ", @class, " " ), concat( " ", "row", " " ))]') %>%
  html_text() 

TX_D_text <- TX_D_text[-1] #remove header

TX_D_text <- clean_scrape(TX_D_text, "Texas", "D")


TX_R_text <- pdf_text(pdf_subset("TX_R.pdf", pages = 2:33))

TX_R_text <- clean_scrape(TX_R_text, "Texas", "R")



## Utah - UT

UT_D_text <- read_html("https://utahdemocrats.org/platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "medium-8", " " ))]') %>%
  html_text() 

UT_D_text <- clean_scrape(UT_D_text, "Utah", "D")

UT_R_text <- pdf_text("http://washingtoncountyrepublicanwomen.com/pdf/Utah-Republican-Party-Platform-2009-1.pdf")

UT_R_text <- clean_scrape(UT_R_text, "Utah", "R")



## Vermont - VT

VT_D_text <- read_html("https://www.vtdemocrats.org/platform") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "node", " " ))]') %>%
  html_text() 

VT_D_text <- VT_D_text[-1] #remove duplicated text

VT_D_text <- clean_scrape(VT_D_text, "Vermont", "D")

VT_R_text <- read_html("https://www.vtgop.org/platform") %>%
  html_nodes(xpath = '//*[(@id = "block-5bf428f80ebbe88939969ae4")]') %>%
  html_text() 

VT_R_text <- clean_scrape(VT_R_text, "Vermont", "R")



## Virginia - VA --- No platforms


## Washington - WA

WA_D_text <- pdf_text(pdf_subset("https://www.wa-democrats.org/wp-content/uploads/2020/06/WSDCC-2020-Final-Platform.pdf", pages= 2:51))

WA_D_text <- WA_D_text[-2] #remove TOC

WA_D_text <- clean_scrape(WA_D_text, "Washington", "D")


WA_R_text <- pdf_text(pdf_subset("https://wsrp.org/wp-content/uploads/2020/07/2020-Washington-Republican-Party-Platform.pdf", pages = 1:10)) %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:10) { #remove header
  WA_R_text[[i]] <- WA_R_text[[i]][-1]
}

WA_R_text[[1]] <- WA_R_text[[1]][-1:-6] # remove naming of chairs

WA_R_text <- join_scrape(WA_R_text, "Washington", "R")


## West Virginia - WV

WV_D_text <- pdf_text("https://wvdemocrats.com/wp-content/uploads/2019/10/West-Virginia-State-Democratic-2016-Party-Platform-.pdf")
  

WV_D_text <- clean_scrape(WV_D_text, "West Virginia", "D")


WV_R_text <- pdf_text("https://structurecms-staging-psyclone.netdna-ssl.com/client_assets/wvgop/media/attachments/5f7b/7dc1/2c1d/ac36/d90a/ea26/5f7b7dc12c1dac36d90aea26.pdf?1601928641") %>%
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n") 

for(i in 1:9) { #remove footer
  a <- length(WV_R_text[[i]])
  b <- a-1
  WV_R_text[[i]] <- WV_R_text[[i]][-b:-a]
}

WV_R_text[[9]] <- WV_R_text[[9]][-27:-38] # remove naming of chairs

WV_R_text <- join_scrape(WV_R_text, "West Virginia", "R")


## Wisconsin - WI

WI_D_text <- pdf_text("WI_D.pdf") %>% #blocked from scraping pdf
  str_replace_all("\\t|\\r|•"," ") %>% 
  tolower() %>%
  str_replace_all("[:punct:]"," ") %>%
  str_split("\n")

for(i in 1:6) { #remove footer
  a <- length(WI_D_text[[i]])
  b <- a-1
  WI_D_text[[i]] <- WI_D_text[[i]][-b:-a]
}

WI_D_text <- join_scrape(WI_D_text, "Wisconsin", "D")



WI_R_text <- read_html("https://wisgop.org/republican-party-of-wisconsin-platform/") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "entry-content", " " ))]') %>%
  html_text() 

WI_R_text <- clean_scrape(WI_R_text, "Wisconsin", "R")



## Wyoming - WY

WY_D_text <- read_html("https://www.wyodems.org/platform") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "title-wrapper", " " ))]') %>%
  html_text() 

WY_D_text <- clean_scrape(WY_D_text, "Wyoming", "D")

WY_R_text <- read_html("https://www.wyoming.gop/copy-of-bylaws") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "_2S9ms", " " ))]') %>%
  html_text() 

WY_R_text <- clean_scrape(WY_R_text, "Wyoming", "R")


## Just for fun, Trump 2020

Trump_text <- read_html("https://www.donaldjtrump.com/media/trump-campaign-announces-president-trumps-2nd-term-agenda-fighting-for-you") %>%
  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "body", " " ))]') %>%
  html_text() 

Trump_text <- clean_scrape(Trump_text, "Trump", "R")


## Done scraping, let's save into Rdata 

## Make a dataframe of all dem party platforms

D_text_raw <- rbind(AK_D_text, AL_D_text, AR_D_text, AZ_D_text, CA_D_text, 
                    CO_D_text, DE_D_text, GA_D_text, HI_D_text, ID_D_text, 
                    IN_D_text, KS_D_text, MA_D_text, ME_D_text, MI_D_text, 
                    MN_D_text, MO_D_text, MS_D_text, NC_D_text, ND_D_text, 
                    NE_D_text, NH_D_text, NM_D_text, NV_D_text, OK_D_text, 
                    OR_D_text, RI_D_text, SD_D_text, TX_D_text, UT_D_text, 
                    VT_D_text, WA_D_text, WI_D_text, WV_D_text, WY_D_text,
                    
                    Natl_D_text)

D_text_raw$text <- D_text_raw$text %>%
  removeNumbers() 

saveRDS(D_text_raw, "D_text_raw.rds")

## Make a dataframe of all rep party platforms

R_text_raw <- rbind(AK_R_text, AL_R_text, AR_R_text, CA_R_text, DC_R_text, 
                    HI_R_text, IA_R_text, ID_R_text, IL_R_text, IN_R_text, 
                    KS_R_text, MA_R_text, ME_R_text, MN_R_text, MO_R_text, 
                    MS_R_text, MT_R_text, NC_R_text, ND_R_text, NE_R_text, 
                    NH_R_text, NV_R_text, OK_R_text, OR_R_text, RI_R_text, 
                    SC_R_text, SD_R_text, TX_R_text, UT_R_text, VT_R_text, 
                    WA_R_text, WI_R_text, WV_R_text, WY_R_text,
                    
                    Natl_R_text)

R_text_raw$text <- R_text_raw$text %>%
  removeNumbers()

saveRDS(R_text_raw, "R_text_raw.rds")

## Republicans and Trump

trump_text_raw <- rbind(AK_R_text, AL_R_text, AR_R_text, CA_R_text, DC_R_text, 
                        HI_R_text, IA_R_text, ID_R_text, IL_R_text, IN_R_text, 
                        KS_R_text, MA_R_text, ME_R_text, MN_R_text, MO_R_text, 
                        MS_R_text, MT_R_text, NC_R_text, ND_R_text, NE_R_text, 
                        NH_R_text, NV_R_text, OK_R_text, OR_R_text, RI_R_text, 
                        SC_R_text, SD_R_text, TX_R_text, UT_R_text, VT_R_text, 
                        WA_R_text, WI_R_text, WV_R_text, WY_R_text,
                        
                        Natl_R_text, Trump_text)

trump_text_raw$text <- trump_text_raw$text %>%
  removeNumbers()

saveRDS(trump_text_raw, "trump_text_raw.rds")
  removeNumbers()