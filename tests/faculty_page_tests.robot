*** Settings ***
Documentation     Basic tests for www.cat.put.poznan.pl
Library           SeleniumLibrary
Library           Process
Library           OperatingSystem
Library           ../libraries/pdf_keywords.py

Resource    ../resources/global.resource
Resource    ../resources/main_page_releated.resource

Variables    ../test_config/variables.py
Variables    ../test_config/faculty_variables.py

*** Test Cases ***
Verify quick path to main webpage
    Open Browser      ${FACULTY_PAGE}    ${BROWSER}
    Verify Link Is Redicrecting To Correct Page And It Loads
    ...    //*[@id="navbar"]/div[1]/div/a/img
    ...    ${MAIN_PAGE_URL}
    [Teardown]    Close Browser

Verify semester schedule for current semester
    [Setup]    Create Directory    ${TEMP_FOLDER}
    Open Browser      ${ICT_STUDENT_PAGE}    ${BROWSER}
    IF    $CURRENT_SEMESTER == 'WINTER'
        ${schedule_locator}    Set Variable    ${WINTER_SEM_SCHEDULE_XPATH}
    ELSE IF    $CURRENT_SEMESTER == 'SUMMER'
        ${schedule_locator}    Set Variable    ${SUMMER_SEM_SCHEDULE_XPATH}
    ELSE
        FAIL    WRONG CURRENT_SEMESTER VALUE
    END
    ${schedule_url}    Get Element Attribute
        ...    ${schedule_locator}
        ...    href
    Log    ${schedule_url}
    Run Process    curl.exe    -o    ${TEMP_FOLDER}/week_schedule.pdf    ${schedule_url}
    Convert PDF To XML Format    ${TEMP_FOLDER}/week_schedule.pdf    ${TEMP_FOLDER}/week_schedule.xml
    ${xml}    Get File    ${TEMP_FOLDER}/week_schedule.xml
    ${current_year}    Get Current Year
    ${current_year_string}    Convert To String    ${current_year}
    IF    $CURRENT_SEMESTER == 'WINTER'
        Should Contain Every    ${xml}    ${current_year_string}    semestr zimowy
    ELSE
        Should Contain    ${xml}    ${current_year_string}    semestr letni
    END
    [Teardown]    Run Keywords    Close Browser    AND    Empty Directory    ${TEMP_FOLDER}

Verify week schedule for current semester
    Open Browser      ${ICT_STUDENT_PAGE}    ${BROWSER}
    FOR  ${class}  IN  @{WEEK_SCHEDULE_XPATH}[${CURRENT_SEMESTER}]
        ${schedule_url}    Get Element Attribute
        ...    ${WEEK_SCHEDULE_XPATH}[${CURRENT_SEMESTER}][${class}]
        ...    href
        Run Process    curl.exe    -o    ${TEMP_FOLDER}/${class}.pdf    ${schedule_url}
        Convert PDF To XML Format    ${TEMP_FOLDER}/${class}.pdf    ${TEMP_FOLDER}/${class}.xml
        ${xml}    Get File    ${TEMP_FOLDER}/${class}.xml
        Should Contain Every    ${xml}    TYGODNIOWY PLAN ZAJĘĆ    semestr ${class}
    END
    [Teardown]    Run Keywords    Close Browser    AND    Empty Directory    ${TEMP_FOLDER}

Verify week schedule for not current semester are not available
    Open Browser      ${ICT_STUDENT_PAGE}    ${BROWSER}
    IF    $CURRENT_SEMESTER == 'WINTER'
        ${not_current_semester}    Set Variable    SUMMER
    ELSE IF    $CURRENT_SEMESTER == 'SUMMER'
        ${not_current_semester}    Set Variable    WINTER
    ELSE
        FAIL    WRONG CURRENT_SEMESTER VALUE
    END
    FOR  ${class}  IN  @{WEEK_SCHEDULE_XPATH}[${not_current_semester}]
        ${schedule_url}    Get Element Attribute
        ...    ${WEEK_SCHEDULE_XPATH}[${not_current_semester}][${class}]
        ...    href
        Run Process    curl.exe    -o    ${TEMP_FOLDER}/${class}.pdf    ${schedule_url}
        Convert PDF To XML Format    ${TEMP_FOLDER}/${class}.pdf    ${TEMP_FOLDER}/${class}.xml
        ${xml}    Get File    ${TEMP_FOLDER}/${class}.xml
        Should Not Contain Any    ${xml}    TYGODNIOWY PLAN ZAJĘĆ    semestr ${class}
    END
    [Teardown]    Run Keywords    Close Browser    AND    Empty Directory    ${TEMP_FOLDER}