open Ocamlbuild_pack
open Ocamlbuild_plugin

let get_problems () =
  let pat = Glob.parse "<pr[0-9][0-9][0-9].ml>" in
  Array.fold_right begin fun f acc ->
    if Glob.eval pat f then
      (Pathname.update_extension "byte" f) :: acc
    else acc
  end (Pathname.readdir ".") []

let _ = dispatch begin function
  | Before_options ->
    Options.use_ocamlfind := true;
    (* Just a preference *)
    (* Options.build_dir := "bin"; *)
    Options.targets := ["euler.byte.otarget"];

  | After_rules ->
    let problems = get_problems () in
    rule "All euler problems"
      ~prod:"euler.byte.otarget"
      ~deps:problems
      (fun _ _ -> Command.Nop);
    let native_problems = List.map (Pathname.update_extension "native") problems in
    rule "Native euler problems"
      ~prod:"euler.native.otarget"
      ~deps:native_problems
      (fun _ _ -> Command.Nop);

    (* Keep the sources around *)
    flag ["ocaml"; "compile"; "native"] (S[A "-S"]);

  | _ -> ()

end
