// SPDX-License-Identifier: MIT
pragma solidity =0.8.20;

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IMOR} from "./interfaces/IMOR.sol";

contract MOR is ERC20, IMOR {

    constructor () ERC20("Morpheus Base AI Hackaton", "MOR") {

    }

    function faucet() public {
        _mint(msg.sender ,1e18);
    }

}