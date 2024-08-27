*** Settings ***
Documentation    Test Campaign for testing daily view functions
...
...              Tests from 01 to 04 are included.
Library   SeleniumLibrary
Resource    ..\\Resources\\Keywords.resource
Suite Setup    Open Browser    ${unijobs_url}      ${browser}    options=add_argument("--disable-search-engine-choice-screen");add_argument("--start-maximized")
Suite Teardown    Close Browser
Test Setup    Setup Browser
Test Teardown    Logging Off User


*** Variables ***
${access_token}

*** Test Cases ***
Enter hours for active assignment and check no active pay periods
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    Check day for active assignments pay period    @{Assignments}
    Check No active Pay Periods    @{Assignments}

Check If Day In Future Pay Periods Is Disabled For Editing
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    Check If Day In Future Pay Periods Is Disabled For Editing    @{Assignments}
    Check No Active Assignments

Hour type selection and input enter value is displayed and possible to modify from assignments pay period
    [Teardown]    Clear Hours In Daily View    ${week_number}[0]
    Navigate To The Timesheet
    Select Daily View
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    ${week_number}=    Open daily view and enter hour    ${access_token}    @{Assignments}