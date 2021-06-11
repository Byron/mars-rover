fixture = tests/fixtures/input.txt
bench_fixture = tests/fixtures/big-input.txt
docker_image = rover_docker_developer_environment

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

always:

interactive-developer-environment-in-docker:
	docker build -t $(docker_image) - < etc/developer.Dockerfile
	docker run -v $$PWD:/volume -w /volume -it $(docker_image)

target/debug/rover: always
	cargo build

target/release/rover: always
	cargo build --release

lint:
	cargo clippy

profile: target/release/rover
	valgrind --callgrind-out-file=callgrind.profile --tool=callgrind  $< $(bench_fixture) >/dev/null
	callgrind_annotate --auto=yes callgrind.profile

benchmark: target/release/rover
	hyperfine '$< $(bench_fixture)'

journey-tests: target/debug/rover
	./tests/stateless-journey.sh $<

answers: target/debug/rover
	$< $(fixture)

answers-in-docker:
	docker run -v $$PWD:/volume -w /volume rust make answers

continuous-journey-tests:
	watchexec $(MAKE) journey-tests

