// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import "forge-std/Test.sol";
import "./Gauss.sol";

contract GaussSpec is Gauss, Test {

    // Claim: sumToN and triangleNumber are equivalent for all inputs n
    // Expected outcome: The claim holds for all n
    function check_equivalence(uint256 n) external pure {
        vm.assume(n < 2**128); // prevent overflow
        assert(sumToN(n) == triangleNumber(n));
    }

    // Claim: the sumToN function does not revert
    // Expected outcome: The claims doesn't hold for sufficiently large n
    function check_sumToN_success(uint256 n) external pure {
        sumToN(n);
    }

}