fun range l u s =
  if l > u then s
  else range (l + 1) u (s + l);

fun run n =
  range 0 n 0;

fun force opt =
  (case opt of NONE => raise Fail "force of option failed" | SOME v => v);

fun main () =
    case CommandLine.arguments () of
         []     => print ("Too few arguments!\n")
       | [arg] =>
          let val n = force (Int.fromString arg);
          in
            print (Int.toString (run n))
          end
       | args   => print ("Too many arguments!\n");

val _ = main ();