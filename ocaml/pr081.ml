(*
 * Problem 81
 *
 * 22 October 2004
 *
 * In the 5 by 5 matrix below, the minimal path sum from the top left
 * to the bottom right, by only moving to the right and down, is
 * indicated in bold red and is equal to 2427.
 *
 *     131 673 234 103 18
 *
 *     201 96  342 965 150
 *
 * [b] 630 803 746 422 111 [b]
 *
 *     537 699 497 121 956
 *
 *     805 732 524 37  331
 *
 * Find the minimal path sum, in matrix.txt (right click and 'Save Link
 * /Target As...'), a 31K text file containing a 80 by 80 matrix, from
 * the top left to the bottom right by only moving right and down.
 *
 * 427337
 *)

open Core

module Node = struct
  type t = int * int [@@deriving sexp, ord]
end
type node = Node.t

module EM = Map.Make (Node)
module ES = Set.Make (Node)

(* A graph is a map from some kind of key to a list of edges. *)
type edge = {
  weight : int;
  next: node }
(*    deriving (Show) *)

(* The map describing the graph. *)
type edge_map = edge list EM.t

(* Build up a matrix out of the contents of the given file. *)
let read_matrix path =
  let lines = In_channel.read_lines path in
  let split_line line = Array.of_list (List.map ~f:int_of_string (String.split line ~on:',')) in
  Array.of_list (List.map lines ~f:split_line)

let sample = [|
  [| 131; 673; 234; 103; 18 |];
  [| 201; 96; 342; 965; 150 |];
  [| 630; 803; 746; 422; 111 |];
  [| 537; 699; 497; 121; 956 |];
  [| 805; 732; 524; 37; 331 |] |]

(* Generate edges (with weights) for the horizontal connections. *)
let horizontal_edges matrix =
  let result = ref [] in
  for row = 0 to Array.length matrix - 1 do
    let the_row = matrix.(row) in
    for col = 1 to Array.length the_row - 1 do
      result := ((row, col-1), { weight = the_row.(col); next = (row,col) }) :: !result
    done
  done;
  !result

let vertical_edges matrix =
  let result = ref [] in
  let width = Array.length matrix.(0) - 1 in
  for col = 0 to width do
    for row = 1 to Array.length matrix - 1 do
      result := ((row-1, col), { weight = matrix.(row).(col); next = (row,col) }) :: !result
    done
  done;
  !result

let build_graph matrix =
  let edge1 = horizontal_edges matrix in
  let edge2 = vertical_edges matrix in
  let init_node = ((-1, -1), { weight = matrix.(0).(0); next = (0, 0) }) in
  let edges = List.append edge1 edge2 in
  let edges = init_node :: edges in
  let combine map (k, v) = EM.change map k ~f:(function
    | None -> Some [v]
    | Some x -> Some (v :: x)) in
  List.fold edges ~init: EM.empty ~f:combine

  (*
  let edges = Enum.append (List.enum edge1) (List.enum edge2) in
  let edges = Enum.append (Enum.singleton init_node) edges in
  let combine map (k, v) = EM.modify_def [] k (fun l -> v :: l) map in
  Enum.fold combine EM.empty edges
  *)

(* Return a specific node from a map, returning that node, as well as
   the map without it. *)
let map_without key map = (EM.find key map, EM.remove key map)
let map_min map =
  let (mkey, mval) = EM.min_elt_exn map in
  (mkey, mval, EM.remove map mkey)

(* Update the cost for the given node. *)
let update_cost costs unvisited cur_weight edges =
  let visit edge =
    if ES.mem unvisited edge.next then begin
      let new_cost = cur_weight + edge.weight in
      match EM.find !costs edge.next with
	| None -> costs := EM.add_exn !costs ~key:edge.next ~data:new_cost
	| Some w when new_cost < w ->
	    costs := EM.add_exn !costs ~key:edge.next ~data:new_cost
	| _ -> ()
    end in
  List.iter edges ~f:visit

let swap (a, b) = (b, a)

let bcmp (_, a) (_, b) = Int.compare a b

(* The unvisited set starts as all of the possible destinations. *)
let compute_unvisited graph =
  let result = ref ES.empty in
  let each ~key ~data = (ignore key; List.iter data ~f:(fun edge -> result := ES.add !result edge.next)) in
  EM.iteri graph ~f:each;
  !result

type intpair = (int * int) [@@deriving eq]

let dijkstra (graph : edge_map) start final =
  let costs = ref (EM.singleton start 0) in
  let unvisited = ref (compute_unvisited graph) in

  let rec loop (current, current_cost) =
    (* printf "Visit %s\n" (Show.show<node> current); *)
    (* printf "  unvisited: %s\n" (Show.show<node list> (List.of_enum (ES.enum !unvisited))); *)
    if equal_intpair current final then uw @@ EM.find !costs current
    else begin
      let edges = EM.find_exn graph current in
      (* printf "  edges: %s\n" (Show.show<edge list> edges); *)
      (* printf "   pre costs: %s\n" (Show.show<(node * int) list> (List.of_enum (EM.enum !costs))); *)
      update_cost costs !unvisited current_cost edges;
      (* printf "  post costs: %s\n" (Show.show<(node * int) list> (List.of_enum (EM.enum !costs))); *)

      (* Remove the "cost" for the current node. *)
      costs := EM.remove !costs current;
      unvisited := ES.remove !unvisited current;

      (* Select the lowest cost node. *)
      let min_elt = uw @@ Sequence.min_elt (EM.to_sequence !costs) ~compare:bcmp in

      (* And, select the lowest cost node to visit. *)
      loop min_elt
    end in
  loop (start, 0)

(* Extract all nodes that don't exit the mapping. *)
let find_exits graph =
  let dests = compute_unvisited graph in
  let srcs = ES.of_list @@ EM.keys graph in
  ES.diff dests srcs

let get_finish graph =
  match ES.to_list (find_exits graph) with
    | [e] -> e
    | [] -> failwith "No exists from graph"
    | _ -> failwith "Multiple exits from graph"

let run () =
  (* let edges = build_graph sample in *)
  let edges = build_graph (read_matrix "../haskell/matrix.txt") in

  (* Printf.printf "%s\n" (Show.show<(node * edge list) list> (List.of_enum (EM.enum edges))); *)
  let result = dijkstra edges (-1, -1) (get_finish edges) in
  printf "%d\n" result
