*** Settings ***
Library           MorseDecoderLibrary.py    ${sender_port}    ${decoder_port}
Library           String

*** Variables ***
${sender_port}=    /dev/tty.usbmodemBSAWBQDQ2
${decoder_port}=    /dev/tty.usbmodem203

*** Keywords ***
Send Morse
    [Arguments]    ${text_to_send}    ${speed}    ${expected_speed_range}=${0}
    Set Speed    ${speed}
    Send Text    ${text_to_send}
    ${text_to_expect}=    Replace String Using Regexp    ${text_to_send}    [^a-zA-Z0-9 ]    x 
    ${text_to_expect}=    Convert To Upper Case    ${text_to_expect}
    Text should be     ${text_to_expect}
    Run Keyword If  ${expected_speed_range} < 1000   Speed should be in range    ${expected_speed_range}

Morse Setup
    Set Auto Wpm Status    OFF
    Auto Wpm Status Should Be    OFF
    Set Immediate Status    OFF
    Immediate Status Should Be    OFF
    
Morse Teardown
    Set Auto Wpm Status   ON
    Auto Wpm Status Should Be    ON
    Set Immediate Status    ON
    Immediate Status Should Be    ON
