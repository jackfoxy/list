::  /lib/list/hoon
::
::    operations for working with values of type list
::  ^list
|%
::
::  Returns a new list that contains all pairings of elements from two lists.
::  +allPairs: [(list t1) (list t2)] -> (list [t1 t2]) 
++  all-pairs
::

::
::  Returns a new list that contains the elements of the first list followed by
::  elements of the second list.
::    Source
::      ++  weld
::        ~/  %weld
::        |*  [a=(list) b=(list)]
::        =>  .(a ^.(homo a), b ^.(homo b))
::        |-  ^+  b
::        ?~  a  b
::        [i.a $(a t.a)]
::    Examples
::      > (append "urb" "it")
::      "urbit"
::      > (append (limo [1 2 ~]) (limo [3 4 ~]))
::      ~[1 2 3 4]
++  append  weld
::

::
::  Returns the average of the values in a non-empty list.
::  +average: (list *) -> @ud
++  average
::

::
::  Returns the average of values in a list generated by applying a function to
::  each element of the list.
::  +averageBy: [projection:(* -> @ud) (list *)] -> @ud
++  average-by
::

::
::  Applies a function to each element in a list and then returns a list of
::  values v where the applied function returns (unit v). 
::  Returns an empty list when the input list is empty or when the applied
::  chooser function returns ~ for all elements.
::  +choose: [(list *) (* -> (unit v))] -> (list v)
::    Source
::      ++  murn
::        ~/  %murn
::        |*  [a=(list) b=$-(* (unit))]
::        =>  .(a (homo a))
::        |-  ^-  (list _?>(?=(^ a) (need (b i.a))))
::        ?~  a  ~
::        =/  c  (b i.a)
::        ?~  c  $(a t.a)
::        [+.c $(a t.a)]
::    Examples
::      > =a |=(a=@ ?.((gte a 2) ~ (some (add a 10))))
::      > (choose `(list @)`[0 1 2 3 ~] a)
::      [i=12 t=[i=13 t=~]]
++  choose  murn
::

::
::  Divides the input list into lists (chunks) with a positive number of at
::  most chunkSize elements. Returns a new list containing the generated lists
::  (chunks) as its elements. Returns an empty list when the input list is empty
::  +chunkBySize: [chunkSize:@ud (list *)] -> (list (list *))
++  chunk-by-size
::

::
::  For each element of the list, applies the given function. Concatenates all
::  the results and return the combined list.
::  +collect: mapping list
++  collect
::

::
::  Compares two lists using the given comparison function, element by element.
::  +compareWith: comparer list1 list2
++  compare-with
::

::
::  Returns a new list that contains the elements of each the lists in order.
::  +concat: (list (list)) -> (list)
::    Source
::      ++  zing
::        ~/  %zing
::        =|  *
::        |@
::        ++  $
::          ?~  +<
::            +<
::          (welp +<- $(+< +<+))
::        --
::    Examples
::      > (concat (limo [(limo ['a' 'b' 'c' ~]) (limo ['e' 'f' 'g' ~]) (limo ['h' 'i' 'j' ~]) ~]))
::      ~['a' 'b' 'c' 'e' 'f' 'g' 'h' 'i' 'j']
::      > (concat (limo [(limo [1 'a' 2 'b' ~]) (limo [3 'c' 4 'd' ~]) ~]))
::      ~[1 97 2 98 3 99 4 100]
++  concat  zing
::
::  Tests if the list contains the specified element.
::  +contains: value source
++  contains
::

::
::  Applies a key-generating function to each element of a list and returns a
::  list yielding unique keys and their number of occurrences in the original
::  list.
::  +countBy: projection list
++  count-by
::

::
::  Returns a list that contains no duplicate entries according to generic hash
::  and equality comparisons on the entries. If an element occurs multiple times
::  in the list then the later occurrences are discarded.
::  +distinct: list
++  distinct
::

::
::  Returns a list that contains no duplicate entries according to the generic
::  hash and equality comparisons on the keys returned by the given
::  key-generating function. If an element occurs multiple times in the list
::  then the later occurrences are discarded.
::  +distinctBy: projection list
++  distinct-by
::

::
::  Returns an empty list of the given type.
::  +empty: 
++  empty
::

::
::  Returns the only element of the list.
::  +exactlyOne: list
++  exactly-one
::

::
::  Returns a new list with the distinct elements of the input list which do not
::  appear in the itemsToExclude sequence, using generic hash and equality
::  comparisons to compare values.
::  +except: itemsToExclude list
++  except
::

::
::  Tests if any element of the list satisfies the given predicate.
::  +exists: predicate list
++  exists
::

::
::  Tests if any pair of corresponding elements of the lists satisfies the given
::  predicate.
::  +exists2: predicate list1 list2
++  exists2
::

::
::  Returns a new collection containing only the elements of the collection for
::  which the given predicate returns "true"
::  +filter: list [(list) predicate=$-(* ?)]
::    Source
::      ++  skim
::        ~/  %skim
::        |*  [a=(list) b=$-(* ?)]
::        |-
::        ^+  a
::        ?~  a  ~
::       ?:((b i.a) [i.a $(a t.a)] $(a t.a))
::    Examples
::      > =a |=(a=@ (gth a 1))
::      > (filter `(list @)`[0 1 2 3 ~] a)
::      [i=2 t=~[3]]
++  filter  skim
::

::
::  Returns the first element for which the given function returns True. 
::  KeyNotFoundException if no such element exists.
::  +find: predicate list
++  find
::

::
::  Returns the last element for which the given function returns True. 
:: Raises KeyNotFoundException if no such element exists.
::  +findBack: predicate list
++  find-back
::

::
::  Returns the index of the first element in the list that satisfies the given
::  predicate. Raises KeyNotFoundException if no such element exists.
::  +findIndex: predicate list
++  find-index
::

::
::  Returns the index of the last element in the list that satisfies the given
::  predicate. Raises KeyNotFoundException if no such element exists.
::  +findIndexBack: predicate list
++  find-index-back
::

::
::  Applies a function to each element of the collection, threading an
::  accumulator argument through the computation. Take the second argument, and
::  apply the function to it and the first element of the list. Then feed this
::  result into the function along with the second element and so on. Return the
::  final result. If the input function is f and the elements are i0...iN then
::  computes f (... (f s i0) i1 ...) iN.
::  +fold: folder state list
++  fold
::

::
::  Applies a function to corresponding elements of two collections, threading
::  an accumulator argument through the computation. The collections must have
::  identical sizes. If the input function is f and the elements are i0...iN and
::  j0...jN then computes f (... (f s i0 j0)...) iN jN.
::  +fold2: folder state list1 list2
++  fold2
::

::
::  Applies a function to each element of the collection, starting from the end,
::  threading an accumulator argument through the computation. If the input
::  function is f and the elements are i0...iN then computes f i0 (...(f iN s)).
::  +foldBack: folder list state
++  fold-back
::

::
::  Applies a function to corresponding elements of two collections, threading
::  an accumulator argument through the computation. The collections must have
::  identical sizes. If the input function is f and the elements are i0...iN and
::  j0...jN then computes f i0 j0 (...(f iN jN s)).
::  +foldBack2: folder list1 list2 state
++  fold-back2
::

::
::  Tests if all elements of the collection satisfy the given predicate.
::  +forall: predicate list
++  forall
::

::
::  Tests if all corresponding elements of the collection satisfy the given
::  predicate pairwise.
::  +forall2: predicate list1 list2
++  forall2
::

::
::  Applies a key-generating function to each element of a list and yields a
::  list of unique keys. Each unique key contains a list of all elements that
::  match to this key.
::  +groupBy: projection list
++  group-by
::

::
::  Returns the first element of the list.
::  +head: list
++  head
::

::
::  Returns a new list whose elements are the corresponding elements of the
::  input list paired with the index (from 0) of each element.
::  +indexed: list
++  indexed
::

::
::  Creates a list by calling the given generator on each index.
::  +init: length initializer
++  init
::

::
::  Return a new list with a new item inserted before the given index.
::  +insert-at: [(list) index=@ value=*] -> (list)
::    Source
::    ++  into
::      ~/  %into
::      |*  [a=(list) b=@ c=*]
::      ^+  a
::      (weld (scag b a) [c (slag b a)])
::    Examples
::    > (insert-at (limo ~[2 3 4]) 1 11)
::    ~[2 11 3 4]
++  insert-at  into
::
::  Return a new list with new items inserted before the given index.
::  +insertManyAt: index values source
++  insert-many-at
::

::
::  Returns true if the list contains no elements, false otherwise.
::  +isEmpty: list
++  is-empty
::

::
::  Indexes into the list. The first element has index 0.
::  +item: index list
++  item
::

::
::  Applies the given function to each element of the collection.
::  +iter: action list
++  iter
::

::
::  Applies the given function to two collections simultaneously. The 
::  collections must have identical size.
::  +iter2: action list1 list2
++  iter2
::

::
::  Applies the given function to each element of the collection. The integer
::  passed to the function indicates the index of element.
::  +iteri: action list
++  iteri
::

::
::  Applies the given function to two collections simultaneously. The 
::  collections must have identical size. The integer passed to the function indicates the index of element.
::  +iteri2: action list1 list2
++  iteri2
::

::
::  Returns the last element of the list.
::  +last: (list) -> *
::    ArgumentException:  Crash when the input does not have any elements.
::    Source
::      ++  rear
::        ~/  %rear
::        |*  a=(list)
::        ^-  _?>(?=(^ a) i.a)
::        ?>  ?=(^ a)
::        ?:  =(~ t.a)  i.a
::        $(a t.a)
::    Examples
::      > (last ~[1 2 3])
::      3
::      > (last ~)
::      hoon expression failed
++  last  rear
::
::  Returns the length of the list.
::  +length: (list *) -> @ud
::    Source
::      ++  lent
::        ~/  %lent
::        |=  a=(list)
::        ^-  @
::        =+  b=0
::        |-
::        ?~  a  b
::        $(a t.a, b +(b))
::    Examples
::      > (length [1 2 3 4 ~])
::      4
::      > (length [1 'a' 2 'b' (some 10) ~])
::      5
++  length  lent
::
::
::  Builds a new list whose elements are the results of applying the given
::  gate to each of the elements of the list.
::  +map: [(list) mapping:(* -> *)] -> (list)
::    Source
::      ++  turn
::        ~/  %turn
::        |*  [a=(list) b=gate]
::        =>  .(a (homo a))
::        ^-  (list _?>(?=(^ a) (b i.a)))
::        |-
::        ?~  a  ~
::        [i=(b i.a) t=$(a t.a)]
::    Examples
::      > (map (limo [104 111 111 110 ~]) @t)
::      <|h o o n|>
::      > =a |=(a=@ (add a 4))
::      > (map (limo [1 2 3 4 ~]) a)
::      ~[5 6 7 8]
++  map  turn
::

::
::  Builds a new collection whose elements are the results of applying the given
::  function to the corresponding elements of the two collections pairwise.
::  +map2: mapping list1 list2
++  map2
::

::
::  Builds a new collection whose elements are the results of applying the given
::  function to the corresponding elements of the three collections
::  simultaneously.
::  +map3: mapping list1 list2 list3
++  map3
::

::
::  Combines map and fold. Builds a new list whose elements are the results of
::  applying the given function to each of the elements of the input list. The
::  function is also used to accumulate a final value.
::  +mapFold: mapping state list
++  map-fold
::

::
::  Combines map and foldBack. Builds a new list whose elements are the results
::  of applying the given function to each of the elements of the input list.
::  The function is also used to accumulate a final value.
::  +mapFoldBack: mapping list state
++  map-fold-back
::

::
::  Builds a new collection whose elements are the results of applying the given
::  function to each of the elements of the collection. The integer index passed
::  to the function indicates the index (from 0) of element being transformed.
::  +mapi: mapping list
++  mapi
::

::
::  Like mapi, but mapping corresponding elements from two lists of equal length.
::  +mapi2: mapping list1 list2
++  mapi2
::

::
::  Return the greatest of all elements of the list, compared via Operators.max.
::  +max: list
++  max
::

::
::  Returns the greatest of all elements of the list, compared via Operators.max
::  on the function result.
::  +maxBy: projection list
++  max-by
::

::
::  Returns the lowest of all elements of the list, compared via Operators.min.
::  +min: list
++  min
::

::
::  Returns the lowest of all elements of the list, compared via Operators.min
::  on the function result
::  +minBy: projection list
++  min-by
::
::  Returns a list of each element in the input list and its predecessor, with
::  the exception of the first element which is only returned as the predecessor
::  of the second element.
::  +pairwise: list
++  pairwise
::

::
::  Splits the collection into two collections, containing the elements for
::  which the given predicate returns True and False respectively. Element order is preserved in both of the created lists.
::  +partition: [(list) predicate==$-(* ?)] -> [(list) (list)]
::    Source
::      ++  skid
::        ~/  %skid
::        |*  [a=(list) b=$-(* ?)]
::        |-  ^+  [p=a q=a]
::        ?~  a  [~ ~]
::        =+  c=$(a t.a)
::        ?:((b i.a) [[i.a p.c] q.c] [p.c [i.a q.c]])
::    Examples
::      > =a |=(a=@ (gth a 1))
::      > (partition `(list @)`[0 1 2 3 ~] a)
::      [p=[i=2 t=~[3]] q=[i=0 t=~[1]]]
++  partition  skid
::

::
::  Returns a list with all elements permuted according to the specified permutation.
::  +permute: indexMap list
++  permute
::

::
::  Applies the given function to successive elements, returning the first
::  result where function returns Some(x) for some x. If no such element exists
::  then raise KeyNotFoundException
::  +pick: chooser list
++  pick
::

::
::  Apply a function to each element of the collection, threading an accumulator
::  argument through the computation. Apply the function to the first two
::  elements of the list. Then feed this result into the function along with the
::  third element and so on. Return the final result. If the input function is f
::  and the elements are i0...iN then computes f (... (f i0 i1) i2 ...) iN.
::  +reduce: reduction list
++  reduce
::

::
::  Applies a function to each element of the collection, starting from the end,
::  threading an accumulator argument through the computation. If the input
::  function is f and the elements are i0...iN then computes 
::  f i0 (...(f iN-1 iN)).
::  +reduceBack: reduction list
++  reduce-back
::

::
::  Return a new list with the item at a given index removed.
::  +removeAt: index source
++  remove-at
::

::
::  Return a new list with the number of items starting at a given index removed
::  +removeManyAt: [index=@ count=@ (list)] -> (list)
::    Source
::      ++  oust
::        ~/  %oust
::        |*  [[a=@ b=@] c=(list)]
::        (weld (scag +<-< c) (slag (add +<-< +<->) c))
::    Examples
::      > (remove-many-at [4 5] "good day, urbit!")
::      "good urbit!"
::      > (remove-many-at [2 2] `(list @)`[1 2 3 4 ~])
::      ~[1 2]
++  remove-many-at oust
::
::
::  Creates a list by replicating the given initial value.
::  +replicate: [count=@ initial=*] -> (list *)
::    Source
::      ++  reap
::        ~/  %reap
::        |*  [a=@ b=*]
::        |-  ^-  (list _b)
::        ?~  a  ~
::        [b $(a (dec a))]
::    Examples
::      > (reap 20 %a)
::      ~[%a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a %a]
::      > (reap 5 ~s1)
::      ~[~s1 ~s1 ~s1 ~s1 ~s1]
::      > `@dr`(roll (reap 5 ~s1) add)
::      ~s5
++  replicate  reap
::

::
::  Returns a new list with the elements in reverse order.
::  +rev: list
::    Source
::      ++  flop
::        ~/  %flop
::        |*  a=(list)
::        =>  .(a (homo a))
::        ^+  a
::        =+  b=`_a`~
::        |-
::        ?~  a  b
::        $(a t.a, b [i.a b])
::    Examples
::      > =a [1 2 3 ~]
::      > (flop a)
::      ~[3 2 1]
::      > (flop (flop a))
::      ~[1 2 3]
++  rev  flop
::
::  Applies a function to each element of the collection, threading an
::  accumulator argument through the computation. Take the second argument, and
::  apply the function to it and the first element of the list. Then feed this
::  result into the function along with the second element and so on. Returns
::  the list of intermediate results and the final result.
::  +scan: folder state list
++  scan
::

::
::  Like foldBack, but returns both the intermediary and final results
::  +scanBack: folder list state
++  scan-back
::

::
::  Returns a list that contains one item only.
::  +singleton: value
++  singleton
::

::
::  Returns the list after removing the first N elements.
::  +skip: count list
++  skip
::

::
::  Bypasses elements in a list while the given predicate returns True, and then
::  returns the remaining elements of the list.
::  +skipWhile: predicate list
++  skip-while
::

::
::  Sorts the given list using Operators.compare.
::  +sort: list
++  sort
::

::
::  Sorts the given list using keys given by the given projection. Keys are
::  compared using Operators.compare.
::  +sortBy: projection list
++  sort-by
::

::
::  Sorts the given list in descending order using keys given by the given
::  projection. Keys are compared using Operators.compare.
::  +sortByDescending: projection list
++  sort-by-descending
::

::
::  Sorts the given list in descending order using Operators.compare.
::  +sortDescending: list
++  sort-descending
::

::
::  Sorts the given list using the given comparison function.
::  +sortWith: comparer list
++  sort-with
::

::
::  Splits a list into two lists, at the given index.
::  +splitAt: index list
++  split-at
::

::
::  Splits the input list into at most count chunks.
::  +splitInto: count list
++  split-into
::

::
::  Returns the sum of the elements in the list.
::  +sum: list
++  sum
::

::
::  Returns the sum of the results generated by applying the function to each
::  element of the list.
::  +sumBy: projection list
++  sum-by
::

::
::  Returns the list after removing the first element.
::  +tail: list
++  tail
::

::
::  Returns the first N elements of the list.
::  +take: [count:@ud (list *)] -> (list *)
::    Source
::      ++  scag
::        ~/  %scag
::        |*  [a=@ b=(list)]
::        |-  ^+  b
::        ?:  |(?=(~ b) =(0 a))  ~
::        [i.b $(b t.b, a (dec a))]
::    Examples
::      > (scag 2 `(list @)`[1 2 3 4 ~])
::      [i=1 t=~[2]]
::      > (scag 10 `(list @)`[1 2 3 4 ~])
::      [i=1 t=~[2 3 4]]
++  take  scag
::
::
::  Returns a list that contains all elements of the original list while the
::  given predicate returns True, and then returns no further elements.
::  +takeWhile: predicate list
++  take-while
::

::
::  Builds an array from the given list.
::  +toArray: list
++  to-array
::

::
::  Views the given list as a sequence.
::  +toSeq: list
++  to-seq
::

::
::  Returns the transpose of the given sequence of lists.
::  +transpose: lists
++  transpose
::

::
::  Returns at most N elements in a new list.
::  +truncate: count list
++  truncate
::

::
::  Returns the only element of the list or None if it is empty or contains more
::  than one element.
::  +tryExactlyOne: list
++  try-exactly-one
::

::
::  Returns the first element for which the given function returns True.
::  Return None if no such element exists.
::  +tryFind: predicate list
++  try-find
::

::
::  Returns the last element for which the given function returns True.
::  Return None if no such element exists.
::  +tryFindBack: predicate list
++  try-find-back
::

::
::  Returns the index of the first element in the list that satisfies the given
::  predicate. Return None if no such element exists.
::  +tryFindIndex: predicate list
++  try-find-index
::

::
::  Returns the index of the last element in the list that satisfies the given
::  predicate. Return None if no such element exists.
::  +tryFindIndexBack: predicate list
++  try-find-index-back
::

::
::  Returns the first element of the list, or None if the list is empty.
::  +tryHead: list
++  try-head
::

::
::  Tries to find the nth element in the list. Returns None if index is negative
::  or the list does not contain enough elements.
::  +tryItem: index list
++  try-item
::

::
::  Returns the last element of the list. Return None if no such element exists.
::  +tryLast: list
++  try-last
::

::
::  Applies the given function to successive elements, returning Some(x) the
::  first result where function returns Some(x) for some x.
::  If no such element exists then return None.
::  +tryPick: chooser list
++  try-pick
::

::
::  Returns a list that contains the elements generated by the given computation
::  The generator is repeatedly called to build the list until it returns None.
::  The given initial state argument is passed to the element generator.
::  +unfold: generator state
++  unfold
::

::
::  Splits a list of pairs into two lists.
::  +unzip: list
++  unzip
::

::
::  Splits a list of triples into three lists.
::  +unzip3: list
++  unzip3
::

::
::  Return a new list with the item at a given index set to the new value.
::  +updateAt: index value source
++  update-at
::

::
::  Returns a new list containing only the elements of the list for which the
::  given predicate returns "true"
::  +where: predicate list
++  where
::

::
::  Returns a list of sliding windows containing elements drawn from the input
::  list. Each window is returned as a fresh list.
::  +windowed: windowSize list
++  windowed
::

::
::  Combines the two lists into a list of pairs. The two lists must have equal
::  lengths.
::  +zip: list1 list2
++  zip
::

::
::  Combines the three lists into a list of triples. The lists must have equal
::  lengths.
::  +zip3: list1 list2 list3
++  zip3
::
--


++bake
Note: This function isn't specifically a list function but is included in section 2b of the standard library so is documented here for completeness.

Convert wet gate f to a dry gate by specifying argument mold a.

+bake is a wet gate that takes a wet gate and produces a dry gate.

Accepts
f is a gate.

a is a mold.

Produces
A dry gate whose sample type is a.

Source
++  bake
  |*  [f=gate a=mold]
  |=  arg=a
  (f arg)
Examples
> =wet-gate |*(a=* [a a])
> (wet-gate 42)
[42 42]
> (wet-gate ['foo' 'bar'])
[['foo' 'bar'] 'foo' 'bar']
> =dry-gate (bake wet-gate @ud)
> (dry-gate 42)
[42 42]
> (dry-gate ['foo' 'bar'])
-need.@ud
-have.[@t @t]
nest-fail


++fand
All indices in list

Produces the indices of all occurrences of nedl in hstk as a list of atoms.

Accepts
nedl is a list.

hstk is a list.

Produces
A list.

Source
++  fand
  ~/  %fand
  |=  [nedl=(list) hstk=(list)]
  =|  i=@ud
  =|  fnd=(list @ud)
  |-  ^+  fnd
  =+  [n=nedl h=hstk]
  |-
  ?:  |(?=(~ n) ?=(~ h))
    (flop fnd)
  ?:  =(i.n i.h)
    ?~  t.n
      ^$(i +(i), hstk +.hstk, fnd [i fnd])
    $(n t.n, h t.h)
  ^$(i +(i), hstk +.hstk)
Examples
> (fand ~[3] ~[1 2 3])
~[2]
> (fand ~[4] ~[1 2 3])
~
> (fand ~['a'] "cbabab")
~[2 4]
> (fand "ba" "cbabab")
~[1 3]


++find
First index in list

Produces the index of the first occurrence of nedl in hstk as the unit of an atom.

Accepts
nedl is a list.

hstk is a list.

Produces
The unit of an atom.

Source
++  find
  ~/  %find
  |=  [nedl=(list) hstk=(list)]
  =|  i=@ud
  |-   ^-  (unit @ud)
  =+  [n=nedl h=hstk]
  |-
  ?:  |(?=(~ n) ?=(~ h))
     ~
  ?:  =(i.n i.h)
    ?~  t.n
      `i
    $(n t.n, h t.h)
  ^$(i +(i), hstk +.hstk)
Examples
> (find [3]~ ~[1 2 3])
[~ u=2]
> (find [4]~ ~[1 2 3])
~
> (find ['c']~ "cbabab")
[~ u=0]
> (find "ab" "cbabab")
[~ u=2]
> (find "bab" "cbabab")
[~ u=1]



++gulf
List from range

Produces a list composed of each consecutive integer starting from a and ending with b. a and b are themselves included.

Accepts
a is an atom.

b is an atom.

Produces
a list.

Source
++  gulf
  |=  [a=@ b=@]
  ?>  (lte a b)
  |-  ^-  (list @)
  ?:(=(a +(b)) ~ [a $(a +(a))])
Examples
> (gulf 1 6)
~[1 2 3 4 5 6]
> `(list @t)`(gulf 99 106)
<|c d e f g h i j|>


++homo
Homogenize

Produces a list whose type is a fork of all the contained types in the list a. Used when you want to make all the types of the elements of a list the same.

Accepts
a is a list.

Produces
a list.

Source
++  homo
  |*  a=(list)
  ^+  =<  $
    |@  ++  $  ?:(*? ~ [i=(snag 0 a) t=$])
    --
  a
Examples
> lyst
[i=1 t=[i=97 t=[i=2 t=[i=98 t=[i=[~ u=10] t=~]]]]]
> (homo lyst)
~[1 97 2 98 [~ u=10]]
> =a (limo [1 2 3 ~])
> a
[i=1 t=[i=2 t=[i=3 t=~]]]
> (homo a)
~[1 2 3]


++join
Constructs a new list, placing sep between every element of lit.

Accepts
sep is a noun.

lit is a list.

Produces
a list.

Source
++  join
  |*  [sep=* lit=(list)]
  =.  sep  `_?>(?=(^ lit) i.lit)`sep
  ?~  lit  ~
  =|  out=(list _?>(?=(^ lit) i.lit))
  |-  ^+  out
  ?~  t.lit
    (flop [i.lit out])
  $(out [sep i.lit out], lit t.lit)
Examples
> (join ' ' "hoon")
"h o o n"
> (join 0 `(list @)`~[1 2 3])
~[1 0 2 0 3]



++levy
Logical "and" on list

Computes the Boolean logical "and" on the results of gate b applied to each individual element in list a.

Accepts
a is a list.

b is a gate.

Produces
A boolean.

Source
++  levy
  ~/  %levy
  |*  [a=(list) b=$-(* ?)]
  |-  ^-  ?
  ?~  a  &
  ?.  (b i.a)  |
  $(a t.a)
Examples
> =a |=(a=@ (lte a 1))
> (levy `(list @)`[0 1 2 1 ~] a)
%.n
> =a |=(a=@ (lte a 3))
> (levy `(list @)`[0 1 2 1 ~] a)
%.y


++lien
Logical "or" on list

Computes the Boolean logical "or" on the results of applying gate b to every element of ++list a.

Accepts
a is a list.

b is a gate.

Source
++  lien
  ~/  %lien
  |*  [a=(list) b=$-(* ?)]
  |-  ^-  ?
  ?~  a  |
  ?:  (b i.a)  &
  $(a t.a)
Examples
> =a |=(a=@ (gte a 1))
> (lien `(list @)`[0 1 2 1 ~] a)
%.y
> =a |=(a=@ (gte a 3))
> (lien `(list @)`[0 1 2 1 ~]) a)
%.n


++limo
List Constructor

Turns a null-terminated tuple into a list.

Accepts
a is a null-terminated tuple.

Produces
A ++list.

Source
++  limo
  |*  a=*
  ^+  =<  $
    |@  ++  $  ?~(a ~ ?:(*? [i=-.a t=$] $(a +.a)))
    --
  a
Examples
> (limo [1 2 3 ~])
[i=1 t=[i=2 t=[i=3 t=~]]]





++reel
Right fold

Right fold: moves right to left across a list a, recursively slamming a binary gate b with an element from a and an accumulator, producing the final value of the accumulator.

(To "slam" means to call a gate and give it a sample/samples. In this instance, a is the list of samples that are given to the gate b.)

The initial value of the accumulator is the bunt of b's second argument (+<+). This can occasionally produce undesired behavior (see examples). If you need more control over the initial value, try making use of $_ and |:, or perhaps +spin or +spun.

Accepts
a is a list.

b is a binary gate.

Produces
The accumulator, which is a noun.

Source
++  reel
  ~/  %reel
  |*  [a=(list) b=_=>(~ |=([* *] +<+))]
  |-  ^+  ,.+<+.b
  ?~  a
    +<+.b
  (b i.a $(a t.a))
Examples
> (reel `(list @)`[1 2 3 4 5 ~] add)
15

> (reel `(list @)`[6 3 1 ~] sub)
4

> (reel `(list @)`[3 6 1 ~] sub)
! subtract-underflow
! exit
+mul's default sample is 1, so calling +reel with +mul yields the expected behavior:

> *mul
1

> (reel `(list @)`~[1 2 3 4] mul)
24
However, if you build a gate that uses +mul like so, the sample defaults to 0 since that is the bunt of @:

> (reel `(list @)`~[1 2 3 4] |=([a=@ b=@] (mul a b)))
0
We can fix this with |::

> (reel `(list @)`~[1 2 3 4] |:([a=1 b=1] (mul a b)))
24
If you check the definition of +mul, you'll see that it also utilizes this pattern.

We can check explicitly what sequence of operations +reel performs like this:

> =f |:  [l='e_l' r='e_r']
      ^-  @t
      :((cury cat 3) '(' l '*' r ')')
> (reel "abcde" f)
'(a*(b*(c*(d*(e*e_r)))))'


++roll
Left fold

Left fold: moves left to right across a list a, recursively slamming a binary gate b with an element from the list and an accumulator, producing the final value of the accumulator.

(To "slam" means to call a gate and give it a sample/samples. In this instance, a is the list of samples that are given to the gate b.)

The initial value of the accumulator is b's second argument (+<+). This can occasionally produce undesired behavior (see examples). If you need more control over the initial value, try making use of $_ and |:, or perhaps +spin or +spun.

Accepts
a is a list.

b is a binary gate.

Produces
The accumulator, which is a noun.

Source
++  roll
  ~/  %roll
  |*  [a=(list) b=_=>(~ |=([* *] +<+))]
  |-  ^+  ,.+<+.b
  ?~  a
    +<+.b
  $(a t.a, b b(+<+ (b i.a +<+.b)))
Examples
> (roll `(list @)`[1 2 3 4 5 ~] add)
q=15

> (roll `(list @)`[6 3 1 ~] sub)
! subtract-underflow
! exit

> (roll `(list @)`[1 3 6 ~] sub)
q=4
+mul's default sample is 1, so calling +roll with +mul yields the expected behavior:

> *mul
1

> (roll `(list @)`~[1 2 3 4] mul)
24
However, if you build a gate that uses +mul like so, the sample defaults to 0 since that is the bunt of @:

> (roll `(list @)`~[1 2 3 4] |=([a=@ b=@] (mul a b)))
0
We can fix this with |::

> (roll `(list @)`~[1 2 3 4] |:([a=1 b=1] (mul a b)))
24
If you check the definition of +mul, you'll see that it also utilizes this pattern.

We can check explicitly what sequence of operations +roll performs like this:

> =f |:  [l='e_l' r='e_r']
      ^-  @t
      :((cury cat 3) '(' l '*' r ')')
> (roll "abcde" f)
'(e*(d*(c*(b*(a*e_r)))))
This is in contrast to what one might expect:

> =foldl
    |*  [l=(list) f=$-([* *] *)]
    ^-  f
    ?~  l  +<-.f
    %=  $
      +<-.f  (f +<-.f i.l)
      l      t.l
      ==
> (foldl "abcde" f)
'(((((e_l*a)*b)*c)*d)*e)'




++skip
Except

Cycles through the members of list a, passing them to a gate b. Produces a list of all of the members that produce %.n. Inverse of skim.

Accepts
a is a list.

b is a gate that accepts one argument and produces a flag.

Produces
A list of the same type as a.

Source
++  skip
  ~/  %skip
  |*  [a=(list) b=$-(* ?)]
  |-
  ^+  a
  ?~  a  ~
  ?:((b i.a) $(a t.a) [i.a $(a t.a)])
Examples
> =a |=(a=@ (gth a 1))
> (skip `(l)`[0 1 2 3 ~]) a)
[i=0 t=[i=1 t=~]]


++slag
Suffix

Accepts an atom a and list b, producing the remaining elements from b starting at a.

Accepts
a is an atom.

b is a list.

Produces
A list of the same type as b.

Source
++  slag
  ~/  %slag
  |*  [a=@ b=(list)]
  |-  ^+  b
  ?:  =(0 a)  b
  ?~  b  ~
  $(b t.b, a (dec a))
Examples
> (slag 2 (limo [1 2 3 4 ~]))
[i=3 t=[i=4 t=~]]
> (slag 1 (limo [1 2 3 4 ~]))
[i=2 t=[i=3 t=[i=4 t=~]]]


++snag
Index

Accepts an atom a and a ++list b, producing the element at the index of aand failing if the list is null. Lists are 0-indexed.

Accepts
a is an atom.

b is a list.

Produces
Produces an element of b, or crashes if no element exists at that index.

Source
++  snag
  ~/  %snag
  |*  [a=@ b=(list)]
  |-  ^+  ?>(?=(^ b) i.b)
  ?~  b
    ~_  leaf+"snag-fail"
    !!
  ?:  =(0 a)  i.b
  $(b t.b, a (dec a))
Examples
> (snag 2 "asdf")
'd'
> (snag 0 `(list @ud)`~[1 2 3 4])
1


++snap
Replace item at index

Accepts a list a, an atom b, and a noun c, producing the list of a with the item at index b replaced with c.

Accepts
a is a list.

b is a atom.

c is a noun.

Produces
the list of a with the item at index b replaced with c.

Source
++  snap
  ~/  %snap
  |*  [a=(list) b=@ c=*]
  ^+  a
  (weld (scag b a) [c (slag +(b) a)])
Examples
> (snap (limo ~[2 3 4]) 1 11)
~[2 11 4]


++snip
Drop tail off list

Removes the last element from list a.

Accepts
a is a list.

Produces
A list.

Source
++  snip
  ~/  %snip
  |*  a=(list)
  ^+  a
  ?~  a  ~
  ?:  =(~ t.a)  ~
  [i.a $(a t.a)]
Examples
> `tape`(snip "foobar")
"fooba"
> (snip ~)
~


++snoc
Append

Accepts a ++list a and a noun b, producing the list of b appended to a.

Accepts
a is a list.

b is a noun.

Produces
Produces a list of b appended to a.

Source
++  snoc
  |*  [a=(list) b=*]
  (weld a ^+(a [b]~))
Examples
> `tape`(zing (snoc `(list tape)`~["a" "bc" "def"] "g"))
"abcdefg"
> (snoc `(list @ud)`~[1 2 3] 4)
~[1 2 3 4]


++sort
Quicksort

Quicksort: accepts a ++list a and a gate b which accepts two nouns and produces a flag. ++sort then produces a list of the elements of a, sorted according to b.

Accepts
a is a list.

b is a gate that accepts two nouns and produces a boolean.

Produces
A list

Source
++  sort  !.
  ~/  %sort
  |*  [a=(list) b=$-([* *] ?)]
  =>  .(a ^.(homo a))
  |-  ^+  a
  ?~  a  ~
  =+  s=(skid t.a |:(c=i.a (b c i.a)))
  %+  weld
    $(a p.s)
  ^+  t.a
  [i.a $(a q.s)]
Examples
> (sort `(list @)`[0 1 2 3 ~] gth)
~[3 2 1 0]


++spin
Gate to list, with state

Accepts a ++list a, some state b, and a gate c. c is called with a tuple -- the head is an element of a and the tail is the state b, and should produce a tuple of the transformed element and the (potentially modified) state b. Produces a pair where the first element is a list of the transformed elements of a, and the second element is the final value of b.

Accepts
a is a ++list.

b is a noun.

c is a gate.

Produces
A pair of a list and a noun.

Source
++  spin
  ~/  %spin
  |*  [a=(list) b=* c=_|=(^ [** +<+])]
  =>  .(c `$-([_?>(?=(^ a) i.a) _b] [_-:(c) _b])`c)
  =/  acc=(list _-:(c))  ~
  |-  ^-  (pair _acc _b)
  ?~  a
    [(flop acc) b]
  =^  res  b  (c i.a b)
  $(acc [res acc], a t.a)
Examples
> %^  spin  (limo ~[4 5 6])     ::  Trivial example -- does nothing with the state
    0
  |=([n=@ a=@] [n a])
[p=~[4 5 6] q=0]
> %^  spin  (limo ~[4 5 6])     ::  Form a pair with `p` as the index and `q` as the list element
    0
  |=([n=@ a=@] [`(pair)`[a n] +(a)])
[p=~[[p=0 q=4] [p=1 q=5] [p=2 q=6]] q=3]
> %^  spin  (reap 10 0)     :: Create 10 random numbers less than `10`
    ~(. og eny)
  |=([n=@ rng=_og] (rads:rng 10))
[p=~[7 8 6 0 1 5 4 7 9 3] q=<4.rvi {a/@uvJ <51.qyl 129.pdd 41.mac 1.ane $141>}>]
Discussion
(~(rads og eny) 2) creates a random number less than 2, seeding the RNG with entropy (eny). The head of the product is the random number, the tail is the continuation of the RNG.


++spun
Gate to list, with state

Accepts a list a and a gate b. c is internal state, initially derived by bunting the tail of the sample of gate b, instead of being passed in explicitly as in ++spin. Produces a list with the gate applied to each element of the original list. b is called with a tuple -- the head is an element of a and the tail is the state c, and should produce a tuple of the transformed element and the (potentially modified) state c.

Accepts
a is a ++list.

b is a gate.

Produces
A list.

Source
++  spun
  ~/  %spun
  |*  [a=(list) b=_|=(^ [** +<+])]
  p:(spin a +<+.b b)
Examples
> %+  spun  (limo ~[4 5 6])            ::  `p` as the index and `q` as the list element
  |=([n=@ a=@] [`(pair)`[a n] +(a)])
~[[p=0 q=4] [p=1 q=5] [p=2 q=6]]
> =l (limo ~[7 8 9])
> %+  spun  (limo ~[4 5 6])            ::  joins two lists into a list of pairs
  |=([n=@ a=@] [`(pair)`[(snag a l) n] +(a)])
~[[p=7 q=4] [p=8 q=5] [p=9 q=6]]


++swag
Infix

Similar to substr in Javascript: extracts a string infix, beginning at inclusive index a, producing b number of characters.

Accepts
a is an atom.

b is an atom.

c is a list.

Produces
A list of the same type as c.

Source
++  swag
  |*  [[a=@ b=@] c=(list)]
  (scag +<-> (slag +<-< c))
Examples
> (swag [2 5] "roly poly")
"ly po"
> (swag [2 2] (limo [1 2 3 4 ~]))
[i=3 t=[i=4 t=~]]



++welp
Perfect weld

Concatenate two ++lists a and b without losing their type information to homogenization.

Accepts
a is a list.

b is a list.

Produces
A list.

Source
++  welp
  ~/  %welp
  =|  [* *]
  |@
  ++  $
    ?~  +<-
      +<-(. +<+)
    +<-(+ $(+<- +<->))
  --
Examples
> (welp "foo" "bar")
"foobar"
> (welp ~[60 61 62] ~[%a %b %c])
[60 61 62 %a %b %c ~]

> ? (welp ~[60 61 62] ~[%a %b %c])
  [@ud @ud @ud %a %b %c %~]
[60 61 62 %a %b %c ~]
> (welp [sa+1 so+2 ~] si=3)
[[%sa 1] [%so 2] si=3]


