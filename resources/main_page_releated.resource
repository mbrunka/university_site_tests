*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/number.py

Resource    ../resources/global.resource

*** Keywords ***
Change Main Page Language
    [Arguments]    ${short_name}
    IF  $short_name == "EN"
        Click Element    //*[@id="block-przelacznikwersjijezykowej-2"]/ul/li[2]/a
    ELSE
        Click Element    link:${short_name}
    END
    Sleep    2s

Verify That Menu Is In Expected Language
    [Arguments]    @{main_menu}
    Element Should Contain Every    //*[@id="navbar-collapse"]/div    @{main_menu}