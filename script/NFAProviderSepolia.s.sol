// SPDX-License-Identifier: MIT
pragma solidity =0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {NFAProviderSepolia} from "../src/NFAProviderSepolia.sol";

// $ forge script script/NFAProviderSepolia.s.sol:NFAProviderSepoliaScript --slow --broadcast --verify --verifier-url https://api-sepolia.etherscan.io/api --etherscan-api-key $ETHERSCAN_API_KEY
contract NFAProviderSepoliaScript is Script {
    NFAProviderSepolia public nfaProviderSepolia;

    function setUp() public {}

    function run() public {
        vm.createSelectFork("sepolia");
        // Load private key from the .env file
        uint256 privateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        // Start broadcasting with the private key
        vm.startBroadcast(privateKey);

        nfaProviderSepolia = new NFAProviderSepolia();
        // console.log("NFAProviderSepolia: ", nfaProviderSepolia);

        vm.stopBroadcast();
    }
}
