*** Comments ***
This file contains all the keywords related to getting the pets list by status

*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Get Pet List By Available Status
    [Arguments]    ${url}    ${uri}
    Create Session    get_availble_pet_list    ${uri}
    ${response} =    GET On Session    get_availble_pet_list    ${uri}
    RETURN    ${response}

Add New Pet Via POST Request
    [Arguments]    ${base_url}    ${uri}    ${data}    ${header_details}
    Create Session    add_pet_info    url=${base_url}    headers=${header_details}
    ${response} =    POST On Session    alias=add_pet_info    url=${uri}    data=${data}
    RETURN    ${response}

Update Pet Info Via PUT Request
    [Arguments]    ${base_url}    ${uri}    ${data}    ${header_details}
    Create Session    update_pet_info    url=${base_url}    headers=${header_details}
    ${response} =    PUT On Session    alias=update_pet_info    url=${uri}    data=${data}
    RETURN    ${response}

Delete Pet Info Via DELETE Request
    [Arguments]    ${base_url}    ${uri}
    Create Session    alias=delete_pet_info    url=${base_url}
    ${response} =    DELETE On Session    alias=delete_pet_info    url=${uri}
    RETURN    ${response}