// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


contract TemporalHodl{
    address payable public owner;
    constructor() {
        owner = payable(msg.sender);
    }
    function deposit(uint _amount) public payable {
        }

    receive() external payable{}
    function withdraw(uint _amount) external{
        require(msg.sender == owner, "Only the owner can call this method");
        payable(msg.sender).transfer(_amount);
    }


    function getBalance() external view returns(uint _amount){
        return address(this).balance;
    }
}
contract TimeLock {
    address payable owner;
    uint256 lockTime = 24 days;
    uint256 startTime;

    modifier onlyBy(address _account) {
        require(msg.sender == _account, "Only the owner can call this function.");
        _;
    }

    constructor() {
        owner = payable(msg.sender);
        startTime = block.timestamp;
    }

    receive() external payable {}

    function withdraw() external onlyBy(owner) {
        require(block.timestamp >= startTime + lockTime, "Lock time has not passed yet.");
        owner.transfer(address(this).balance);
    }
}