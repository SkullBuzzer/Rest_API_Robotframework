*** Comments ***
#####################################################################################################
Objective:- The Aim of the test case to delete pet info using DELETE Api Request and validate
...    the response.
Author:- Gurubasava M
######################################################################################################

*** Settings ***
Library    json
Library    OperatingSystem
Library    Collections
Library    RequestsLibrary
Library    ../libraries/pet_store_api's.py
Resource    ../resource/rest_api_keywords.robot
Variables    ../test_data/api_test_data.yaml
Variables    ../test_data/pet_info.json

*** Variables ***
${EXP_STATUS_CODE}    ${200}
${PET_ID}    20241104

*** Test Cases ***
Delete Pet Info By Id Using DELETE Api Req :
    ${response} =    Delete Exisiting Pet Info By Id    ${PETSTORE_URL['url']}    ${ADD_PET_INFO['uri']}${PET_ID}
    Set Suite Variable    ${response}

Validate Status Code After Removing The Record :
    ${act_status_code}    Set Variable    ${response.status_code}
    Validate Status Code    ${act_status_code}    ${EXP_STATUS_CODE}
