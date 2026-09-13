// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import the official Foundry Script utility
import {Script} from "forge-std/Script.sol";
// Import your AstraVote smart contract from your src folder
import {AstraVote} from "../src/AstraVote.sol";

contract AstraVoteScript is Script {
    function run() external {
        // Retrieve your private key safely from your environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Tell Foundry to start broadcasting transactions to the blockchain
        vm.startBroadcast(deployerPrivateKey);

        // This line deploys your contract live!
        new AstraVote();

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
