TEST_INVENTORY?=tests/inventory

containers = cnt-centos6 cnt-centos7

clean:
	rm -rf ansible.cfg ./build
	docker rm -f $(containers) || true

test-prepare: clean
	printf '[defaults]\nroles_path=./build/\n' >ansible.cfg
	ansible-galaxy install -f -r tests/requirements.yml
	printf '[defaults]\nroles_path=./build:../\n' >ansible.cfg

test: test-prepare
	ansible-playbook -vvv tests/test.yml -i $(TEST_INVENTORY)
	rm ansible.cfg
	docker rm -f $(containers) || true
