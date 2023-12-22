*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Should Contain Every
    [Arguments]    ${container}    @{items}
    FOR  ${item}  IN  @{items}
        Should Contain    ${container}    ${item}
    END

Element Should Contain Every
    [Arguments]    ${element}    @{strings}
    FOR  ${string}  IN  @{strings}
        Element Should Contain    ${element}    ${string}
    END

Refresh Page Until Page Contains Element
    [Arguments]    ${locator}    ${retrys}=20    ${interval}=2
    ${Reload}    Run Keyword And Return Status
        ...    Page Should Contain Element  ${locator}
    WHILE    $Reload != $TRUE    limit=${interval}
        Reload Page
        Sleep    ${retrys}
        ${Reload}    Run Keyword And Return Status
        ...    Page Should Contain Element  ${locator}
    END

Refresh Page Until Element Is Clickable
    [Arguments]    ${locator}    ${retrys}=20    ${interval}=2
    ${Reload}    Run Keyword And Return Status
        ...    Page Should Contain Element  ${locator}
    WHILE    $Reload != $TRUE    limit=${interval}
        Reload Page
        Sleep    ${retrys}
        ${Reload}    Run Keyword And Return Status
        ...    Page Should Contain Element  ${locator}
    END

Verify Link Is Redicrecting To Correct Page And It Loads
    [Arguments]    ${link_locator}    ${expected_url}
    Click Element    ${link_locator}
    Sleep    2s
    ${current_url}    Get Location
    IF    $current_url == $expected_url
        Log    Manual verification needed, page could redicrect to login page!    console=${True}
    END
    ${is_page_loaded}=    Execute Javascript    return document.readyState === 'complete'
    Should Be True    ${is_page_loaded}    The page did not load completely
    Go Back

Get Current URL And Verify
    [Arguments]    ${expected_url}
    ${current_url}    Get Location
    Should Be Equal    ${current_url}    ${expected_url}