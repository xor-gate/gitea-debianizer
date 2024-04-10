all:
	./build.sh
clean:
	rm -fv build/*.deb
	rm -Rvf ./usr
deploy:
	./deploy.sh

.phony: all
