*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Login By eSystem
    [Arguments]    ${username}=${EMAIL}    ${password}=${PASSWD}
    Input Text    //*[@id="login"]    ${username}
    Input Password    //*[@id="password"]    ${password}
    Click Button    //*[@id="loginForm"]/p/button
