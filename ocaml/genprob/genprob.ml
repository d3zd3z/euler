(* Generate the problem set. *)

open Core

let gen fd names =
  fprintf fd "let problems = [\n";
  List.iter names ~f:(fun name ->
    let num = Int.of_string (String.sub name ~pos:2 ~len:3) in
    fprintf fd "  (%d, Pr%03d.run);\n" num num);
  fprintf fd "]\n"

let () =
  let output = ref None in
  let names = ref [] in
  let specs = [ "-o", Arg.String (fun name -> output := Some name), "target" ] in
  let anon name = names := name :: !names in
  Arg.parse specs anon "-o output.ml pr001.ml pr002.ml ...";
  let output = Option.value_exn !output in
  let output_tmp = output ^ ".tmp" in
  Out_channel.with_file output_tmp ~f:(fun fd ->
    gen fd (List.sort !names ~compare:String.compare));
  Unix.rename ~src:output_tmp ~dst:output
