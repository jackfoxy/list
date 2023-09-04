::  tests/lib/seq/hoon    :: fsharp/tests/FSharp.Core.UnitTests/FSharp.Core/Microsoft.FSharp.Collections/ArrayModule2.fs
/+  *seq, *test
|%
::  TO DO: test failure modes?
::
::  +all-pairs
++  test-all-pairs-00
  %+  expect-eq
    !>  ~[[1 2]]
    !>  (all-pairs ~[1] ~[2])
++  test-all-pairs-example-01  ::  tests wetness
  %+  expect-eq
    !>  ~[['c' 3] ['c' 2] ['c' 1] ['b' 3] ['b' 2] ['b' 1] ['a' 3] ['a' 2] ['a' 1]]
    !>  (all-pairs ~['a' 'b' 'c'] ~[1 2 3])
::
::  +append
++  test-append-00
  %+  expect-eq
    !>  ~
    !>  (append ~ ~)
::++  test-append-01    ::fails to do: report weld issue
::  %+  expect-eq
::    !>  ~[1]
::    !>  (append ~[1] ~)
++  test-append-02
  %+  expect-eq
    !>  ~[1]
    !>  (append ~ ~[1])
++  test-append-03
  %+  expect-eq
    !>  ~[1 2]
    !>  (append ~[1] ~[2])
++  test-append-04
  %+  expect-eq
    !>  ~["a" "b" "D"]
    !>  (append ~["a" "b"] ~["D"])
++  test-append-05
  %+  expect-eq
    !>  ~["a" "C" "D"]
    !>  (append ~["a"] ~["C" "D"])
++  test-append-06
  %+  expect-eq
    !>  ~["a" "b" "C" "D"]
    !>  (append ~["a" "b"] ~["C" "D"])
++  test-append-example-01  ::  tests wetness
  %+  expect-eq
    !>  "urbit"
    !>  (append "urb" "it")
++  test-append-example-02
  %+  expect-eq
    !>  ~[1 2 3 4]
    !>  (append (limo [1 2 ~]) (limo [3 4 ~]))
::
::  +average
::  +average-by
::
::  +choose
++  test-choose-00
  %+  expect-eq
    !>  ~
    !>  (choose ~ |=(a=@ ?:((lth a 5) `a ~)))
++  test-choose-01
  %+  expect-eq
    !>  ~
    !>  (choose ~[5] |=(a=@ ?:((lth a 5) `a ~)))
++  test-choose-02
  %+  expect-eq
    !>  ~[1]
    !>  (choose ~[1] |=(a=@ ?:((lth a 5) `a ~)))
++  test-choose-03
  %+  expect-eq
    !>  ~[1]
    !>  (choose ~[1 5] |=(a=@ ?:((lth a 5) `a ~)))
++  test-choose-04
  %+  expect-eq
    !>  ~[1 2 3 4 4 3 2]
    !>  (choose ~[1 2 3 4 5 6 7 4 3 2] |=(a=@ ?:((lth a 5) `a ~)))
++  test-choose-example-01    ::  test wetness
  %+  expect-eq
    !>  [i=12 t=[i=13 t=~]]
    !>  (choose `(list @)`[0 1 2 3 ~] |=(a=@ ?.((gte a 2) ~ (some (add a 10)))))
::
::  +chunk-by-size
::  +collect
::  +compare-with
::
::  +concat
++  test-concat-00
  %+  expect-eq
    !>  ~
    !>  (concat ~)
++  test-concat-01
  %+  expect-eq
    !>  ~[1]
    !>  (concat ~[~[1]])
++  test-concat-02
  %+  expect-eq
    !>  ~[1 2]
    !>  (concat ~[~[1] ~[2]])
++  test-concat-03
  %+  expect-eq
    !>  ~[1 2 3]
    !>  (concat ~[~[1] ~[2 3]])
++  test-concat-04
  %+  expect-eq
    !>  ~[1 2 3]
    !>  (concat ~[~[1 2] ~[3]])
++  test-concat-05
  %+  expect-eq
    !>  ~[1 2 3 4 5 6 7 4 3 2]
    !>  (concat ~[~[1] ~[2 3] ~[4 5 6] ~[7 4 3] ~[2]])
::  ++  test-concat-wetness  ::  test wetness?
++  test-concat-example-01
  %+  expect-eq
    !>  ~['a' 'b' 'c' 'e' 'f' 'g' 'h' 'i' 'j']
    !>  (concat (limo [(limo ['a' 'b' 'c' ~]) (limo ['e' 'f' 'g' ~]) (limo ['h' 'i' 'j' ~]) ~]))
++  test-concat-example-02
  %+  expect-eq
    !>  ~[1 97 2 98 3 99 4 100]
    !>  (concat (limo [(limo [1 'a' 2 'b' ~]) (limo [3 'c' 4 'd' ~]) ~]))
::
::  +contains
::  +count-by
::  +distinct
::  +distinct-by
::  +empty
::  +exactly-one
::  +except
::  +exists
::  +exists2
::
::  +filter
++  test-filter-00
  %+  expect-eq
    !>  ~
    !>  (filter ~ |=(a=@ (lth a 5)))
++  test-filter-01
  %+  expect-eq
    !>  ~
    !>  (filter (limo ~[5]) |=(a=@ (lth a 5)))
++  test-filter-02
  %+  expect-eq
    !>  ~[1]
    !>  (filter (limo ~[1]) |=(a=@ (lth a 5)))
++  test-filter-03
  %+  expect-eq
    !>  ~[1]
    !>  (filter (limo ~[1 5]) |=(a=@ (lth a 5)))
++  test-filter-04
  %+  expect-eq
    !>  ~[1 2 3 4 4 3 2]
    !>  (filter (limo ~[1 2 3 4 5 6 7 4 3 2]) |=(a=@ (lth a 5)))
::  ++  test-filter-wetness  ::  test wetness?
++  test-filter-example-01
  %+  expect-eq
    !>  [i=2 t=~[3]]
    !>  (filter `(list @)`[0 1 2 3 ~] |=(a=@ (gth a 1)))
::
::  +find
::  +find-back
::  +find-index
::  +find-index-back
::  +fold
::  +fold2
::  +fold-back
::  +forall
::  +forall2
::  +group-by
::  +head
::  +indexed
::  +init
::
::  +insert-at
::++  test-insert-at-00        :: fails  to do: report into?
::  %+  expect-eq
::    !>  ~[1]
::    !>  (insert-at (limo ~) 0 1)
++  test-insert-at-01
  %+  expect-eq
    !>  ~[2 1]
    !>  (insert-at (limo ~[1]) 0 2)
++  test-insert-at-02
  %+  expect-eq
    !>  ~[1 2]
    !>  (insert-at (limo ~[1]) 1 2)
++  test-insert-at-03
  %+  expect-eq
    !>  ~[3 1 2]
    !>  (insert-at (limo ~[1 2]) 0 3)
++  test-insert-at-04
  %+  expect-eq
    !>  ~[1 3 2]
    !>  (insert-at (limo ~[1 2]) 1 3)
++  test-insert-at-05
  %+  expect-eq
    !>  ~[1 2 3]
    !>  (insert-at (limo ~[1 2]) 2 3)
::  ++  test-insert-at-wetness  ::  test wetness?
++  test-insert-at-example-01
  %+  expect-eq
    !>  [i=2 t=~[11 3 4]]
    !>  (insert-at (limo ~[2 3 4]) 1 11)
::
::  +insert-many-at
::  +is-empty
::  +item
::  +iter
::  +iter2
::  +iteri
::  +iteri2
::
::  +last
++  test-last-00            ::  to do: why can't use last
  %+  expect-eq
    !>  1
    !>  (rear ~[1])
::++  test-last-01
::  %+  expect-eq
::    !>  "b"
::    !>  (last ~["a" "b"])
::++  test-last-example-01
::  %+  expect-eq
::    !>  3
::    !>  (last ~[1 2 3])
::++  test-fail-last-example
::  %-  expect-fail
::  |.  (last ~)
::
::  +length
++  test-length-00
  %+  expect-eq
    !>  0
    !>  (length ~)
++  test-length-01
  %+  expect-eq
    !>  1
    !>  (length [1 ~])
++  test-length-example-01
  %+  expect-eq
    !>  4
    !>  (length [1 2 3 4 ~])
++  test-length-example-02
  %+  expect-eq
    !>  5
    !>  (length [1 'a' 2 'b' (some 10) ~])
::
::  +map
::++  test-map-00                      :: to do: can't use map
::  %+  expect-eq
::    !>  ~
::    !>  (map ~ @t)
::++  test-map-01
::  %+  expect-eq
::    !>  ~['h']
::    !>  (map ~[104] @t)
::++  test-map-example-01
::  %+  expect-eq
::    !>  "hoon"
::    !>  (map (limo [104 111 111 110 ~]) @t)
::++  test-map-example-02
::  %+  expect-eq
::    !>  ~[5 6 7 8]
::    !>  (map (limo [1 2 3 4 ~]) |=(a=@ (add a 4)))
::
::  +map2
::  +map3
::  +map-fold
::  +map-fold-back
::  +mapi
::  +mapi2
::  +max
::  +max-by
::  +min
::  +min-by
::  +pairwise
::
::  +partition
++  test-partition-00
  %+  expect-eq
    !>  [p=~ q=~]
    !>  (partition ~ |=(a=@ (gth a 1)))
++  test-partition-01
  %+  expect-eq
    !>  [p=~ q=~[1]]
    !>  (partition (limo ~[1]) |=(a=@ (gth a 1)))
++  test-partition-02
  %+  expect-eq
    !>  [p=~[2] q=~]
    !>  (partition (limo ~[2]) |=(a=@ (gth a 1)))
++  test-partition-example-01
  %+  expect-eq
    !>  [p=[i=2 t=~[3]] q=[i=0 t=~[1]]]
    !>  (partition `(list @)`[0 1 2 3 ~] |=(a=@ (gth a 1)))
::
::  +permute
::  +pick
::  +reduce
::  +reduce-back
::  +remove-at
::
::  +remove-many-at
++  test-remove-many-at-00              :: to do: list first
  %+  expect-eq
    !>  ~
    !>  (remove-many-at [0 0] ~)
++  test-remove-many-at-01
  %+  expect-eq
    !>  ~
    !>  (remove-many-at [0 1] ~)
++  test-remove-many-at-02
  %+  expect-eq
    !>  ~
    !>  (remove-many-at [1 0] ~)
++  test-remove-many-at-03
  %+  expect-eq
    !>  ~[1]
    !>  (remove-many-at [0 0] (limo ~[1]))
++  test-remove-many-at-04
  %+  expect-eq
    !>  ~[1]
    !>  (remove-many-at [1 0] (limo ~[1]))
++  test-remove-many-at-05
  %+  expect-eq
    !>  ~
    !>  (remove-many-at [0 1] (limo ~[1]))
++  test-remove-many-at-06
  %+  expect-eq
    !>  ~
    !>  (remove-many-at [0 3] `(list @)`[1 2 ~])
++  test-remove-many-at-07
   %+  expect-eq
    !>  ~[1 2 5]
    !>  (remove-many-at [2 2] `(list @)`[1 2 3 4 5 ~])
++  test-remove-many-at-08
  %+  expect-eq
    !>  ~[1 2 3 4 5]
    !>  (remove-many-at [2 0] `(list @)`[1 2 3 4 5 ~])  
++  test-remove-many-at-example-01
  %+  expect-eq
    !>  "good urbit!"
    !>  (remove-many-at [4 5] "good day, urbit!")
++  test-remove-many-at-example-02
  %+  expect-eq
    !>  ~[1 2]
    !>  (remove-many-at [2 2] `(list @)`[1 2 3 4 ~])
::
::  +replicate
++  test-replicate-00
  %+  expect-eq
    !>  ~
    !>  (replicate 0 %a)
++  test-replicate-01
  %+  expect-eq
    !>  ~[~]
    !>  (replicate 1 ~)
++  test-replicate-02
  %+  expect-eq
    !>  ~[~ ~]
    !>  (replicate 2 ~)
++  test-replicate-example-01
  %+  expect-eq
    !>  ~[%a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a]
    !>  (replicate 20 %a)
++  test-replicate-example-02
  %+  expect-eq
    !>  ~[~s1 ~s1 ~s1 ~s1 ~s1]
    !>  (replicate 5 ~s1)
++  test-replicate-example-03
  %+  expect-eq
    !>  ~s5
    !>  `@dr`(roll (replicate 5 ~s1) add)
::
::  +rev
::++  test-rev-00    :: to do: rev already used in sys/hoon/hoon
::  %+  expect-eq
::    !>  ~
::    !>  (rev ~)
::++  test-rev-01
::  %+  expect-eq
::    !>  ~[1]
::    !>  (rev ~[1])
::++  test-rev-02
::  %+  expect-eq
::    !>  ~[2 1]
::    !>  (rev ~[1 2])
::++  test-rev-example-01
::  %+  expect-eq
::    !>  ~[3 2 1]
::    !>  (rev (limo ~[1 2 3]))
::
::  +scan
::  +scan-back
::  +singleton
::  +skip
::  +skip-while
::  +sort
::  +sort-by
::  +sort-by-descending
::  +sort-descending
::  +sort-with
::  +split-at
::  +split-into
::  +sum
::  +sum-by
::  +tail
::
::  +take
::++  test-take-00      :: to do: take sucks too
::  %+  expect-eq
::    !>  ~
::    !>  (take 0 ~)
::++  test-take-01
::  %+  expect-eq
::    !>  ~
::    !>  (take 0 ~[1])
::++  test-take-02
::  %+  expect-eq
::    !>  ~
::    !>  (take 1 ~)
::++  test-take-03
::  %+  expect-eq
::    !>  ~[1]
::    !>  (take 1 ~[1])
::++  test-take-example-01
::  %+  expect-eq
::    !>  [i=1 t=~[2]]
::    !>  (take 2 `(list @)`[1 2 3 4 ~])
::++  test-take-example-02
::  %+  expect-eq
::    !>  [i=1 t=~[2 3 4]]
::    !>  (take 10 `(list @)`[1 2 3 4 ~])
::
::  +take-while
::  +transpose
::  +truncate
::  +try-exactly-one
::  +try-find
::  +try-find-back
::  +try-find-index
::  +try-find-index-back
::  +try-head
::  +try-item
::  +try-last
::  +try-pick
::  +unfold
::  +unzip
::  +unzip3
::  +update-at
::  +where
::  +windowed
::  +zip
::  +zip3
--
