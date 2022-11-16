// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract VOHCoinERC20 {

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

 string public constant name = "VOH Coin";
 string public constant symbol = "VOHN";
 uint8 public constant decimal = 18;

 mapping (address => uint256) balances;
 mapping (address => mapping(address => uint256)) allowed;

 uint256 totalsupply_;

 constructor(uint total){
     totalsupply_= total;
     balances[msg.sender]= totalsupply_;
 }

 function sendMEMoney()public payable{

    }
      function getBalance()external view returns(uint){
        return address(this).balance;
    }
 
     function totalSupply() public view returns (uint256) {
      return totalsupply_;
    }

 function balanceof(address tokenOwner) public view returns(uint){
     return balances[tokenOwner];
 }

 function transfer(address receiver,uint numTokens)public returns(bool){
     require(numTokens <= balances[msg.sender]);
     balances[msg.sender] -= numTokens;
     balances[receiver] += numTokens;
     emit Transfer(msg.sender, receiver, numTokens);
     return true;
 }

 function approve(address delegate,uint numTokens)public returns(bool){
     allowed[msg.sender][delegate] = numTokens;
     emit Approval(msg.sender,delegate,numTokens);
     return true;
 }

 function allowance(address owner,address delegate)public view returns(uint){
     return allowed[owner][delegate];
 }

 function transferfrom(address owner,address buyer,uint numTokens)public returns(bool){
     require(numTokens <= balances[owner]);
     require(numTokens <= allowed[owner][msg.sender]);
     balances[owner] -= numTokens;
     allowed[owner][msg.sender] -= numTokens;
     balances[buyer] += numTokens;
     emit Transfer (owner, buyer, numTokens);
     return true;
 }
 }
