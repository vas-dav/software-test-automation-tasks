*** Settings ***
Documentation     Example of morse transmitter test
...  

Resource    morse.resource
Test Template     Send Morse

*** Variables ***
${lorem}=    Lorem Ipsum is simply dummy text of the printing and typesetting industry.

*** Test Cases ***                  TEXT            SPEED        EXPECTED SPEED
Send Morse basic                    hello world     50           50
Send Morse special char             hello_people    50           50
Send Morse longer text              ${lorem}        450          500
