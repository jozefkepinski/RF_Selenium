*** Settings ***
Documentation    Verify if submitting just minutes is saved correctly
Library   SeleniumLibrary
Resource    ..\\Resources\\Keywords.resource

*** Variables ***
${access_token}

*** Test Cases ***
Enter hours as user and disable it approve it as administrator
    [Teardown]    Clear Hours In Daily View    ${week_number}
	Open Browser    ${unijobs_url}      ${browser}    options=add_argument("--disable-search-engine-choice-screen")
	Maximize Browser Window
    Login_dashboard    ${user_login}
    Navigate To The Timesheet
    Select Daily View
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    ${week_number}    ${entry_column}    ${returned_day}=    Open daily view and enter hour    ${access_token}    @{Assignments}
    Change User To Administrator
    Approve submitted entry    ${week_number}
    Change User To User
    Navigate To The Timesheet
    Check if entry was submitted is disabled    ${week_number}     ${entry_column}
    Check If Delete Button Is Not Visible
    Check Green Dot On Calendar    ${returned_day}
    Close Browser
