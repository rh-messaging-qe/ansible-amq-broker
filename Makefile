TEST_INVENTORY?=tests/inventory

containers = docker_r1 docker_r2 docker_r3 docker_r4 docker_r5

clean:
	rm ansible.cfg

test-prepare:
	ansible-galaxy install -f -r tests/requirements.yml

test:
	printf '[defaults]\nroles_path=../' >ansible.cfg
	ansible-playbook tests/test.yml -i $(TEST_INVENTORY)
	rm ansible.cfg
