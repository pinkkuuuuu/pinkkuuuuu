// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Maadhav is ERC20{
    constructor() ERC20("Maadhav","MDV"){}

    function mint(address to ,uint256 amount) public{
        _mint(to , amount);
    }
     function burn(address from,uint256 amount) public{
        _burn(from,amount);
     }
}

contract Manager{
    Maadhav _maadhav;

    constructor(Maadhav token){
    _maadhav = token;
    }

    function managermint(uint256 amount) public{
      _maadhav.mint(msg.sender,amount);  
    }
    
    function managerburn(uint256 amount)public{
    _maadhav.burn(msg.sender,amount);
    }
}

