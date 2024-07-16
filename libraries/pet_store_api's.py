""" This module is used to get the pet information with different status by using GET API request """

import json
import logging
from robot.libraries.BuiltIn import BuiltIn

class GetPetsStatus:
    """ This class can be used to find the pets different status via GET request """

    def __init__(self, url, uri) -> None:
        self.url = url
        self.uri = uri

    @staticmethod
    def get_api_req(keywords, *args):
        return BuiltIn().run_keyword(keywords, *args)
    
    def get_available_pet_list(self):
        response = self.get_api_req("Get Pet List By Available Status", self.url, self.uri)
        return response

class AddPetInfoToStore:
    """ Class used to upload pet image via PST request """

    def __init__(self, url, uri, data, header) -> None:
        self.url = url
        self.uri = uri
        self.data = data
        self.header = header
    
    def add_pet_info(self):
        resp = GetPetsStatus.get_api_req("Add New Pet Via POST Request", self.url, self.uri,
                                  self.data, self.header)
        return resp

class UpdatePetInfo:
    ''' class used to update exisiting pet info via PUT request '''

    def __init__(self, url, uri, data, header) -> None:
        self.url = url
        self.uri = uri
        self.data = data
        self.header = header
    
    @staticmethod
    def put_api_req(keywords, *args):
        return BuiltIn().run_keyword(keywords, *args)
    
    def update_pet_info(self):
        resp = self.put_api_req("Update Pet Info Via PUT Request", self.url,
                                self.uri, self.data, self.header)
        return resp

class DeletePetInfo:
    ''' class used to delete exisiting pet info via DELETE request '''

    def __init__(self, url, uri) -> None:
        self.url = url
        self.uri = uri

    @staticmethod
    def delete_api_req(keywords, *args):
        return BuiltIn().run_keyword(keywords, *args)
    
    def delete_pet_info(self):
        resp = self.delete_api_req("Delete Pet Info Via DELETE Request", self.url, self.uri)
        return resp

####################################################################
# python keywrds to send api request and validate json response
####################################################################

def get_pet_information_via_GET_req(base_url, rel_url):
    """ method used to get available pet list vis GET request """
    request = GetPetsStatus(base_url, rel_url)
    response = request.get_available_pet_list()
    return response

def validate_status_code(act_status_code, exp_status_code):
    """ This method used to validate status code """
    assert act_status_code == exp_status_code, "Expected Status code not found. Expected is "+exp_status_code+" but found "+act_status_code

def validate_response_content(response, exp_status):
    """ This method used to validate the response content """
    resp_data = json.loads(response)
    statuses = [item['status'] for item in resp_data]
    res = [exp_status == status for status in statuses]
    if res:
        logging.info("Found all pet list with status "+statuses[0]+" list")
    else:
        logging.info("Expected "+statuses[0]+" pet list not found from the response.Kindly check the response")

def validate_pet_information(response, exp_status, exp_id, exp_name):
    """ This method used to validate the pet information fetched via pet id """
    resp_data = json.loads(response)
    act_pet_status = resp_data['status']
    pet_id = resp_data['id']
    pet_name = resp_data['name']
    assert act_pet_status == exp_status, "Expected status not found"
    assert pet_id == int(exp_id), "Expected pet id not found"
    assert pet_name == exp_name, "Expected pet name not found"

def add_pet_info_to_store_via_POST_req(base_url, rel_url, data, header):
    """ methos used to upload the pet image using POST api req """
    json_data = json.dumps(data, indent=4)
    request = AddPetInfoToStore(base_url, rel_url, json_data, header)
    response = request.add_pet_info()
    return response

def validate_added_pet_info(response, exp_id, exp_name, exp_tag, exp_status):
    ''' method used to vaidate the pet info from the store '''
    resp_dict = json.loads(response)
    assert resp_dict['id'] == int(exp_id), "Expected pet id not found. Found "+resp_dict['category']['id']
    assert resp_dict['name'] == exp_name, "Expected pet name not found. Found "+resp_dict['name']
    assert resp_dict['tags'][0]['name'] == exp_tag, "Expected tag name not found. Found "+resp_dict['tags'][0]['name']
    assert resp_dict['status'] == exp_status, "Expected status not found. Found "+resp_dict['status']

def validate_header_details(response, exp_cont_type):
    ''' method used to validate header info from response '''
    assert response['Content-Type'] == exp_cont_type, "Expected header details not found. Found "+response['Content-Type']

def update_pet_info_by_id(base_url, rel_url, data, header_details):
    """ Method used to update the pet info using PUT request """
    json_data = json.dumps(data, indent=4)
    request = UpdatePetInfo(base_url, rel_url, json_data, header_details)
    response = request.update_pet_info()
    return response

def validate_updated_info_for_exst_pet_id(response, exp_id, exp_status):
    """ This Method used to validate the updated info from response """
    resp_dict = json.loads(response)
    assert resp_dict['id'] == int(exp_id), "Expected id not found. Found "+resp_dict['id']
    assert resp_dict['status'] == exp_status, "Expected status not found. Found "+resp_dict['status']

def delete_exisiting_pet_info_by_id(base_url, rel_url):
    """ This method used to delete the exsting pet info by id """
    request = DeletePetInfo(url=base_url, uri=rel_url)
    response = request.delete_pet_info()
    return response