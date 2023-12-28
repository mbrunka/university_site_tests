*** Settings ***
Library           SeleniumLibrary

Resource          ../resources/esystem_related.resource
Resource          ../resources/global.resource
Resource          ../resources/selenium_releted.resource

Variables    ../test_config/variables.py

*** Test Cases ***
Login to eKursy with invalid password
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Login By eSystem    ${EMAIL}    invalid_password
    Page Should Contain Any    Podano nieprawidłowe hasło.    Incorrect password provided.
    [Teardown]    Close Browser

Login to eKursy with valid password
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    5s
    Page Should Contain    Strona główna
    Get Current URL And Verify    https://ekursy.put.poznan.pl/
    [Teardown]    Close Browser

Verify Nav Bar
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    5s
    Click Element    //*[@id="nav-drawer"]/nav/ul/li[2]/a
    Get Current URL And Verify    https://ekursy.put.poznan.pl/my/
    Page Should Contain    PUT LMS eKursy: Kokpit
    Click Element    //*[@id="nav-drawer"]/nav/ul/li[3]/a
    Get Current URL And Verify    https://ekursy.put.poznan.pl/calendar/view.php?view=month
    Page Should Contain    Klucz wydarzeń
    Click Element    //*[@id="nav-drawer"]/nav/ul/li[4]/a
    Get Current URL And Verify    https://ekursy.put.poznan.pl/user/files.php
    Page Should Contain    Maksymalny rozmiar dla nowych plików:
    [Teardown]    Close Browser
