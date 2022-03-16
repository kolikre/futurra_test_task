*** Settings ***
Library  Selenium2Library


*** Variables ***
${BROWSER}  Chrome
${WINDOW_WIDTH}   1366
${WINDOW_HEIGHT}  768

*** Keywords ***
Initialize system
    Open Browser  browser=${BROWSER}
    Set Window Size  ${WINDOW_WIDTH}  ${WINDOW_HEIGHT}




