*** Comments ***
#####################################################################################################
Objective:- The Aim of the test case to get the list of sold pet list and validate the response
...    via GET Api request
Author:- Gurubasava M
######################################################################################################

*** Settings ***
Library    RequestsLibrary
Library    ../libraries/pet_store_api's.py
Resource    ../resource/rest_api_keywords.robot
Variables    ../test_data/api_test_data.yaml

*** Variables ***
${EXP_STATUS_CODE}    ${200}
${EXP_PET_STATUS}    sold

*** Test Cases ***
Send API Request To Get The Pet List :
    ${response} =    Get Pet Information Via GET Req   ${PETSTORE_URL['url']}    ${PETSTORE_URL['uri']}status=sold
    Set Suite Variable    ${response}

Validate Status Code From The Response :
    ${act_status_code}    Set Variable    ${response.status_code}
    Validate Status Code    ${act_status_code}    ${EXP_STATUS_CODE}

Validate Pet Status From The Response:
    ${resp_content}    Set Variable    ${response.content}
    Validate Response Content    ${resp_content}    ${EXP_PET_STATUS}