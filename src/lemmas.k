module GAUSS-LEMMAS [symbolic]

    imports EVM
    imports S2KsrcZModGaussSpec-CONTRACT

    rule  <k>
                ( JUMPI 878 CONDITION => JUMP 878 )
                ~> #pc [ JUMPI ]
                ~> #execute
                ~> _CONTINUATION:K
            </k>
            <program>  BYTECODE </program>
            <pc> 844 </pc>
            <wordStack> ( I => N ) : ( RESULT => N *Int ( N +Int 1 ) /Int 2 ) : 0 : N : WS </wordStack>
            <useGas> false </useGas>
            <jumpDests>  DESTS </jumpDests>
    requires   0 <=Int N andBool N <Int 2 ^Int 128
       andBool 0 <=Int I andBool I <=Int N
       andBool RESULT ==Int I *Int (I +Int 1) /Int 2
       andBool #sizeWordStack(WS) <Int 1013
       andBool DESTS ==K #computeValidJumpDests( #binRuntime ( S2KsrcZModGaussSpec ) )
       andBool CONDITION ==K bool2Word ( N:Int <=Int I )
       andBool BYTECODE ==K #binRuntime ( S2KsrcZModGaussSpec )
       [priority(40)]

endmodule

module LOOP-INVARIANTS

    imports EVM
    imports S2KsrcZModGaussSpec-CONTRACT

    claim  <k>
                ( JUMPI 878 bool2Word ( N:Int <=Int I ) => JUMP 878 )
                ~> #pc [ JUMPI ]
                ~> #execute
                ~> _CONTINUATION:K
            </k>
            <program>  #binRuntime ( S2KsrcZModGaussSpec ) </program>
            <pc> 844 </pc>
            <wordStack> ( I => N ) : ( RESULT => N *Int ( N +Int 1 ) /Int 2 ) : 0 : N : WS </wordStack>
            <useGas> false </useGas>
            <jumpDests>  DESTS </jumpDests>
    requires   0 <=Int N andBool N <Int 2 ^Int 128
       andBool 0 <=Int I andBool I <=Int N
       andBool RESULT ==Int I *Int (I +Int 1) /Int 2
       andBool #sizeWordStack(WS) <Int 1013
       andBool DESTS ==K #computeValidJumpDests( #binRuntime ( S2KsrcZModGaussSpec ) )
    
endmodule