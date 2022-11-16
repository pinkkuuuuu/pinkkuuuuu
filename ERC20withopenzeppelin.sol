//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract Token is ERC20PresetMinterPauser{
 constructor() ERC20PresetMinterPauser("EMPER","EMP"){}
 function mint() public{
    _mint(msg.sender, 1000);
}
}
contract MinerRewardMinter {
    ERC20PresetMinterPauser _token;

    constructor(ERC20PresetMinterPauser token) {
        _token = token;
    }
    function mintMinerReward() public {
        _token.mint(msg.sender, 5000);
    }
     
 }
