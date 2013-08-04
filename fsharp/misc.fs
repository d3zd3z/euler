// Miscellaneous tools.

module Misc

open System.Collections.Generic
open System.Collections

type Permuter<'t when 't : comparison> (start : 't array) =

    let work = Array.copy (start)
    let mutable first = true

    let swap a b =
        let tmp = work.[a]
        work.[a] <- work.[b]
        work.[b] <- tmp

    let rec revPart a b =
        if a < b then
            swap a b
            revPart (a+1) (b-1)

    // Just clone our selves.
    interface IEnumerable<'t array> with
        member this.GetEnumerator () = new Permuter<_> (work) :> IEnumerator<_>
        member this.GetEnumerator () = new Permuter<_> (work) :> IEnumerator

    interface IEnumerator<'t array> with
        /// Return the current permutation
        member this.Current = work
        member this.Dispose () = ()

    interface IEnumerator with
        member this.MoveNext () =
            if first then
                first <- false
                true
            else
                let len = work.Length
                let mutable k = -1
                for x = 0 to len-2 do
                    if work.[x] < work.[x+1] then
                        k <- x
                if k < 0 then false else
                    let mutable l = -1
                    for x = k+1 to len-1 do
                        if work.[k] < work.[x] then
                            l <- x
                    swap k l
                    revPart (k+1) (len-1)
                    true

        member this.Reset () = failwith "Cannot reset"

        member this.Current = box work

let stringPermute (text : string) =
    new Permuter<char> (text.ToCharArray ())
