datatype 'a List =
  Nil
  | Cons of ('a * ('a List));

fun safe queen diag xs =
  case xs of
    Nil => true
  | Cons (q, qs) =>
      if queen <> q andalso queen <> (q + diag) andalso queen <> (q - diag)
      then safe queen (diag + 1) qs
      else false;

fun place size column k =
  if column = 0 then
    k Nil
  else
    place size (column - 1) (fn rest =>
      let
        fun extend next =
          if safe next 1 rest then
            k (Cons (next, rest))
          else
            0
        fun loop i a =
          if i = size then
            a + extend i
          else
            loop (i + 1) (a + extend i)
      in loop 1 0
      end
    );


fun force opt =
  (case opt of NONE => raise Fail "force of option failed" | SOME v => v);

fun main () =
    case CommandLine.arguments () of
         []     => print ("Too few arguments!\n")
       | [arg] =>
          let val n = force (Int.fromString arg);
          in
            print (Int.toString (place n n (fn a => 1)))
          end
       | args   => print ("Too many arguments!\n");

val _ = main ();