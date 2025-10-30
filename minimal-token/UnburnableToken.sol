// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

error TokensClaimed();
error AllTokensClaimed();
error UnsafeTransfer(address);

contract UnburnableToken {
    mapping(address => uint256) public balances;
    mapping(address => bool) public claimed;

    uint256 public totalSupply;
    uint256 public totalClaimed;

    constructor() {
        totalSupply = 100_000_000;
        totalClaimed = 0;
    }

    function claim() public {
        if (claimed[msg.sender]) revert TokensClaimed();
        if (totalClaimed + 1000 > totalSupply) revert AllTokensClaimed();

        claimed[msg.sender] = true;
        balances[msg.sender] += 1000;
        totalClaimed += 1000;
    }

    function safeTransfer(address _to, uint256 _amount) public {
        if (_to == address(0)) revert UnsafeTransfer(_to);
        // Check recipient ETH balance (Base Sepolia ETH > 0)
        if (_to.balance == 0) revert UnsafeTransfer(_to);
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
