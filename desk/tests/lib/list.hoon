::  tests/lib/list/hoon    :: fsharp/tests/FSharp.Core.UnitTests/FSharp.Core/Microsoft.FSharp.Collections/ArrayModule2.fs
|%

++  test-rev
  =/  foo  ~[1 2 3]
  %+  expect-eq
    !>  ~[3 2 1]
    !>  (rev foo)
++  test-rev-empty
  =/  foo  ~
  %+  expect-eq
    !>  ~
    !>  (rev foo)
--
