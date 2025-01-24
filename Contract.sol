// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fundraising {
    address public owner;
    uint public fundraisingGoal;
    uint public deadline;
    uint public totalFunds;
    mapping(address => uint) public contributions;

    event ContributionReceived(address contributor, uint amount);
    event GoalReached(uint totalFunds);
    event RefundIssued(address contributor, uint amount);

    constructor(uint _fundraisingGoal, uint _durationInMinutes) {
        owner = msg.sender;
        fundraisingGoal = _fundraisingGoal;
        deadline = block.timestamp + (_durationInMinutes * 1 minutes);
    }

    function contribute() public payable {
        require(block.timestamp < deadline, "Fundraising period has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        if (totalFunds >= fundraisingGoal) {
            emit GoalReached(totalFunds);
        }
    }

    function withdrawFunds() public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(totalFunds >= fundraisingGoal, "Fundraising goal not reached");
        
        payable(owner).transfer(totalFunds);
        totalFunds = 0;
    }

    function requestRefund() public {
        require(block.timestamp > deadline, "Fundraising period is still active");
        require(totalFunds < fundraisingGoal, "Fundraising goal was met");

        uint amountContributed = contributions[msg.sender];
        require(amountContributed > 0, "You have no contributions to refund");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amountContributed);

        emit RefundIssued(msg.sender, amountContributed);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
