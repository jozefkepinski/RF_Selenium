# Login Page Elements
browser = "chrome"
unijobs_url = "https://this_could_be_your_site/"
user_login = "user_login@asdf.com"
user_full_name = "John Test"
admin_login = "admin_login"
password = "admin_pswrd"
DATE_FORMAT = "%Y-%m-%d"

login_button = "class:buttons-container"
login_email_container = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-login > ion-content > unijobs-auth-box > ion-content > div > div > div > form > div > ion-item > ion-input > label > div > input')"
login_password_container = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-login > ion-content > unijobs-auth-box > ion-content > div > div > div > form > div > ion-item:nth-child(4) > ion-input > label > div > input')"
dashboard_tab = "class:image-container"
timesheet_tab = "xpath=//a[normalize-space()='Timesheets']"
daily_view = "xpath=//ion-segment-button[@value='day']"

validation_tab = "xpath://a[normalize-space()='Validation']"
validation_tab_user_search = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-subordinates-page > unijobs-subordinates > div > div > ion-card > unijobs-subordinates-list > div > ion-searchbar > div > input')"
select_the_first_user_found = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-subordinates-page > unijobs-subordinates > div > div > ion-card > unijobs-subordinates-list > div > div > unijobs-user-scroll > ion-content > div')"
account_user_button = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-header > unijobs-top-menu-bar > ion-toolbar > ion-buttons').querySelector('ion-button:nth-child(3)')"
account_admin_button = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-header > unijobs-top-menu-bar > ion-toolbar > ion-buttons')"
logout_button = "dom:document.querySelector('body > unijobs-root > ion-app > ion-popover > div > ion-content > div > a:nth-child(4)')"

# Timesheet page
job_name_text = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-working-hours > div > div > div > ion-card > div.form-card-padding.card__content > unijobs-submit-week > div > div > form > ion-grid > ion-row:nth-child(1) > ion-col:nth-child(1)')"
job_name = "dom:document.querySelector('.item-full-width.ng-untouched.ng-pristine.ng-valid.md.in-item.ion-focusable.select-ltr.select-justify-space-between.select-label-placement-start.hydrated.ion-untouched.ion-pristine.ion-valid').shadowRoot.querySelector('.select-icon.md.hydrated').shadowRoot.querySelector('svg')"
technical_officer_week = 'dom:document.querySelector("body > unijobs-root:nth-child(1) > ion-app:nth-child(1) > ion-popover:nth-child(2) > ion-select-popover:nth-child(1) > ion-list:nth-child(1) > ion-radio-group:nth-child(1) > ion-item:nth-child(1) > ion-radio:nth-child(1)")'
technical_officer_2_weeks = 'dom:document.querySelector("body > unijobs-root:nth-child(1) > ion-app:nth-child(1) > ion-popover:nth-child(2) > ion-select-popover:nth-child(1) > ion-list:nth-child(1) > ion-radio-group:nth-child(1) > ion-item:nth-child(2) > ion-radio:nth-child(1)")'
technical_officer_month = 'dom:document.querySelector("body > unijobs-root:nth-child(1) > ion-app:nth-child(1) > ion-popover:nth-child(2) > ion-select-popover:nth-child(1) > ion-list:nth-child(1) > ion-radio-group:nth-child(1) > ion-item:nth-child(3) > ion-radio:nth-child(1)")'
technical_officer_4_weeks = 'dom:document.querySelector("body > unijobs-root:nth-child(1) > ion-app:nth-child(1) > ion-popover:nth-child(2) > ion-select-popover:nth-child(1) > ion-list:nth-child(1) > ion-radio-group:nth-child(1) > ion-item:nth-child(4) > ion-radio:nth-child(1)")'
expand_hour_type = """dom:document.querySelector("ion-icon[role='img'][class='hour-code-select__icon md hydrated']")"""
standard_hour_type = "xpath://div[normalize-space()='Standard hours']"
submit_button = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-working-hours > div > div > div').querySelector('ion-card > div > unijobs-submit-week > div > div > div').querySelector('unijobs-spinner-button:nth-child(2)').querySelector('ion-button')"
confirm_button = "dom:document.querySelector('ion-modal > unijobs-confirmation-comment-modal > unijobs-modal > div > div > ion-button:nth-child(2)')"
success_popup = "dom:document.querySelector('body > unijobs-root > ion-app > ion-toast').shadowRoot.querySelector('.toast-message')"
accept_all_button = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-subordinates-page > unijobs-subordinates > div > div > div > ion-card > div > div > unijobs-working-hours-table > div > ion-button:nth-child(4)')"
reject_all_button = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-subordinates-page > unijobs-subordinates > div > div > div > ion-card > div > div > unijobs-working-hours-table > div:nth-child(3) > ion-button:nth-child(2)')"
timesheet_delete_button = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-working-hours > div > div > div > ion-card > div > unijobs-submit-week > div > div > form > ion-grid > ion-row:nth-child(2) > ion-col > ion-item > div >unijobs-action-button')"
no_active_assignments = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-working-hours > div > div > div > ion-card > div > unijobs-submit-week > div > div > form > p')"
no_active_assignments_for_day = "dom:document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-working-hours > div > div > div > ion-card > div > unijobs-submit-day > div > div > div > p')"
#API Testing
url = "https://unijobs.umuksoftwareqa.co.uk/api/employee/20/projects"
scroll_calendar = "document.querySelector('body > unijobs-root > ion-app > unijobs-navigation > ion-content > ion-router-outlet > unijobs-working-hours > div > div > ion-card > unijobs-calendar > ion-content').shadowRoot.querySelector('div.inner-scroll.scroll-y').scrollIntoView();"