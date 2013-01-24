open Ocamlbuild_pack
open Ocamlbuild_plugin

let get_problems () =
  let pat = Glob.parse "<pr[0-9][0-9][0-9].ml>" in
  Array.fold_right begin fun f acc ->
    if Glob.eval pat f then
      f :: acc
    else acc
  end (Pathname.readdir ".") []

(* Assumes the problems are of the form pr[0-9][0-9][0-9]... *)
let get_problem_number path =
  let name = Pathname.to_string path in
  int_of_string (String.sub name 2 3)

let gen_problem_list problems =
  let nums = List.map get_problem_number problems in
  [ "let problems = [\n" ] @
    (List.map (fun p -> Printf.sprintf "   (%d, Pr%03d.run);\n" p p)
       (List.sort compare nums)) @
    [ "]\n" ]

let _ = dispatch begin function
  | Before_options ->
    Options.use_ocamlfind := true;
    (* Just a preference *)
    (* Options.build_dir := "bin"; *)
    Options.targets := ["euler.byte"];

  | After_rules ->
    let problems = get_problems () in

    (* Generate a listing of the problems. *)
    rule "Problem list"
      ~prod:"problems.ml"
      ~deps:problems
      (fun _ _ -> Command.Echo (gen_problem_list problems, "problems.ml"));

    (* Keep the sources around *)
    flag ["ocaml"; "compile"; "native"] (S[A "-S"]);

  | _ -> ()

end
