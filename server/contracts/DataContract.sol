pragma solidity ^0.8.9;

// SPDX-License-Identifier: UNLICENSED

contract DataContract {
    mapping(string => uint) public users;
    mapping(uint => uint) public businesses;
    uint public userCount;
    string[] public userlist;
    address private owner;

    constructor(){
        owner = msg.sender;
    }

    function addUser(string memory userID) public {
        require(msg.sender == owner, "Only the owner can add a user");
        users[userID] = 0;
        userlist.push(userID);
        userCount++;
    }

    function addBalanceToUser(string memory userID, uint amount) public {
        require(msg.sender == owner, "Only the owner can add balance to a user");
        users[userID] += amount;
    }

    function addBusiness(uint businessID) public {
        require(msg.sender == owner, "Only the owner can add a business");
        businesses[businessID] = 0;
    }

    function addBalanceToBusiness(uint businessID, uint amount) public {
        require(msg.sender == owner, "Only the owner can add balance to a business");
        businesses[businessID] += amount;
    }

    function transferBalanceFromUserToBusiness(string memory userID, uint businessID, uint amount) public returns(bool){
        require(msg.sender == owner, "Only the owner can transfer balance from a user to a business");
        if(users[userID]>=amount){
            users[userID] -= amount;
            businesses[businessID] += amount;
            return true;
        }
        else{
            return false;
        }
    }

    function getUserIDs() public view returns (string[] memory) {
        return userlist;
    }

    function getBusinessBalance(uint businessID) public view returns (uint) {
        return businesses[businessID];
    }

    function resetBusinessBalance(uint businessID) public {
        businesses[businessID] = 0;
    }

    function getUserBalance(string memory userID) public view returns (uint) {
        return users[userID];
    }
}
