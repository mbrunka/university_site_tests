*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/number.py

Resource    ../resources/global.resource
Resource    ../resources/main_page_releated.resource

Variables    ../test_config/variables.py
Variables    ../test_config/dict.py


*** Test Cases ***
Verify language menu change
    Open Browser    ${MAIN_PAGE_URL}    ${BROWSER}
    FOR  ${lang}  IN  @{LANGUAGE_DICT}
        Change Main Page Language    ${LANGUAGE_DICT}[${lang}][short_name]
        Verify That Menu Is In Expected Language    @{LANGUAGE_DICT}[${lang}][main_menu]
    END
    [Teardown]    Close Browser

Verify social media links
    Open Browser    ${MAIN_PAGE_URL}    ${BROWSER}
    #Facebook
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[1]/div/div/div/div/a
    ...    https://www.facebook.com/Politechnika.Poznanska
    #Instagram
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[2]/div/div/div/a
    ...    https://www.instagram.com/politechnika.poznanska/
    #Youtube
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[3]/div/div/div/a
    ...    https://www.youtube.com/channel/UC9jAyy-X65QOVZpyGu9AKHw
    #Twitter
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[5]/div/div/div/a
    ...    https://twitter.com/PUT_Poznan
    #Linkedin
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[4]/div/div/div/a\
    ...    https://pl.linkedin.com/company/poznan-university-of-technology
    #Radio
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[6]/div/div/div/a
    ...    https://www.afera.com.pl/
    #Podcast
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //html/body/div[1]/div/div[1]/section/div/div[7]/div/section[1]/div[7]/div/div/div/div/a
    ...    https://www.youtube.com/@polipodkast
    [Teardown]    Close Browser

Verify basic search function
    Open Browser    ${MAIN_PAGE_URL}    ${BROWSER}
    Input Text    //*[@id="edit-keys"]    brandshop
    Click Element    //*[@id="search-block-form"]/div[1]/div/span/button
    Sleep    2s
    Page Should Not Contain    Brak wyników spełniających kryteria twojego wyszukiwania
    Get Current URL And Verify    https://www.put.poznan.pl/search/node?keys=brandshop
    [Teardown]    Close Browser

Verify path to faculty page
    Open Browser    ${MAIN_PAGE_URL}    ${BROWSER}
    Click Element    //*[@id="block-mainnavigationpl-2"]/ul/li[1]/a
    Click Element    //*[@id="block-mainnavigationpl-2"]/ul/li[1]/ul/li[5]/ul/li[1]/a
    Click Element    //html/body/div[1]/div/div[1]/section/div/article/div/div/div[2]/section[2]/div/div[3]/div/div/a
    [Teardown]    Close Browser

Verify path to eKursy
    Open Browser    ${MAIN_PAGE_URL}    ${BROWSER}
    Click Element    //*[@id="block-mainnavigationpl-2"]/ul/li[5]/a
    Click Element    //*[@id="block-mainnavigationpl-2"]/ul/li[5]/ul/li[2]/ul/li[4]/a
    Click Element    //*[@id="uc_subtle_overlay_content_box_elementor_8602fd2"]
    Click Element    //*[@id="post-543"]/div/section[2]/div/div[4]/div/div/div/div/a
    Page Should Contain    Click the image below to log in.
    [Teardown]    Close Browser

Verify that all links on main page are working
    [Tags]    long
    Open Browser      ${FACULTY_PAGE}    ${BROWSER}
    Verify All Links On Current Webpage Are Working
    [Teardown]    Close Browser
