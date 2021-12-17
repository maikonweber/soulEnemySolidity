// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract soulBattle {
    // Endereço com Quantidade de Token que ele tem : 
    // Variavel Publica : balance - Este enderço tem está quantidade.
    mapping(address => uint) public balances;

    // Burn e Mint Suply -> 
    // Supply não pode mudar

    uint public totalSupply = 310000000 * 10 ** 18;
    string public name = "Soul of Enemy";
    string public symbol = "SOFE";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);

    constructor () {
        balances[msg.sender] = totalSupply;


    }
        function balanceOf(address owner) public view returns (uint) {
            return balances[owner];
        }

        function transfer(address to, uint value) public returns(bool) {
            require(balanceOf(msg.sender) >= value, 'Soul of Enemy insuficientes');
            balances[to] += value;
            balances[msg.sender] -= value;
            emit Transfer(msg.sender, to, value);
            return true;
        }
}