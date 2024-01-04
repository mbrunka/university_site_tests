*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Element Should Contain a tags with texts
    [Arguments]    ${locator}    @{texts}
    FOR    ${text}    IN    @{texts}
        Get WebElement    ${locator}/a[contains(text(),'${text}')]
    END
