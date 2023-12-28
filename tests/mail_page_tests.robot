*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/number.py

Resource    ../resources/global.resource
Resource    ../resources/mail_page_related.resource
Resource    ../resources/esystem_related.resource
Resource    ../resources/selenium_releted.resource

Variables    ../test_config/variables.py


*** Test Cases ***
Verify Loging to email account using wrong email address
    Open Browser    ${MAIL_URL}    ${BROWSER}
    Login To Mail    wrong_email@email.pl    wrong_password
    Sleep    2
    Page Should Contain Any    Nieznana nazwa użytkownika.    Unknown username.
    [Teardown]    Close Browser


Verify Loging to email account using wrong password
    Open Browser    ${MAIL_URL}    ${BROWSER}
    Login To Mail    ${EMAIL}    wrong_password
    Sleep    2
    Page Should Contain Any    Nieznana nazwa użytkownika lub złe hasło.    Unknown username or bad password.
    [Teardown]    Close Browser

Verify Loging to email account using normal method
    Open Browser    ${MAIL_URL}    ${BROWSER}
    Login To Mail    ${EMAIL}    ${PASSWD}
    Sleep    2
    Page Should Not Contain Any    Nieznana nazwa użytkownika    Unknown username
    Get Current URL And Verify    https://poczta.student.put.poznan.pl/zimbra/mail#1
    [Teardown]    Close Browser

Verify Loging to email account using eSystem
    Open Browser    ${MAIL_URL}    ${BROWSER}
    Click Element    //html/body/section/div[1]/form/div[3]/div/a
    Login By eSystem    ${EMAIL}    ${PASSWD}
    Sleep    10
    Page Should Not Contain Any    Nieznana nazwa użytkownika    Unknown username
    Get Current URL And Verify    https://poczta.student.put.poznan.pl/zimbra/mail#1
    [Teardown]    Close Browser

Verify logout works
    Open Browser    ${MAIL_URL}    ${BROWSER}
    Login To Mail    ${EMAIL}    ${PASSWD}
    Sleep    2
    Click Element    //*[@id="DWT27"]
    Sleep    1
    Click Element    //*[@id="logOff"]
    Sleep    2
    Get Current URL And Verify    https://elogin.put.poznan.pl/email/?logout
    Page Should Contain Textfield    //*[@id="user_name"]
    Page Should Contain Textfield    //*[@id="user_password"]
    [Teardown]    Close Browser

Sending and Reciving email
    [Tags]    intrusive
    Open Browser    ${MAIL_URL}    ${BROWSER}
    Login To Mail    ${EMAIL}    ${PASSWD}
    Sleep    2
    #Send email
    Press Keys    //*[@id="ztb__NEW_MENU"]    n+m
    Sleep    2
    Input Text    //*[@id="zv__COMPOSE-1_to_control"]    ${EMAIL}
    ${test_number}    Generate Random Number    4
    Input Text    //*[@id="zv__COMPOSE-1_subject_control"]    Test ${test_number}
    ${content}    Generate Random Number    12
    Input Text    //*[@id="ZmHtmlEditor1_body"]    ${content}
    Press Keys    //body    CONTROL+ENTER
    Sleep    2
    #Verify email is resived and it's content
    Wait Until Keyword Succeeds    60    10    Click Element    //*[contains(@aria-label, 'Test ${test_number}')]
    Element Should Contain    //html/body/    ${content}
    [Teardown]    Close Browser
