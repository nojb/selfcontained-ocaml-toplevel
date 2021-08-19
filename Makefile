top: data.ml top.ml
	ocamlmktop -o $@ $^

data.ml: make_data.ml
	ocaml -I +compiler-libs ocamlcommon.cma $^ > $@

.PHONY: clean
clean:
	rm -f top *.cm*
