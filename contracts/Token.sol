//SPDX-License-Identifier:GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LoyaltyProgram is ERC20 {
    // Define the terms of the contract
    string public programName;
    uint public rewardRate;

    // Define the parties involved
    address public owner;
    mapping(address => bool) public members;

    // Define the constructor function
    constructor(string memory _programName, uint _rewardRate) ERC20(_programName, "LP") {
        owner = msg.sender;
        programName = _programName;
        rewardRate = _rewardRate;
    }

    // Define the function for adding members
    function addMember(address _memberAddress) public {
        require(msg.sender == owner, "Only the owner can add members");
        members[_memberAddress] = true;
    }

    // Define the function for rewarding members
    function rewardMember(address _memberAddress) public {
        require(members[_memberAddress], "Member not found");
        uint rewardAmount = rewardRate * balanceOf(_memberAddress);
        _mint(_memberAddress, rewardAmount);
    }

    // Define the function for checking the reward balance
    function checkRewardBalance(address _memberAddress) public view returns (uint) {
        return balanceOf(_memberAddress);
    }
}
