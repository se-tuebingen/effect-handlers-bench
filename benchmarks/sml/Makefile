bench: build
	hyperfine --export-csv results.csv \
		'fibonacci_recursive/main 42'

test: build
	cd fibonacci_recursive ; ./main 5 > actual ; echo 5 > expected ; diff expected actual

build:
	cd fibonacci_recursive ; mlton -default-type int64 -output main main.sml

clean:
	-rm -r */out/
	-rm */main
	-rm results.csv
	-rm */expected
	-rm */actual
