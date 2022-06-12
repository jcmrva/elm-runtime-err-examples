module FailUtils exposing (largeStringLength, functionEquality, nonTailRecursion, mutualRecurseFuncs, modDivByZero)


largeStringLength : Int -> Int
largeStringLength int =
    String.length (String.repeat int "a")

functionEquality : () -> Int
functionEquality () =
    let
        fn1 a = a + 1
        fn2 a = a + 2
    in
        if fn1 == fn2 then
            1
        else
            0

modDivByZero : Int -> Int
modDivByZero int =
    modBy 0 int

nonTailRecursion : a -> Int
nonTailRecursion int =
    1 + nonTailRecursion int

mutualRecurseFuncs : a -> b
mutualRecurseFuncs int =
    recurse1 int

recurse1 : a -> b
recurse1 int =
    recurse2 int

recurse2 : a -> b
recurse2 int =
    recurse1 int
