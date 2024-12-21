// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFAProviderSepolia} from "../src/NFAProviderSepolia.sol";

contract NFAProviderSepoliaTest is Test {
    
    NFAProviderSepolia public nfaProvider;

    function setUp() public {
        vm.createSelectFork("sepolia");

        nfaProvider = new NFAProviderSepolia();
    }

    function testCreateNFAOnSepolia() public {
        // Prepare input data
        string memory name = "TestNFA";
        string memory symbol = "TNFA";
        bytes32 offchainData = keccak256("Offchain test data");

        // Call createNFA
        vm.startPrank(tx.origin);
        address nfa = nfaProvider.createNFA(name, symbol, offchainData);
        vm.stopPrank();

        // Retrieve the address of the deployed NFA contract
        // (You'll need to monitor logs/events if required, or track the mapping)
        bytes32 storedOffchainData = nfaProvider.offchainData(address(nfa));

        // Assert that offchain data is correctly stored
        assertEq(storedOffchainData, offchainData, "Offchain data mismatch");
    }

}
