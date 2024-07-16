*** Comments ***
#####################################################################################################
Objective:- The Aim of the test case to update exisiting pet info using PUT Api Request and validate
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
${EXP_STATUS}    sold

*** Test Cases ***
Update Exisiting Pet Info Using Pet ID :
    ${json_data} =    Get File    ${API_DATA['json_path2']}
    ${pet_info} =    Evaluate    json.loads('''${json_data}''')    json
    ${header_details} =    Create Dictionary    Content-Type=${API_DATA['header_details']}
    ${response} =    Update Pet Info By Id    ${PETSTORE_URL['url']}    ${ADD_PET_INFO['uri']}   ${pet_info}    ${header_details}
    Set Suite Variable    ${response}

Validate Status Code After Updating The Record :
    ${act_status_code}    Set Variable    ${response.status_code}
    Validate Status Code    ${act_status_code}    ${EXP_STATUS_CODE}

Validate Updated Info From The Response :
    Validate Updated Info For Exst Pet Id    ${response.content}    ${EXP_ID}    ${EXP_STATUS}    
