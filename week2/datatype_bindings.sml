(* these are called constructors *)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza
                | OneInt of int

val a = Str "Hi"
val b = Str
val c = TwoInts(1+2,3+4)
val d = Pizza
val e = a

fun f x =
    case x of 
        Pizza => 3 |
        Str s => 8 |
        TwoInts(i1,i2) => i1 + i2

val g = f a;