*** Keywords ***
Should Contain Every
    [Arguments]    ${container}    @{items}
    FOR  ${item}  IN  @{items}
        Should Contain    ${container}    ${item}
    END
