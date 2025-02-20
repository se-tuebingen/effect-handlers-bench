bench: build
	hyperfine --warmup 3 --export-csv results.csv \
		'countdown/main 200000000' \
		'fibonacci_recursive/main 42' \
		'product_early/main 100000' \
		'iterator/main 40000000' \
		'nqueens/main 12' \
		'generator/main 25' \
		'tree_explore/main 16' \
		'triples/main 300' \
		'resume_nontail/main 10000' \
		'parsing_dollars/main 20000' \
		'handler_sieve/main 60000' \
		'scheduler/main 3000' \
		"interruptible_iterator/main 3000"

test: build
	echo "Running programs..."
	cd countdown ; ./main 5 > actual ; echo 0 > expected ; diff expected actual
	cd fibonacci_recursive ; ./main 5 > actual ; echo 5 > expected ; diff expected actual
	cd product_early ; ./main 5 > actual ; echo 0 > expected ; diff expected actual
	cd iterator ; ./main 5 > actual ; echo 15 > expected ; diff expected actual
	cd nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual
	cd tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd triples ; ./main 10 > actual ; echo 779312 > expected ; diff expected actual
	cd resume_nontail ; ./main 5 > actual ; echo 37 > expected ; diff expected actual
	cd parsing_dollars ; ./main 10 > actual ; echo 55 > expected ; diff expected actual
	cd handler_sieve ; ./main 10 > actual ; echo 17 > expected ; diff expected actual
	cd scheduler ; ./main 10 > actual ; echo 10000 > expected ; diff expected actual
	cd interruptible_iterator ; ./main 10 > actual ; echo 110000 > expected ; diff expected actual

build:
	echo "Building programs..."
	cd countdown ; dune exec -- lexa main.lx -o main
	cd fibonacci_recursive ; dune exec -- lexa main.lx -o main
	cd product_early ; dune exec -- lexa main.lx -o main
	cd iterator ; dune exec -- lexa main.lx -o main
	cd nqueens ; dune exec -- lexa main.lx -o main
	cd generator ; dune exec -- lexa main.lx -o main
	cd tree_explore ; dune exec -- lexa main.lx -o main
	cd triples ; dune exec -- lexa main.lx -o main
	cd resume_nontail ; dune exec -- lexa main.lx -o main
	cd parsing_dollars ; dune exec -- lexa main.lx -o main
	cd handler_sieve ; dune exec -- lexa main.lx -o main
	cd scheduler ; dune exec -- lexa main.lx -o main
	cd interruptible_iterator ; dune exec -- lexa main.lx -o main
	


clean:
	-rm -r */out/
	-rm */main
	-rm results.csv
	-rm */expected
	-rm */actual
