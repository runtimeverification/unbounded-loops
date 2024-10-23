// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "./Gauss.sol";

contract DebugGauss {

    Gauss gauss;

    constructor() {
        gauss = new Gauss();
    }

    function debug_sum_to_3() external {
        uint256 n = 3;
        uint256 result = gauss.sumToN(n);
        return;
    }

}