// SPDX-License-Identifier: MIT
pragma solidity =0.8.20;

import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IMOR is IERC20 {
    function faucet() external;
}