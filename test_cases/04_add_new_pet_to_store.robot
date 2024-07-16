*** Comments ***
#####################################################################################################
Objective:- The Aim of the test case to add pet info to database using POST Api Request and validate
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
${EXP_ID}    20241104
${EXP_NAME}    pitbull
${EXP_TAG}    ghost
${EXP_STATUS}    available
${EXP_HEADER}    application/json

*** Test Cases ***
Send API Request To Add Pet Info To Store :
    ${json_data} =    Get File    ${API_DATA['json_path']}
    ${pet_info} =    Evaluate    json.loads('''${json_data}''')    json
    ${header_details} =    Create Dictionary    Content-Type=${API_DATA['header_details']}
    ${response} =    Add Pet Info To Store Via POST Req    ${PETSTORE_URL['url']}    ${ADD_PET_INFO['uri']}    ${pet_info}    ${header_details}
    Set Suite Variable    ${response}

Validate Status Code :
    ${act_status_code}    Set Variable    ${response.status_code}
    Validate Status Code    ${act_status_code}    ${EXP_STATUS_CODE}

Validate Added Pet Info From The Response :
    Validate Added Pet Info    ${response.content}    ${EXP_ID}    ${EXP_NAME}    ${EXP_TAG}    ${EXP_STATUS}

Validate Header Details From Response :
    Validate Header Details    ${response.headers}    ${EXP_HEADER}
