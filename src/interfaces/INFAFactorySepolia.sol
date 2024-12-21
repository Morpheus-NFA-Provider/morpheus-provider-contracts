// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INFAFactorySepolia {

    struct AppInfo {
        bool routerRequired;
        string paymentModel;
        string[] downloadURIs;
        bytes32 codeHash;
        string[] abiURIs;
        bytes32 abiHash;
        string versionId;
    }

    struct VersionInfo {
        string versionId;
        string[] downloadURIs;
        bytes32 codeHash;
        string[] abiURIs;
        bytes32 abiHash;
    }

    function createNFAContract(
        string memory name,
        string memory symbol,
        AppInfo memory appInfo,
        VersionInfo memory versionInfo,
        address initialOwner
    ) external returns (address);

}