//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
contract Loop{
    uint sum;

    function add(uint x)public{
        sum=0;
        for (uint i = 0;i <= x;i++){
            sum = sum+i;
        }
        }
        function get()public view returns(uint){
            return sum;
        }
    }
    
