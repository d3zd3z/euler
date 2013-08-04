// An seq permuter.

module Misc

open System.Collections
open System.Collections.Generic

type Permuter<'t when 't : comparison> =
    new : start:'t array -> Permuter<'t>

    interface IEnumerator
    interface IEnumerator<'t array>
    interface IEnumerable<'t array>

val stringPermute : text:string -> Permuter<char>
