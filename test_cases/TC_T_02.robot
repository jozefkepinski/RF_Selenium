*** Settings ***
Documentation    Verify if time can't be submitted after active pay period
Library   SeleniumLibrary
Resource    ..\\Resources\\Keywords.resource


*** Variables ***
${access_token}


*** Test Cases ***
Check If Day In Future Pay Periods Is Disabled For Editing
	Open Browser    ${unijobs_url}      ${browser}    options=add_argument("--disable-search-engine-choice-screen")
	Maximize Browser Window
    Login_dashboard    ${user_login}
    Navigate To The Timesheet
    Select Daily View
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    Check If Day In Future Pay Periods Is Disabled For Editing    @{Assignments}
    Check No Active Assignments
    Close Browser
