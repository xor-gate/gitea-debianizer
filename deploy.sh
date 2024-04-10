#!/bin/sh
scp build/*.deb jerry@n: # Copy to NAS
ssh jerry@n "scp -P 2222 *.deb jerry@localhost:" # Copy over reverse shell to Ubuntu WSL desktop
