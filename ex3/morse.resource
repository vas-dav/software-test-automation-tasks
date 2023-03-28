*** Settings ***
Library           MorseDecoderLibrary.py
Library           String

*** Keywords ***
Send Morse
    [Arguments]    ${text_to_send}    ${speed}
    Set Speed    ${speed}
    Send Text    ${text_to_send}
    ${text_to_expect}=    Replace String Using Regexp    ${text_to_send}    [^a-zA-Z0-9 ]    x 
    ${text_to_expect}=    Convert To Upper Case    ${text_to_expect}
    
    Speed should be    ${speed}
    Text should be     ${text_to_expect}