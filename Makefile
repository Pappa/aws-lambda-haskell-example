.PHONY: build
build: clean
	@stack build --docker
	@cp `stack --docker path --local-install-root`/bin/bootstrap build
	@cd build && zip function.zip bootstrap && rm bootstrap && cd ..

.PHONY: clean
clean:
	@mkdir -p build
	@rm -rf ./build/*
	@stack clean --docker

.PHONY: deploy
deploy:
	@sls deploy