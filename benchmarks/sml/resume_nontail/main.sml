fun loop i s =
  let fun operator x y =
    let
      val tmp1 = (x - (503 * y) + 37);
      val tmp2 = if tmp1 < 0 then 0 - tmp1 else tmp1;
    in (tmp2 mod 1009)
    end;
  in
    if i = 0 then s else operator i (loop (i - 1) s)
  end;

fun run n =
  let fun step l s =
    if l = 0 then s
    else step (l - 1) (loop n s);
  in step 1000 0 end;

fun force opt =
  (case opt of NONE => raise Fail "force of option failed" | SOME v => v);

fun main () =
    case CommandLine.arguments () of
        []     => print ("Too few arguments!\n")
      | [arg] => print (Int.toString (run (force (Int.fromString arg))) ^ "\n")
      | args   => print ("Too many arguments!\n");

val _ = main ();
