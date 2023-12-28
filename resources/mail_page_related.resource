*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/selenium_releted.resource

*** Keywords ***
Login To Mail
    [Arguments]    ${email_address}=${EMAIL}    ${password}=${PASSWD}
    Input Text    //*[@id="user_name"]    ${email_address}
    Input Password    //*[@id="user_password"]    ${password}
    Click Button    //html/body/section/div[1]/form/div[3]/input
