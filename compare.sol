//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
contract Constant{
    uint constant number=20;

    function compare(uint x)public pure returns(bool){
       return number==x;
    }
}
