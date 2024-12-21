// SPDX-License-Identifier: MIT
pragma solidity =0.8.20;

import {INFAFactorySepolia} from "./interfaces/INFAFactorySepolia.sol";
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {Ownable2Step, Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable2Step.sol";

contract NFAProviderSepolia is Ownable2Step {

    using SafeERC20 for IERC20;

    INFAFactorySepolia public nfaFactory;

    mapping (address => uint256) public payment;

    mapping (address => bytes32) public offchainData;

    constructor () Ownable(msg.sender) {
        nfaFactory = INFAFactorySepolia(0xE2e43ef883Ff83307627c92153c9C356821AfF9B);
    }

    function setPayment(address _token, uint256 _payment) public onlyOwner {
        payment[_token] = _payment;
    }

    function createNFA(
        string memory name,
        string memory symbol,
        bytes32 offchainNFAData
    ) public returns (address){

        INFAFactorySepolia.AppInfo memory appInfo = INFAFactorySepolia.AppInfo({
            routerRequired: false, 
            paymentModel: "subscription",
            downloadURIs: new string[](1),
            codeHash: 0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,
            abiURIs: new string[](1),
            abiHash: 0xbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb,
            versionId: "v1.0.0"
        });

        // Fill the arrays with example URIs
        appInfo.downloadURIs[0] = "ipfs://Qm123...";
        appInfo.abiURIs[0] = "ipfs://Qm456...";

        // Prepare the VersionInfo struct with default values
        INFAFactorySepolia.VersionInfo memory versionInfo = INFAFactorySepolia.VersionInfo({
            versionId: "v1.0.1",
            downloadURIs: new string[](1),
            codeHash: 0xcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc,
            abiURIs: new string[](1),
            abiHash: 0xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
        });

        address nfa = nfaFactory.createNFAContract(
            name,
            symbol,
            appInfo, 
            versionInfo,
            msg.sender
        );
        offchainData[nfa] = offchainNFAData;
        return nfa;
    }

    function createNFAWithPayment(
        address token,
        string memory name,
        string memory symbol,
        bytes32 offchainNFAData
    ) public returns (address) {
        if (payment[token] > 0) {
            IERC20(token).safeTransferFrom(msg.sender, address(this), payment[token]);
        }
        return createNFA(name, symbol, offchainNFAData);
    }
}
