// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {AstraWall} from "../src/AstraWall.sol";

contract AstraWallGasTest is Test {
    AstraWall astraWall;

    // Exact max-length strings per issue spec
    string constant NAME_20 = "12345678901234567890";           // 20 chars
    string constant GITHUB_20 = "12345678901234567890";          // 20 chars
    string constant LINKEDIN_50 = "12345678901234567890123456789012345678901234567890"; // 50 chars
    string constant SKILLS_30 = "123456789012345678901234567890"; // 30 chars

    function setUp() public {
        astraWall = new AstraWall();
    }

    function testGas_CreateProfile_MaxLengthStrings() public {
        uint256 gasBefore = gasleft();

        astraWall.createProfile(NAME_20, GITHUB_20, LINKEDIN_50, SKILLS_30);

        uint256 gasUsed = gasBefore - gasleft();
        console.log("Gas used for createProfile with max-length strings:", gasUsed);
    }

    function testGas_CreateProfile_EmitsEvent() public {
        vm.expectEmit(true, false, false, true);
        emit AstraWall.ProfileCreated(
            address(this),
            NAME_20,
            GITHUB_20,
            LINKEDIN_50,
            SKILLS_30,
            block.timestamp
        );

        astraWall.createProfile(NAME_20, GITHUB_20, LINKEDIN_50, SKILLS_30);
    }

    function testGas_ProfileStoredCorrectly() public {
        astraWall.createProfile(NAME_20, GITHUB_20, LINKEDIN_50, SKILLS_30);

        (address wallet, string memory name, , , , ) = astraWall.profiles(0);
        assertEq(wallet, address(this));
        assertEq(name, NAME_20);
    }
}