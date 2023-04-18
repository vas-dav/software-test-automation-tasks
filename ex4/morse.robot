*** Settings ***
Documentation     Example of morse transmitter test
...  

Resource          morse.resource
Test Setup        Morse Setup
Test Teardown     Morse Teardown
Test Template     Send Morse


*** Variables ***
${lorem}=    Lorem Ipsum is simply dummy text of the printing and typesetting industry.

*** Test Cases ***                  TEXT            SPEED        EXPECTED SPEED RANGE
Send Morse basic                    hello world     500          1001
    [Tags]  text only
Send Morse special char             hello_people    500          10
    [Tags]  relaxed
Send Morse longer text              ${lorem}        500          0
    [Tags]  strict
