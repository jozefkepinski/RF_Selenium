*** Settings ***
Documentation    Verify if time can't be submitted before active pay period
Library   SeleniumLibrary
Resource    ..\\Resources\\Keywords.resource

*** Variables ***
${access_token}

*** Test Cases ***
Enter hours for active assignment and check no active pay periods
	Open Browser    ${unijobs_url}      ${browser}    options=add_argument("--disable-search-engine-choice-screen")
	Maximize Browser Window
    Login_dashboard    ${user_login}
    Navigate To The Timesheet
    Select Daily View
    ${access_token}=    Get access Token
    ${Assignments}=    Get Current Periods    ${access_token}
    Check day for active assignments pay period    @{Assignments}
    Check No active Pay Periods    @{Assignments}
    Close Browser
