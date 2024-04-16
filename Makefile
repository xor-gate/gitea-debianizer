all: debpkg
	./build.sh
clean:
	rm -fv build/*.deb
	rm -Rvf ./usr
deploy:
	./deploy.sh
debpkg: ${HOME}/go/bin/debpkg
${HOME}/go/bin/debpkg:
	go install github.com/xor-gate/debpkg/cmd/debpkg@latest

.phony: all
