*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/number.py

Resource    ../resources/global.resource

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
    ${current_url}    Get Location
    Should Be Equal    ${current_url}    https://www.put.poznan.pl/search/node?keys=brandshop
    [Teardown]    Close Browser


*** Keywords ***
Change Main Page Language
    [Arguments]    ${short_name}
    IF  $short_name == "EN"
        Click Element    //*[@id="block-przelacznikwersjijezykowej-2"]/ul/li[2]/a
    ELSE
        Click Element    link:${short_name}
    END
    Sleep    2s    

Verify That Menu Is In Expected Language
    [Arguments]    @{main_menu}
    Element Should Contain Every    //*[@id="navbar-collapse"]/div    @{main_menu}

Verify Link Is Redicrecting To Correct Page And It Loads
    [Arguments]    ${link}    ${expected_url}
    Click Element    ${link}
    Sleep    2s
    ${current_url}    Get Location
    IF    $current_url == $expected_url
        Log    Manual verification needed, page could redicrect to login page!    console=${True}
    END
    ${is_page_loaded}=    Execute Javascript    return document.readyState === 'complete'
    Should Be True    ${is_page_loaded}    The page did not load completely
    Go Back
    