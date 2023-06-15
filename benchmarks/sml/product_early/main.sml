datatype 'a List =
    Nil
  | Cons of ('a * ('a List));

exception Zero

fun product xs =
  let fun loop xs = case xs of
      Nil => 0
    | Cons (head, tail) =>
        if head = 0
        then raise Zero
        else head * (loop tail)
  in loop xs handle Zero => 0 end;

fun enumerate i =
  if i < 0 then Nil else Cons (i, enumerate (i - 1));

fun run n =
  let
    val xs = enumerate 1000;
    fun loop i a =
      if (i = 0) then a
      else
        let val tmp = product xs;
        in loop (i - 1) (a + tmp)
      end;
  in loop n 0
  end;

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