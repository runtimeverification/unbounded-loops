This repository contains the supplementary code to this [blog post](https://runtimeverification.com/blog/draft/formally-verifying-loops-part-1).

## hevm

~~~bash
BYTECODE=$(jq .deployedBytecode.object -r out/GaussSpec.sol/GaussSpec.json)
hevm symbolic --sig "check_equivalence(uint256)" --code $BYTECODE
~~~

~~~bash
BYTECODE=$(jq .deployedBytecode.object -r out/GaussSpec.sol/GaussSpec.json)
hevm symbolic --sig "check_sumToN_success(uint256)" --code $BYTECODE --assertions '[0x01, 0x11]'
~~~

~~~bash
BYTECODE=$(jq .deployedBytecode.object -r out/AssertTrueFalse.sol/AssertTrueFalse.json)
hevm symbolic --sig "test_assertFalse()" --code $BYTECODE
~~~

## Halmos

~~~bash
halmos --match-contract GaussSpec --match-test equivalence
~~~

Run with yices instead of z3 for better performance:

~~~bash
halmos --match-contract GaussSpec --match-test equivalence --solver-command yices-smt2 --loop 256
~~~

## Certora

~~~bash
certoraRun src/Gauss.sol --verify Gauss:src/GaussCertora.spec --solc solc
~~~

## Kontrol

Unroll the loop:

~~~bash
kontrol build
kontrol prove --match-test GaussSpec.check_equivalence --bmc-depth 3 --break-on-jumpi
~~~

Inspect the unrolled loop:

~~~bash
kontrol view-kcfg GaussSpec.check_equivalence
~~~

Get a summary of the unrolled loop:

~~~bash
kontrol show GaussSpec.check_equivalence --node-delta 43,46
~~~

Prove the loop invariant

~~~bash
kontrol build --require src/lemmas.k --module-import GaussSpec:GAUSS-CONTRACT --regen --rekompile
kevm prove --definition out/kompiled --spec-module LOOP-INVARIANTS src/lemmas.k --save-directory kevm_out --break-on-jumpi --max-depth 100
~~~

Apply the loop invariant

~~~bash
kontrol build --require src/lemmas.k --module-import GaussSpec:GAUSS-LEMMAS --regen --rekompile
kontrol prove --match-test GaussSpec.check_equivalence
~~~
