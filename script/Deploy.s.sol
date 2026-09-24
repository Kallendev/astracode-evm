// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {AstraWall} from "../src/AstraWall.sol";

contract DeployAstraWall is Script {
    function run() external returns (AstraWall) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        AstraWall astraWall = new AstraWall();

        vm.stopBroadcast();

        console.log("AstraWall deployed to:", address(astraWall));

        return astraWall;
    }
}