*** Settings ***
Resource  ../testResources/Initialize.robot
Resource  ../configs/config.robot
Resource  ../testResources/main.robot

Library  DebugLibrary

Test Setup  run keywords  Initialize system  AND
...                        Go to  ${URL}

Test Teardown  Close All Browsers


*** Variables ***
${payment_successful}  //h3[contains(text(), "Payment was successful!")]
${wrong_card_number_error_message}  //div[@id="cardNumber_error-text" and contains(text(), "Please, check card number")]
${wrong_expiration_date_error_message}  //div[@id="cardExpiryDate_error-text" and contains(text(), "You entered an expiration date that has already passed")]


*** Test Cases ***
It's not possible to pay without approving a privacy policy
    [Tags]  None

    Open Email modal window
    Wait Until Input Field ${email_input_field} Is Visible Then Type ${TEST_EMAIL}
    Run Keyword And Ignore Error  Click element  ${submit_email_button}
    sleep  3
    Page Should not Contain Element  ${get_vpn_button}


The payment should be successful

    Open Email modal window
    Insert ${TEST_EMAIL} into "Email" modal window
    Open payment modal window
    Select frame  ${iframe_payment_form}
    Insert credit card data  &{VALID_CREDIT_CARD_DATA}
    Submit payment
    Unselect frame
    Wait Until Element Is Visible  ${payment_successful}  30
    Page title should be  SUCCESSFUL


The error should be displayed when entering an incorrect card expiration date

    Open Email modal window
    Insert ${TEST_EMAIL} into "Email" modal window
    Open payment modal window
    Select frame  ${iframe_payment_form}
    Insert credit card data  &{CREDIT_CARD_DATA_WITH_INVALID_DATA}
    Page Should Contain Element   ${wrong_card_number_error_message}
    Page Should Contain Element   ${wrong_expiration_date_error_message}
