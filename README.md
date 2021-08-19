## A self-contained OCaml toplevel

This repository shows how one can make a self-contained toplevel, ie a toplevel
that does not require `.cmi` files to be shipped alongside it, but are instead
stored in the executable itself.

- `make_data.ml`: a little helper script that builds `data.ml` with the marshalled contents
  of the `.cmi` files from the standard library,

- `top.ml` a bit of code that sets up a custom `.cmi` loading function to read
  `.cmi` data directly from `Data` module built using previous script. This code
  is executed before the start of the REPL.

Build with `make` and run with `./top`.
