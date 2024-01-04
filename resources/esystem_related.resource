*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Login By eSystem
    [Arguments]    ${username}=${EMAIL}    ${password}=${PASSWD}
    Input Text    //*[@id="login"]    ${username}
    Input Password    //*[@id="password"]    ${password}
    Click Button    //*[@id="loginForm"]/p/button

Verify Polish Version Of eSystem Is Loaded If Not Switch To It
    ${title}    Get Element Attribute    //li[@class="quick-link-item"]/a    title
    IF    $title != 'Changes language to english.'
        Click Element    //html/body/div[1]/header/div/nav/div/ul[2]/li[1]/a/span[2]
    ELSE
        Log    Polish version is loaded
    END
