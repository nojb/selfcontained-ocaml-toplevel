let () =
  let f s =
    if not (Filename.check_suffix s ".cmi") then false
    else begin
      let stdlib = "stdlib" in
      let n = String.length stdlib in
      if String.length s < n || String.sub s 0 n <> stdlib then
        false
      else
        true
    end
  in
  let entries =
    Sys.readdir Config.standard_library
    |> Array.to_list
    |> List.filter f
  in
  Printf.printf "let get = function\n";
  List.iter (fun s ->
      let unit_name =
        Filename.remove_extension s
        |> String.capitalize_ascii
      in
      let fn = Filename.concat Config.standard_library s in
      Printf.printf "| %S -> Some %S\n" unit_name (Marshal.to_string (Cmi_format.read_cmi fn) [])
    ) entries;
  Printf.printf "| _ -> None\n"
