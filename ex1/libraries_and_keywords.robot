*** Variables ***
*** Settings ***
Library                             OperatingSystem
Library                             Collections
Library                             String
Library                             Dialogs
Library                             FakerLibrary    locale=fi_FI
Library                             file.py 

*** Test Cases ***
Remove An Existing File
    Remove Existing Address File    Harri Sillanpää.txt

Create A New Address File
    @{names} =    Get Random Names    5
    ${name}=    Get Selection From User    Choose a name.    @{names}
    ${address}=    FakerLibrary.address
    ${final_string}=    Set Variable     ${name}${\n}${address}${\n}
    ${file}=    Set Variable    ${name}.txt
    Create File    ${file}    ${final_string}
    File Should Exist    ${file}
Address File Contains Three Lines
    ${lines}=    Lines In File    Leevi Koskinen.txt
    Should Be Equal    ${lines}    ${3}

*** Keywords ***
Get Random Names
    [Arguments]    ${amount}
    @{names} =    Create List
    FOR    ${i}    IN RANGE    0    ${amount}
        ${tmp} =    FakerLibrary.Name
        Append To List    ${names}    ${tmp}
    END
    [Return]    @{names}
    
Remove Existing Address File
    [Arguments]    ${filename}
    ${fileExists}=    File Exists    ${filename}
    Run Keyword If    ${fileExists} is True    Log And Delete File    ${filename}

Log And Delete File
    [Arguments]    ${file}
    ${data}=    Get File  ${file}
    ${line}=    Get Line From File    ${file}
    Log To Console    ${line} 
    Remove File    ${file}
