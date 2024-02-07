// Claim: sumToN and triangleNumber are equivalent for all inputs n
// Expected outcome: The claim holds for all n
rule check_equivalence(uint n) {
    env e;
    require e.msg.value == 0;
    require n < 2^128; // Prevent overflow
    mathint sum_to_n = sumToN(e, n);
    mathint triangle_number = triangleNumber(e, n);
    assert sum_to_n == triangle_number;
}

// Claim: the sumToN function does not revert
// Expected outcome: The claims doesn't hold for sufficiently large n
rule check_sum_to_n_success(uint n) {
    env e;
    require e.msg.value == 0;
    sumToN@withrevert(e, n);
    assert !lastReverted;
}