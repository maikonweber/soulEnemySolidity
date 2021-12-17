// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract soulofEnemyToken {
    string public name = "Soul of Enemy Token";
    string public symbol = "SOUL";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000000 * 10 ** 18;
    
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    mapping (address => mapping (address => uint256)) public allowance;
    mapping (address => uint256) public balances;

    constructor() public {
        balances[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(balances[msg.sender] >= value);
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool success) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        require(balances[from] >= value);
        require(allowance[from][msg.sender] >= value);
        balances[from] -= value;
        balances[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

}