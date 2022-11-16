// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//token name is gold
//1=1wei
//no. of gold coin minted wei recieve
//return burn wei to the user

contract Gold is ERC20{
  constructor() ERC20("Gold","GLD"){}

    function mint()public payable{
        _mint(msg.sender ,msg.value);
    }

      function burn(uint _amount) external{
        _burn(msg.sender,_amount);
        payable(msg.sender).transfer(_amount);
    }

}
