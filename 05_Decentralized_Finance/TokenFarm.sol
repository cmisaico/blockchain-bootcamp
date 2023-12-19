// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./JamToken.sol";
import "./StellarToken.sol";

contract TokenFarm {
    string public name = "Stellar Token Farm";
    address public owner;
    JamToken public jamToken;
    StellarToken public stellarToken;

    address [] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(StellarToken _stellarToken, JamToken _jamToken){
        stellarToken = _stellarToken;
        jamToken = _jamToken;
        owner = msg.sender;
    }

    function stakeTokens(uint _amount) public {
        require(_amount > 0, "La Cantidad no puede ser menor a 0");
        jamToken.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] += _amount;
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

}