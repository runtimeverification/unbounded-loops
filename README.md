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


## Certora

~~~bash
certoraRun src/Gauss.sol --verify Gauss:src/GaussCertora.spec --solc solc
~~~

## Kontrol

~~~bash
kontrol build
kontrol prove --match-test GaussSpec.check_equivalence --bmc-depth 3
~~~

## Kontrol Loop Invariant

~~~
kontrol build --require src/lemmas.k --module-import GaussSpec:GAUSS-LEMMAS --regen --rekompile

kprove --definition out/kompiled --spec-module LOOP-INVARIANTS src/lemmas.k

kontrol prove --match-test GaussSpec.check_equivalence --break-on-jumpi --bmc-depth 15

kontrol prove --match-test GaussSpec.check_equivalence --break-on-jumpi

kontrol show GaussSpec.check_equivalence
~~~