*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Element Should Contain Every
    [Arguments]    ${element}    @{strings}
    FOR  ${string}  IN  @{strings}
        Element Should Contain    ${element}    ${string}
    END