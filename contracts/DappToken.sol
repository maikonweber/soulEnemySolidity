// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./soulofEnemy.sol";
import "./soulofEnemyToken.sol";

contract soulofEnemyFarm{
    string public name = "Soul of Enemy Farm";
    address public owner;
    soulofEnemy public soulofEnemy;
    soulofEnemyToken public soulofEnemyToken;

    address [] public stakers;

    mapping(address => uint) public stakingBalance;
    mapping(address => bool ) public hasStaked;
    mapping (address => bool ) public isStaking;

    constructor(soulofEnemy _soulofEnemy , soulofEnemyToken _soulofEnemyToken) public {
        soulofEnemy = _soulofEnemy;
        soulofEnemyToken = _soulofEnemyToken;
        owner = msg.sender;
    }

    function stakeTokens(uint _amount) public {
        require(_amount > 0, "Amount must be greater than 0");

        soulofEnemy.transferFrom(msg.sender, address(this), _amount);
        
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    function unstakeToken() public {
        uint balance = stakingBalance[msg.sender];

        require(balance > 0, "You have no tokens to unstake");

        soulofEnemy.transferFrom(address(this), msg.sender, balance);

        stakingBalance[msg.sender] = 0;

        isStaking[msg.sender] = false;

    }

    function issueTokens() public {
        require(msg.sender == owner, "Only the owner can issue tokens");
        for (uint i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = hasStaked[recipient];
            if(balance > 0) {
                soulofEnemyToken.transfer(recipient, balance);
            }
        }
    }
}

