// SPDX-License-Identifier: MIT
 pragma solidity 0.8.7;
 
 contract Mapping{
     mapping(uint => string)myMap;
     
     function set(uint rollno,string memory name)public{
         myMap[rollno] = name;
     }
     function get(uint rollno)public view returns(string memory){
     return myMap[rollno];
     }
 }
