fun run n =
  let fun parse a x y z =
    let fun join a2 x2 y2 z2 =
      if a2 = 36 then parse (a + 1) x2 y2 z2
      else if a2 = 10 then parse 0 x2 y2 (z2 + a)
      else z2;
    in
    if y > n
      then z
      else if x = 0
        then join 10 (y + 1) (y + 1) z
        else join 36 (x - 1) y z end;
    in
      parse 0 0 0 0
    end

fun force opt =
  (case opt of NONE => raise Fail "force of option failed" | SOME v => v);

fun main () =
    case CommandLine.arguments () of
        []     => print ("Too few arguments!\n")
      | [arg] => print (Int.toString (run (force (Int.fromString arg))) ^ "\n")
      | args   => print ("Too many arguments!\n");

val _ = main ();
