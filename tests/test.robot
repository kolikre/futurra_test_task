*** Settings ***
Resource  ../testResources/Initialize.robot
Resource  ../configs/config.robot

Library  DebugLibrary
Library  BuiltIn



*** Variables ***
${URL}  https://ironvpn.me/?source=test
${open_modal_button}  //button[@data-hystmodal="#modalForms" and @class="btn"]
${email_input_field}  //input[@id="email"]
${submit_email_button}  //button[@id="validate"]
${privacy_policy_checkbox}  //i[@class="checkplace"]
${get_vpn_button}  //section[@id="trial"]//span[contains(text(), "Get IronVPN Now")]//parent::a
${iframe_card_number_input_field}  //form[@name="paymentForm"]//input[@name="cardNumber"]
${iframe_card_expiration_input_field}  //form[@name="paymentForm"]//input[@name="cardExpiryDate"]
${iframe_card_cvv_input_field}  //form[@name="paymentForm"]//input[@name="cardCvv"]
${iframe_payment_form}  //iframe[@id="solid-payment-form-iframe"]
${preloader}  //div[@class="preloader"]
${iframe_submit_payment_button}  //form[@name="paymentForm"]//button
${payment_successful}  //h3[contains(text(), "Payment was successful!")]


*** Test Cases ***
First test case
    [Setup]   run keywords  Initialize system  AND
    ...                     Go to  ${URL}

    Wait Until Element ${open_modal_button} Is Visible Then Click
    Wait Until Input Field ${email_input_field} Is Visible Then Type ${TEST_EMAIL}
    Wait Until Element ${privacy_policy_checkbox} Is Visible Then Click
    Wait Until Element ${submit_email_button} Is Visible Then Click
    Wait Until Element ${get_vpn_button} Is Visible Then Click
    sleep  1
    Wait Until ELement Is Not Visible  ${preloader}  30
    Select frame  ${iframe_payment_form}
    Wait Until Input Field ${iframe_card_number_input_field} Is Visible Then Type ${CURRENT_CARD_NUMBER}
    Wait Until Input Field ${iframe_card_expiration_input_field} Is Visible Then Type ${CURRENT_CARD_EXPIRATION_DATE}
    Wait Until Input Field ${iframe_card_cvv_input_field} Is Visible Then Type ${CURRENT_CARD_CVV}
    Wait Until Element ${iframe_submit_payment_button} Is Visible Then Click
    Unselect frame
    debug
    Element Should Be Visible  ${payment_successful}

    debug
    [Teardown]  Close All Browsers

*** Keywords ***
Wait Until Element ${element} Is Visible Then Click
    Wait Until Element Is Visible  ${element}  10
    Click element  ${element}

Wait Until Input Field ${element} Is Visible Then Type ${text}
    Wait Until Element Is Visible  ${element}  10
    Click Element  ${element}
    sleep  1s
    Input Text  ${element}  ${text}