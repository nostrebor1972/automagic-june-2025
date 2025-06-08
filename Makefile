all:
	echo "just testing"

.PHONY: slides login-sp check-reader

slides:
	./scripts/slides.sh

login-sp:
	./scripts/login-sp.sh

check-reader:
	./scripts/check-reader.sh

