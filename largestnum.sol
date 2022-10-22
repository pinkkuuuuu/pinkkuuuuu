//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
contract Counter{
    uint largestNumber;
    
    function setLargest(uint x, uint y)public{
        if (x>y){
             largestNumber=x;
        }
        else if(x<y){
             largestNumber=y;
        }
        else{
            largestNumber=x;
        }
    }
    function getlargest() public view returns(uint){
        return largestNumber;
    }
}
