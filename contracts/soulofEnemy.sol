// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract soulofEnemy {
    // Endereço com Quantidade de Token que ele tem : 
    // Variavel Publica : balance - Este enderço tem está quantidade.
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    // Burn e Mint Suply -> 
    // Supply não pode mudar

    uint public totalSupply = 310000000 * 10 ** 18;
    string public name = "Soul of Enemy";
    string public symbol = "SOFY";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);

    
    constructor () {
        balances[msg.sender] = totalSupply;


    }


        function balanceOf(address owner) public view returns (uint) {
            return balances[owner];
        }

        function transfer(address to, uint value) public returns(bool sucess) {
            require(balanceOf(msg.sender) >= value, 'Soul of Enemy insuficientes');
            balances[to] += value;
            balances[msg.sender] -= value;
            emit Transfer(msg.sender, to, value);
            return true;
        }

        function approve(address spender, uint value) public returns(bool sucess) {
            balances[spender] = value;
            emit Approval(msg.sender, spender, value);
            return true;
        }

        function transferFrom(address from, address to, uint256 value) public returns(bool sucess) {
            require(value <= balances[from]);
            require(value <= allowances[from][msg.sender]);
            balances[from] -= value;
            balances[to] += value;
            allowances[from][msg.sender] -= value;
            emit Transfer(from, to, value);
            return true;
        }
}