*** Settings ***
Library  BuiltIn

*** Variables ***
${open_modal_with_email_field_button}  //button[@data-hystmodal="#modalForms" and @class="btn"]
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



*** Keywords ***
Page title should be
    [Arguments]  ${expected_title}
    ${actual_title} =  Get title
    Should Be Equal  ${expected_title}  ${actual_title}

Insert credit card data
    [Arguments]  &{data}
    Wait Until Input Field ${iframe_card_number_input_field} Is Visible Then Type ${data}[number]
    Wait Until Input Field ${iframe_card_expiration_input_field} Is Visible Then Type ${data}[date]
    Wait Until Input Field ${iframe_card_cvv_input_field} Is Visible Then Type ${data}[cvv]

Submit payment
    Wait Until Element ${iframe_submit_payment_button} Is Visible Then Click

Open Email modal window
    Wait Until Element ${open_modal_with_email_field_button} Is Visible Then Click

Open payment modal window
    Wait Until Element ${get_vpn_button} Is Visible Then Click
    sleep  1
    Wait Until ELement Is Not Visible  ${preloader}  30

Insert ${email} into "Email" modal window
    Wait Until Input Field ${email_input_field} Is Visible Then Type ${email}
    Wait Until Element ${privacy_policy_checkbox} Is Visible Then Click
    Wait Until Element ${submit_email_button} Is Visible Then Click

Wait Until Element ${element} Is Visible Then Click
    Wait Until Element Is Visible  ${element}  10
    Click element  ${element}

Wait Until Input Field ${element} Is Visible Then Type ${text}
    Wait Until Element Is Visible  ${element}  10
    Click Element  ${element}
    sleep  1s
    Input Text  ${element}  ${text}
