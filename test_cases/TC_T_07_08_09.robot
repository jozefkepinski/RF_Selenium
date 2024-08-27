*** Settings ***
Documentation    Verify if rejected entry has red input background and has red dot on the calendar
Library   SeleniumLibrary
Resource    ..\\Resources\\Keywords.resource

*** Variables ***
${access_token}

*** Test Cases ***
Enter hours as user and disable it reject it as administrator
	Open Browser    ${unijobs_url}      ${browser}    options=add_argument("--disable-search-engine-choice-screen")
	Maximize Browser Window
    Login_dashboard    ${user_login}
    Navigate To The Timesheet
    Select Daily View
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    ${week_number}    ${entry_column}    ${returned_day}=    Open daily view and enter hour    ${access_token}    @{Assignments}
    Change User To Administrator
    Reject Submitted Entry    ${week_number}
    Change User To User
    Navigate To The Timesheet
    Check If Entry Was Submitted Is Enabled    ${week_number}     ${entry_column}
    Check If Delete Button Is Visible And Delete Submitted Entry
    Close Browser