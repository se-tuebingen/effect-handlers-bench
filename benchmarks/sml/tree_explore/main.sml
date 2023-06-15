datatype Tree =
    Leaf
  | Node of (Tree * int * Tree);

datatype 'a List =
  Nil
  | Cons of ('a * ('a List));



fun reverse l =
  let fun loop lst acc =
      case lst of
          Nil => acc
        | Cons (head, tail) => loop tail (Cons (head, acc));
  in loop l Nil
  end;


fun reverseOnto l other = case l of
  Nil => other
  | Cons (head, tail) =>
    reverseOnto tail (Cons (head, other));


fun maximum l = case l of
  Nil => ~1
  | Cons (head, tail) =>
    case tail of
        Nil => head
      | _ => let val tmp = maximum tail;
      in if head > tmp then head else tmp
      end;


fun operator x y =
  let val tmp =
    if (x - (503 * y) + 37) < 0
    then 0 - x - (503 * y) + 37
    else x - (503 * y) + 3;
  in tmp mod 1009
  end;


fun make n =
  if n = 0 then Leaf
  else let val t = make (n - 1);
  in Node (t, n, t)
  end;


fun run n = let
  val tree = make n;

  fun explore t k k2 y =
    case t of
      Leaf => k y k2 y
    | Node (left, middle, right) =>
      let fun join a x1 y1 =
        let val tmp = operator y1 middle;
        in
          explore (if a then left else right) (fn a =>
            k (operator middle a)) x1 tmp
        end;
      in
        join true (fn a => fn k4 => join false (fn a1 => k2 (reverseOnto (reverse a) a1)) k4) y
      end;

  fun loop i x =
    if i = 0 then x else
      explore tree
        (fn a => fn k2 => k2 (Cons (a, Nil)))
        (fn a => fn k2 => loop (i - 1) (maximum a))
        x;
    in loop 10 0
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
