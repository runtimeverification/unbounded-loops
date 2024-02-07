


## HEVM

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


## CERTORA

~~~bash
certoraRun src/Gauss.sol --verify Gauss:src/GaussCertora.spec --solc solc
~~~

## KONTROL

~~~bash
kontrol build
kontrol prove --match-test GaussSpec.check_equivalence --bmc-depth 3
~~~

## GREED

~~~bash
cd ~/rv/green
workon greed

# Create a new folder. The analyses will pollute the current working directory
mkdir /tmp/test_contract
cd /tmp/test_contract/

s# OPTION 2: From the contract bytecode
BYTECODE=$(jq .deployedBytecode.object -r ../out/GaussGreedSpec.sol/GaussGreedSpec.json)
echo $BYTECODE > contract.hex
~/rv/greed/resources/analyze_hex.sh --file contract.hex

~~~


## Kontrol Loop Invariant

~~~
kontrol build --require src/lemmas.k --module-import GaussSpec:GAUSS-LEMMAS --regen --rekompile

kprove --definition out/kompiled --spec-module LOOP-INVARIANTS src/lemmas.k

kontrol prove --match-test GaussSpec.check_equivalence --break-on-jumpi --bmc-depth 15

kontrol prove --match-test GaussSpec.check_equivalence --break-on-jumpi

kontrol show GaussSpec.check_equivalence
~~~