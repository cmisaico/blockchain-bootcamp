// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract data_structure {
  // Estrucutra de datos
  struct Doctor {
    uint256 id;
    string name;
    string email;
  }

  Doctor doctor1 = Doctor(1, "Chris", "christian@gmail.com");
  // Array de uints
  uint256 [5] public fixed_list_uint = 
    [1,2,3,4,5];
  
  // Dynamic array
  uint256 [] dynamic_list_uint;

  // Array dynamic
  Doctor [] public dynamic_list_doctor;

  function array_modification (uint256 _id, string memory _name
    , string memory _email) public {
      Doctor memory random_doctor = Doctor(_id, _name, _email); 
      dynamic_list_doctor.push(random_doctor);
    }

  //Mappings
  mapping (address => uint256) public addres_uint;
  mapping (string => uint256 []) public string_listunits;
  mapping (address => Doctor) public addres_datastructure;

  function assigNumber(uint256 _number) public {
    addres_uint[msg.sender] = _number;
  }

  function assignList(string memory _name, uint256 _number) public {
    string_listunits[_name].push(_number);
  }

  function assigDataStruct(uint _id, string memory _name, string memory _email) public {
    addres_datastructure[msg.sender] = Doctor(_id, _name, _email);
  }

}