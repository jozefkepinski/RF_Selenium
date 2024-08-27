*** Settings ***
Library    SeleniumLibrary
Variables    ..\\PageObjects\\Locators.py
Library    ..\\Library\\PythonLibrary.py
Library    DateTime
Library    String
Library    Collections
Library    RequestsLibrary
Library    BuiltIn
Library    JSONLibrary

*** Keywords ***
login_dashboard
    [Arguments]    ${login}
    Wait Until Element Is Visible    ${login_button}    2sec
    Element Should Contain    ${login_button}    Login
    Input Text    ${login_email_container}      ${login}
    Input Text    ${login_password_container}    ${password}
    Sleep    2
    Click Element    ${login_button}
    Sleep    2
    Element Should Be Visible    ${dashboard_tab}

Navigate to the timesheet
    Wait Until Element Is Visible    ${timesheet_tab}    2sec
    Click Element    ${timesheet_tab}

Select daily view
    Wait Until Element Is Visible    ${daily_view}    2sec
    Click Element    ${daily_view}


Open daily view and enter hour
    [Arguments]    ${access_token}    @{assignments_data}
    ${first_day_in_future_period}=    Get Current Date    result_format=${DATE_FORMAT}
    ${exit}    Set Variable    ${False}

    IF    @{assignments_data}
        # Take day after last pay period
        FOR    ${assignment_range}    IN    @{assignments_data}
            FOR    ${period}    IN    @{assignment_range}
                ${start_date}=    Get From List    ${period}    0
                ${start_date}=    Convert Date    ${start_date}    result_format=${DATE_FORMAT}
                ${end_date}=    Get From List    ${period}    1
                ${end_date}=    Convert Date    ${end_date}    result_format=${DATE_FORMAT}
                ${year}=    Get Substring    ${start_date}    0    4

                IF    ${year}==2024
                    ${date}    ${empty_assignment}=   Get date to enter hours without approved status    ${access_token}    ${start_date}    ${end_date}
                    IF    "${date}" != "${None}"
                        ${first_day_in_future_period}=    Set Variable    ${date}
                        ${exit}    Set Variable    ${True}
                        BREAK
                    ELSE
                        Log    No Empty Assignment in 2024 Going to next period!    WARN
                    END
                END
                Exit For Loop If    ${exit}
            END
            Exit For Loop If    ${exit}
        END
    ELSE
        Fail    "No Assignment in 2024!"    WARN
    END
    ${week_num}=    Get Week Number    ${first_day_in_future_period}
    Scroll down timesheet to the week    ${week_num}
    ${entry_column}    Get proper column number for time frame according to date    ${first_day_in_future_period}
    ${next_column}    Evaluate    ${entry_column} + 1
    IF    '${empty_assignment}' == '${True}'
        Setup empty assignment
        Sleep    3sec
        Input Text    css:ion-row:nth-child(2) ion-col:nth-child(${entry_column}) ion-item ion-input label div.native-wrapper.sc-ion-input-md.sc-ion-input-md-s input    "02:30"
        Input Text    css:ion-row:nth-child(2) ion-col:nth-child(${next_column}) ion-item ion-input label div.native-wrapper.sc-ion-input-md.sc-ion-input-md-s input    "00:30"
        Submit Assignment
    ELSE
        Log    Couldn't find empty assignment    WARN
    END
    RETURN    ${week_num}    ${entry_column}    ${first_day_in_future_period}

Get access Token
    ${url}    Set Variable    https://unijobs.umuksoftwareqa.co.uk/api/auth/login?password=${password}&username=${user_login}

    # Send a Post request to the current URL and store the response
    ${response}=    POST    ${url}

    # Convert the response content to a JSON object
    ${json_obj}=    Convert String To Json    ${response.content}
    ${access_token}    Set Variable    ${json_obj["accessToken"]}

    RETURN    ${access_token}

Get current periods
    [Arguments]    ${accessToken}
    ${headers}    Create Dictionary    Authorization=Bearer ${accessToken}
    @{assignments_data}    Create List

    # Send a GET request to the current URL and store the response
    ${response}=    GET    ${url}    headers=${headers}
    ${"json_response}    Convert String To Json   ${response.content}
    @{assignments}    Convert To List    ${"json_response}
    FOR    ${index}    ${assignment}    IN ENUMERATE    @{assignments}
        Append To List    ${assignments_data}    ${assignment["currentPeriods"]}
    END
    RETURN    ${assignments_data}

Get proper column number for time frame according to date
    [Arguments]    ${Date}
    ${days_of_week}    Create Dictionary    Mon=4  Tue=5    Wed=6    Thu=7    Fri=8    Sat=9    Sun=10
    ${Day}    Convert Date    ${Date}    result_format=%a
    RETURN   ${days_of_week}[${Day}]

Get date to enter hours without approved status
    [Arguments]    ${accessToken}    ${start_date}    ${end_date}
    ${url}    Set Variable    https://unijobs.umuksoftwareqa.co.uk/api/time?from=${start_date}&to=${end_date}&excludeNotSubmitted=false
    ${headers}    Create Dictionary    Authorization=Bearer ${accessToken}
    @{entry}    Create List

    # Send a GET request to the current URL and store the response
    ${response}=    GET    ${url}    headers=${headers}
    ${json_response}    Convert String To Json   ${response.content}
    IF    ${json_response} != []
        ${entry}    Convert To Dictionary   ${json_response}[0]
        FOR    ${each_entry}    IN    ${entry}
            IF    "${each_entry}" == "entries"
                ${dates}    Search Keys For Date Using Regex    ${entry}[entries]
                RETURN    ${dates}    ${False}
            END
        END
    ELSE
        RETURN    ${start_date}    ${True}
    END
    RETURN    None    None

Setup empty assignment
    #Wait Until Page Contains Element    ${job_name}    4sec
    #Wait For Condition	return document.readyState == "complete"    2sec
    Wait Until Element Contains    ${job_name_text}    Job name    2sec
    Log    Expand Job Name
    Click Element    ${job_name}
    Log    Select active Technical officer Job
    Sleep    2sec
    @{list_of_jobs}     Create List    ${technical_officer_week}    ${technical_officer_2_weeks}    ${technical_officer_month}    ${technical_officer_4_weeks}
    FOR    ${job}    IN    @{list_of_jobs}
        ${is_enabled}=    Run Keyword And Return Status    Element Should Be Focused    ${job}
        IF    ${is_enabled}
            Click Element    ${job}
            BREAK
        END
    END
    Log    Expand hour type
    Sleep    2sec
    Click Element    ${expand_hour_type}
    Sleep    2sec
    Log    Select standard hour type
    Click Element    ${standard_hour_type}

Submit assignment
    Wait Until Element Is Visible    ${submit_button}    2sec
    Log    Click submit button
    Click Element    ${submit_button}
    Wait Until Element Contains    ${confirm_button}    Confirm    4sec
    Log    Confirm submit
    Click Element    ${confirm_button}
    Log    Wait for Success popup
    Sleep    2sec
    Wait Until Page Contains Element    ${success_popup}    4sec

Change user to Administrator
    Log    Click Account Button
    Click Element    ${account_user_button}
    Wait Until Element Is Visible    ${logout_button}    2sec
    Log    Click Logout
    Click Element    ${logout_button}
    Sleep    3sec
    Wait Until Element Contains    ${login_button}    Login    2sec
    Input Text    ${login_email_container}      ${admin_login}
    Input Text    ${login_password_container}    ${password}
    Wait Until Element Is Visible    ${login_button}
    Click Element    ${login_button}
    Wait Until Element Is Visible    ${dashboard_tab}    2sec

Change user to User
    Log    Click Account Button
    Click Element    ${account_admin_button}
    Sleep    2sec
    Log    Click Logout
    Click Element    ${logout_button}
    Sleep    3sec
    Element Should Be Visible      ${login_button}
    Element Should Contain    ${login_button}    Login
    Input Text    ${login_email_container}      ${user_login}
    Input Text    ${login_password_container}    ${password}
    Sleep    2
    Click Element    ${login_button}
    Sleep    2
    Element Should Be Visible    ${dashboard_tab}

Logging off user
    Log    Click Account Button
    Click Element    ${account_user_button}
    Sleep    2sec
    Log    Click Logout
    Click Element    ${logout_button}

Approve submitted entry
    [Arguments]    ${week_num}
    Wait Until Element Is Visible    ${validation_tab}    2sec
    Click Element    ${validation_tab}
    Wait Until Page Contains Element    ${validation_tab_user_search}    4sec
    Input Text    ${validation_tab_user_search}    ${user_full_name}
    Sleep    2sec
    Click Element    ${select_the_first_user_found}
    Run Keyword And Ignore Error    Scroll Element Into View    //time[normalize-space()='${week_num}']
    Wait Until Element Is Visible    //time[normalize-space()='${week_num}']    2sec
    Click Element    //time[normalize-space()='${week_num}']
    Wait Until Element Contains    ${accept_all_button}    Accept all    2sec
    Click Element    ${accept_all_button}
    Wait Until Element Is Visible    ${confirm_button}    2sec
    Click Element    ${confirm_button}

Reject submitted entry
    [Arguments]    ${week_num}
    Wait Until Element Is Visible   ${validation_tab}    2sec 
    Click Element    ${validation_tab}
    Wait Until Element Is Visible    ${validation_tab_user_search}    3sec
    Input Text    ${validation_tab_user_search}    ${user_full_name}
    Sleep    2sec
    Click Element    ${select_the_first_user_found}
    Sleep    2sec
    Run Keyword And Ignore Error    Scroll Element Into View    //time[normalize-space()='${week_num}']
    Wait Until Element Is Visible    //time[normalize-space()='${week_num}']    2sec
    Click Element    //time[normalize-space()='${week_num}']
    Wait Until Element Is Visible    ${reject_all_button}    2sec
    Click Element    ${reject_all_button}
    Wait Until Element Is Visible    ${confirm_button}    2sec
    Click Element    ${confirm_button}

Check No active Pay Periods
    [Arguments]    @{assignments_data}

    ${non_assignment_date}=    Get Current Date    result_format=${DATE_FORMAT}
    ${start_date}    Set Variable    2024-01-01
    ${end_date}    Set Variable    2024-12-30

    IF    @{assignments_data}
        # Take first date from 2024 assignment
        FOR    ${assignment_range}    IN    @{assignments_data}
            FOR    ${period}    IN    @{assignment_range}
                ${start_date}=    Get From List    ${period}    0
                ${start_date}=    Convert Date    ${start_date}    result_format=${DATE_FORMAT}
                ${end_date}=    Get From List    ${period}    1
                ${end_date}=    Convert Date    ${end_date}    result_format=${DATE_FORMAT}
                ${year}=    Get Substring    ${start_date}    0    4
                    IF    not("${non_assignment_date}" < "${start_date}" or "${non_assignment_date}" > "${end_date}")
                        ${non_assignment_date}=    Add Time To Date    ${non_assignment_date}    +20 days    result_format=${DATE_FORMAT}
                    END
            END
        END
    ELSE
        Fail    "No Assignment!"
    END

    # Split the date into year, month, and day
    ${year}=    Get Substring    ${non_assignment_date}    0    4
    ${month}=    Get Substring    ${non_assignment_date}    5    7
    ${day}=    Get Substring    ${non_assignment_date}    8    10
#
#    # Set day from last period
    ${day_from_last_period}    Set Variable    css=.datepicker-${year}-${month}-${day}

    ${week_num}=    Get Week Number    ${non_assignment_date}
    Run Keyword And Ignore Error    Scroll Element Into View    //time[normalize-space()='${week_num}']
#    # Locate and click the element that matches the date on the calendar
    #Double Click Element    ${day_from_last_period}
    Wait Until Element Is Visible    ${day_from_last_period}    2sec
    Click Element    ${day_from_last_period}
    Click Element    ${day_from_last_period}
#   "No active Pay Periods." was displayed.
    Wait Until Element Is Visible    ${no_active_assignments_for_day}    5sec
    Element Text Should Be    ${no_active_assignments_for_day}    You have no active assignments.

Check day for active assignments pay period
    [Arguments]    @{assignments_data}

    IF    @{assignments_data}
        # Take first date from 2024 assignment
        FOR    ${assignment_range}    IN    @{assignments_data}
            FOR    ${period}    IN    @{assignment_range}
                ${start_date}=    Get From List    ${period}    0
                ${year}=    Get Substring    ${start_date}    0    4
                IF    ${year}==2024
                    BREAK
                END
            END
            IF    ${year}==2024    #If not go to another assignment
                BREAK
            END
        END
    ELSE
        Fail    No Assignment in ${year}!
    END

#    # Split the date into year, month, and day
    ${year}=    Get Substring    ${start_date}    0    4
    ${month}=    Get Substring    ${start_date}    5    7
    ${day}=    Get Substring    ${start_date}    8    10

    # Set day from last period
     ${day_from_last_period}    Set Variable    css=.datepicker-${year}-${month}-${day}
    # Locate and click the element that matches the date on the calendar
    #Double Click Element    ${day_from_last_period}
    ${week_num}=    Get Week Number    ${start_date}
    Run Keyword And Ignore Error    Scroll Element Into View    //time[normalize-space()='${week_num}']
    Wait Until Element Is Visible    ${day_from_last_period}    2sec
    # problem with double Click
    Click Element    ${day_from_last_period}
    Click Element    ${day_from_last_period}
    Wait Until Element Is Visible    css=div[class='hour-code-select']    2sec
    # Hour type selection and input enter value is displayed and possible to modify
    Element Should Be Enabled    css=div[class='hour-code-select']

Check if day in future Pay Periods is disabled for editing
    [Arguments]    @{assignments_data}

    ${last_day_in_future_period}=    Get Current Date    result_format=${DATE_FORMAT}

    IF    @{assignments_data}
        # Take day after last pay period
        FOR    ${assignment_range}    IN    @{assignments_data}
            FOR    ${period}    IN    @{assignment_range}
                ${period_end_date}=    Get From List    ${period}    1
                ${period_end_date}=    Convert Date    ${period_end_date}    result_format=${DATE_FORMAT}
                    IF    "${last_day_in_future_period}" < "${period_end_date}"
                        ${last_day_in_future_period}=    Set Variable    ${period_end_date}
                    END
            END
        END
    ELSE
        Fail    "No Assignment!"
    END
    ${next_period}    Add Time To Date    ${last_day_in_future_period}    +30 days    result_format=${DATE_FORMAT}
    ${week_num}=    Get Week Number    ${next_period}
    Wait Until Element Is Visible    //time[normalize-space()='${week_num}']    2sec
    Click Element    //time[normalize-space()='${week_num}']
    #${column}    Get proper column number for time frame according to date    ${next_day}

Check no active assignments
    Wait Until Element Is Visible    ${no_active_assignments}    2sec
    Element Text Should Be    ${no_active_assignments}    You have no active assignments.
    
Scroll down timesheet to the week
    [Arguments]     ${week_num}
    TRY
        ${success}=    Run Keyword And Ignore Error   Scroll Element Into View    //time[normalize-space()='${week_num}']
        Run Keyword If    ${success}== "Element with locator \'//time[normalize-space()=\'${week_num}\']\' not found."    Scroll Element Into View    //time[normalize-space()='${week_num}']
        Wait Until Element Is Visible    //time[normalize-space()='${week_num}']    3sec
        Click Element    //time[normalize-space()='${week_num}']
    EXCEPT    Element with Week locator not found
        Fail    Element with Week locator not found
    END
    
Check if entry was submitted is disabled
    [Arguments]    ${week_num}    ${entry_column}
    Scroll Down Timesheet To The Week    ${week_num}
    Sleep    2sec
    Element Should Be Disabled    css:ion-row:nth-child(2) ion-col:nth-child(${entry_column}) ion-item ion-input label div.native-wrapper.sc-ion-input-md.sc-ion-input-md-s input

Check if entry was submitted is enabled
    [Arguments]    ${week_num}    ${entry_column}
    Scroll Down Timesheet To The Week    ${week_num}
    Sleep    2sec
    Element Should Be Enabled    css:ion-row:nth-child(2) ion-col:nth-child(${entry_column}) ion-item ion-input label div.native-wrapper.sc-ion-input-md.sc-ion-input-md-s input

Check if delete button is not visible
    Sleep    2sec
    Element Should Not Be Visible    ${timesheet_delete_button}

Check if delete button is visible and delete submitted entry
    Sleep    2sec
    Page Should Contain Element    ${timesheet_delete_button}
    Click Element    ${timesheet_delete_button}
    Submit assignment
    
Check green dot on calendar
    [Arguments]    ${day_to_check}
    ${date}=  Convert Date  ${day_to_check}  result_format=%A, %B %d, %Y
    Element Should Be Visible    //time[@aria-label='${date}']//span[@class='month__dot month__dot--accepted'][contains(text(),'•')]

Clear hours in daily view
    [Arguments]    ${week_number}
    Open Browser    ${unijobs_url}      headless${browser}    options=add_argument("--disable-search-engine-choice-screen")
    Maximize Browser Window
    Login_dashboard    ${admin_login}
    Reject Submitted Entry    ${week_number}
    Change User To User
    Navigate To The Timesheet
    Scroll Down Timesheet To The Week    ${week_number}
    Check If Delete Button Is Visible And Delete Submitted Entry
    Close Browser

Setup Browser
	Login_dashboard    ${user_login}
    Navigate To The Timesheet
    Select Daily View
    