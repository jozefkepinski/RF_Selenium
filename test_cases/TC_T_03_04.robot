*** Settings ***
Documentation    Verify if submitting just an hour (without minutes) is saved correctly
...              Verify if submitting just an hour with minutes is saved correctly
Library   SeleniumLibrary
Resource    ..\\Resources\\Keywords.resource


*** Variables ***
${access_token}


*** Test Cases ***
Hour type selection and input enter value is displayed and possible to modify from assignments pay period
    [Teardown]    Clear Hours In Daily View    ${week_number}[0]
	Open Browser    ${unijobs_url}      ${browser}    options=add_argument("--disable-search-engine-choice-screen")
	Maximize Browser Window
    Login_dashboard    ${user_login}
    Navigate To The Timesheet
    Select Daily View
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    ${week_number}=    Open daily view and enter hour    ${access_token}    @{Assignments}
    Close Browser
