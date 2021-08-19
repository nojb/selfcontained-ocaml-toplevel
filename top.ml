let () =
  let old_load = !Persistent_env.Persistent_signature.load in
  let cmis = Hashtbl.create 0 in
  let load ~unit_name =
    match Data.get unit_name with
    | None ->
      Printf.eprintf "+ loading %s from file system\n%!" unit_name;
      old_load ~unit_name
    | Some cmi ->
      Printf.eprintf "+ loading %s from marshalled copy\n%!" unit_name;
      begin match Hashtbl.find_opt cmis unit_name with
        | None ->
          let cmi = Marshal.from_string cmi 0 in
          let cmi =
            { Persistent_env.Persistent_signature.filename = cmi.Cmi_format.cmi_name;
              cmi }
          in
          Hashtbl.add cmis unit_name cmi;
          Some cmi
        | Some _ as cmi ->
          cmi
      end
  in
  Persistent_env.Persistent_signature.load := load
