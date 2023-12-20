*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/number.py

Resource    ../resources/global.resource

Variables    ../test_config/variables.py


*** Test Cases ***
Verify Loging to email account
    Open Browser    ${MAIL_URL}    ${BROWSER}
    #Loging to email
    Input Text    //*[@id="user_name"]    ${EMAIL}
    Input Password    //*[@id="user_password"]    ${PASSWD}
    Click Button    Zaloguj
    Sleep    2
    Page Should Not Contain    Nieznana nazwa użytkownika
    [Teardown]    Close Browser

Sending and Reciving email
    Open Browser    ${MAIL_URL}    ${BROWSER}
    #Loging to email
    Input Text    //*[@id="user_name"]    ${EMAIL}
    Input Password    //*[@id="user_password"]    ${PASSWD}
    Click Button    Zaloguj
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
    Wait Until Keyword Succeeds    20    10    Click Element    Test ${test_number}
    Element Should Contain    /html/body/div/div    ${content}
    [Teardown]    Close Browser
    
    
    