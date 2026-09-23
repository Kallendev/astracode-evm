// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AstraWall {
    struct BuilderProfile {
        address wallet;
        string name;
        string github;
        string linkedin;
        string skills;
        uint256 timestamp;
    }

    BuilderProfile[] public profiles;

    event ProfileCreated(
        address indexed wallet,
        string name,
        string github,
        string linkedin,
        string skills,
        uint256 timestamp
    );

    function createProfile(
        string calldata _name,
        string calldata _github,
        string calldata _linkedin,
        string calldata _skills
    ) external {
        BuilderProfile memory newProfile = BuilderProfile({
            wallet: msg.sender,
            name: _name,
            github: _github,
            linkedin: _linkedin,
            skills: _skills,
            timestamp: block.timestamp
        });

        profiles.push(newProfile);

        emit ProfileCreated(
            msg.sender,
            _name,
            _github,
            _linkedin,
            _skills,
            block.timestamp
        );
    }

    function getProfilesCount() external view returns (uint256) {
        return profiles.length;
    }
}