// SPDX-License-Identifier: MIT
pragma solidity =0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {MOR} from "../src/MOR.sol";

// $ forge script script/MOR.s.sol:MORScript --slow --broadcast --verify --verifier-url https://api-sepolia.etherscan.io/api --etherscan-api-key $ETHERSCAN_API_KEY
contract MORScript is Script {
    MOR public mor;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sepolia");
        // Load private key from the .env file
        uint256 privateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        // Start broadcasting with the private key
        vm.startBroadcast(privateKey);

        mor = new MOR();

        vm.stopBroadcast();
    }
}
