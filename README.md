# Fundraising Smart Contract

This Solidity smart contract allows for decentralized fundraising with a transparent and efficient mechanism for collecting, tracking, and managing contributions.

## Features
- **Contribute:** Allows users to contribute Ether toward a specific fundraising goal.
- **Withdraw Funds:** The owner can withdraw funds if the goal is reached.
- **Refund:** Contributors can request refunds if the goal is not met by the deadline.
- **Transparency:** Publicly tracks all contributions.

## Deployment
1. Open the contract in [Remix](https://remix.ethereum.org/) or use Hardhat.
2. Compile using Solidity 0.8.0 or above.
3. Deploy on an Ethereum-compatible blockchain.

## Usage
- Call `contribute()` to donate Ether.
- Check the total funds with `getContractBalance()`.
- If the goal is met, the owner can withdraw funds using `withdrawFunds()`.
- If the goal is not met, contributors can use `requestRefund()` to get their Ether back.
