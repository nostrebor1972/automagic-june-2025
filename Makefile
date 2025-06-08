all:
	echo "just testing"

.PHONY: slides login-sp check-reader

slides:
	./scripts/slides.sh

login-sp:
	./scripts/login-sp.sh

check-reader:
	./scripts/check-reader.sh

cpman: cpman-up

cpman-up:
	./scripts/cpman-up.sh

cpman-down:
	./scripts/cpman-down.sh

cpman-serial:
	./scripts/cpman-serial.sh

cpman-ssh:
	./scripts/cpman-ssh.sh

