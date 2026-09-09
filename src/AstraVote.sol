// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AstraVote {

    // --- CUSTOM ERRORS ---
    error AlreadyVoted();
    error InvalidChoice();

    // --- EVENTS ---
    event VoteCast(address indexed voter, uint256 choice);

    event VoterStatusChanged(
        address indexed voter,
        bool hasVoted
    );

    // --- STATE VARIABLES ---
    mapping(address => bool) public hasVoted;

    uint256 public votesForA;
    uint256 public votesForB;

    // --- GOVERNANCE FUNCTIONS ---
    function vote(uint256 _choice) public {

        // Check if already voted
        if (hasVoted[msg.sender]) {
            revert AlreadyVoted();
        }

        // Validate choice
        if (_choice != 1 && _choice != 2) {
            revert InvalidChoice();
        }

        // Mark as voted
        hasVoted[msg.sender] = true;

        // Emit state change event
        emit VoterStatusChanged(msg.sender, true);

        // Process vote
        if (_choice == 1) {
            votesForA++;
        } else {
            votesForB++;
        }

        // Emit vote event
        emit VoteCast(msg.sender, _choice);
    }
}