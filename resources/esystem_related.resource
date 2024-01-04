*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Login By eSystem
    [Arguments]    ${username}=${EMAIL}    ${password}=${PASSWD}
    Input Text    //*[@id="login"]    ${username}
    Input Password    //*[@id="password"]    ${password}
    Click Button    //*[@id="loginForm"]/p/button

Verify Polish Version Of eSystem is loaded if not switch to it
    ${status}    Run Keyword And Return Status    Element Should Contain
    ...    //html/body/div[1]/header/div/nav/div/ul[2]/li[1]/a/span[2]
    ...    English version
    IF    ${status} == True
        Click Element    //html/body/div[1]/header/div/nav/div/ul[2]/li[1]/a/span[2]
    ELSE
        Log    Polish version is loaded
    END
