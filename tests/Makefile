.PHONY: setup test vm testvm deletevm

setup:
	./moon.sh

test:
	./test_system.sh

vm:
	./test_vagrant.sh

testvm:
	./test_vm.sh

deletevm:
	cd vagrant && vagrant destroy
	rm -rf vagrant .vagrant
