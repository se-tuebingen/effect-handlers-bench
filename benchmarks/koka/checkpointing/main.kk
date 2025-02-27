module main

import std/os/env

value type input
  Enter(n: int)
  Commit
  Undo
  Done


effect ctl read_input(): input
effect ctl emit(value: int): ()
effect checkpoint
  ctl save(): ()
  ctl retry(): ()

fun inputs<r>(n: int, program: () -> <read_input |e> r): e r {
  var i := 0
  with ctl read_input()
      i := i + 1
      if (i < n) then {
        if (i % 3 == 0) then {
          resume(Commit)
        } else if (i % 5 == 0) then {
          resume(Undo)
        } else {
          resume(Enter(i))
        }
      } else {
        resume(Done)
      }
  program()

}

// why can't i get polymorphism to work here?
fun checkpointing(program: () -> <checkpoint, div, read_input> int): <div, read_input> int {
  var saved := Nothing
  with handler
    ctl save()
      saved := Just(resume)
      resume(())
    ctl retry()
      match saved {
        Just(resumption) -> resumption(())
        Nothing -> checkpointing(program)
      }
  program()
}

fun sum(stream: () -> <read_input, emit, checkpoint, div> ()): <read_input, checkpoint, div> int
  var s := 0
  with ctl emit(v)
    s := s + v
    resume(())
  stream()
  return s


fun user(): <read_input, emit, checkpoint, div> () {
  match read_input() {
    Enter(n) -> {
      emit(n)
      user()
    }
    Commit() -> {
      save()
      user()
    }
    Undo() -> retry()
    Done() -> ()
  }
}

fun run(n: int): div int {
  inputs(n, fn()
    checkpointing(fn()
      sum(user)
    )
  )
}

pub fun main()
  val n = get-args().head("").parse-int().default(10)
  val r = run(n)
  println(r)

