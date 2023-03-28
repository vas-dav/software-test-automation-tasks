*** Settings ***
Library           MorseDecoderLibrary.py    ${sender_port}    ${decoder_port}
Library           String

*** Variables ***
${sender_port}=    /dev/tty.usbmodemBSAWBQDQ2
${decoder_port}=    /dev/tty.usbmodem203

*** Keywords ***
Send Morse
    [Arguments]    ${text_to_send}    ${speed}    ${expected_speed}
    Set Speed    ${speed}
    Send Text    ${text_to_send}
    ${text_to_expect}=    Replace String Using Regexp    ${text_to_send}    [^a-zA-Z0-9 ]    x 
    ${text_to_expect}=    Convert To Upper Case    ${text_to_expect}
    
    Speed should be    ${expected_speed}
    Text should be     ${text_to_expect}