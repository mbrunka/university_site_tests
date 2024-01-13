*** Settings ***
Library           SeleniumLibrary
Library           Process
Library           OperatingSystem

Library           ../libraries/number.py
Library           ../libraries/pdf_keywords.py

Resource          ../resources/esystem_related.resource
Resource          ../resources/global.resource
Resource          ../resources/selenium_releted.resource
Resource          ../resources/ekursy_releated.resource

Variables    ../test_config/variables.py
Variables    ../test_config/dict.py


*** Test Cases ***
Login to eKrusy with invalid email
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    invalid@email.pl    ${PASSWD}
    Page Should Contain    Nie znaleziono konta o podanej nazwie.
    [Teardown]    Close Browser

Login to eKursy with invalid password
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    invalid_password
    Page Should Contain    Podano nieprawidłowe hasło.
    [Teardown]    Close Browser

Login to eKursy with valid password
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    5s
    Page Should Contain    Strona główna
    Get Current URL And Verify    https://ekursy.put.poznan.pl/
    #[Teardown]    Close Browser

Verify Nav Bar
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
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

Verify messenging fuction by sending message to favorite user
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    2s
    Click Element    //*[contains(@id,'message-drawer-toggle-')]
    Sleep    2s
    Click Element    //div[contains(@id,'view-overview-favourites-target-')]/div[2]/a[1]
    Sleep    2s
    ${test_number}    Generate Random Number    10
    Input Text    //textarea[@data-region='send-message-txt']    Test ${test_number}
    Click Element    //button[@aria-label='Wyślij wiadomość']
    Sleep    5s
    Element Should Contain    //div[@data-region='content-message-container']    Test ${test_number}
    [Teardown]    Close Browser

Verify messenging fuction by searching user
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    2s
    Click Element    //*[contains(@id,'message-drawer-toggle-')]
    Sleep    2s
    Input Text    //input[@aria-label='Szukaj']    ${USER_FULL_NAME}
    Click Element    //button[@aria-label='Szukaj']
    Sleep    2s
    Click Element   //a[@data-route='view-conversation']
    ${test_number}    Generate Random Number    10
    Sleep    2s
    Input Text    //textarea[@data-region='send-message-txt']    Test ${test_number}
    Click Element    //button[@aria-label='Wyślij wiadomość']
    Sleep    5s
    Element Should Contain    //div[@data-region='content-message-container']    Test ${test_number}
    [Teardown]    Close Browser

Clear alarms and verify
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    2s
    Click Element    //div[@aria-label='Wyświetl okno bez nowych powiadomień']
    Sleep    2s
    Click Element    //a[@title='Oznacz wszystko jako przeczytane']
    Sleep    2s
    Element Should Contain    //div[@class='popover-region-content-container']    Nie masz powiadomień
    [Teardown]    Close Browser

Verify seveth semester student course list
    [Tags]    SEMESTER_7_TELEINF
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    2s
    Click Element    //li[@class='dropdown nav-item']/a[contains(text(), 'Moje kursy')]
    Element Should Contain a tags with texts
    ...    //div[contains(@id, 'drop-down-menu-')]
    ...    @{sem7_teleinf_student_courses}

Verify pdf download from Cybersecurity course
    [Tags]    SEMESTER_7_TELEINF
    Open Browser    ${EKURSY_URL}    ${BROWSER}
    Click Element    //*[@id="region-main"]/div[2]/div[2]/div/div[1]/div[2]/div/a
    Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    2s
    Click Element    //li[@class='dropdown nav-item']/a[contains(text(), 'Moje kursy')]
    Click Element    //div[contains(@id, 'drop-down-menu-')]/a[contains(text(), 'Cyberbezpieczeństwo')]
    Click Element    //a[@href='https://ekursy.put.poznan.pl/mod/resource/view.php?id=1969586']
    Sleep    2s
    Page Should Contain    Cyberbezpieczeństwo
    [Teardown]    Run Keywords    Close Browser
