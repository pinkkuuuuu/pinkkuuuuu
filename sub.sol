//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
 contract Counter{
     
     function sub(int x,int y)public pure returns(string memory){
         int value=x-y;
         if(value > 0){
             return "positive"; 
         }
         else if (value < 0){
             return "negative";
         }
         else{
             return "zero";
         }
     }

 }
