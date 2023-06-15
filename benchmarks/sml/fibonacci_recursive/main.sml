fun fibonacci n =
  (if n = 0 then 0 else if n = 1 then 1 else let
    val tmp1 = fibonacci (n - 1);
    val tmp2 = fibonacci (n - 2);
  in tmp1 + tmp2
  end);

fun force opt =
  (case opt of NONE => raise Fail "force of option failed" | SOME v => v);

fun main () =
    case CommandLine.arguments () of
         []     => print ("Too few arguments!\n")
       | [arg] => print (Int.toString (fibonacci (force (Int.fromString arg))))
       | args   => print ("Too many arguments!\n");

val _ = main ();