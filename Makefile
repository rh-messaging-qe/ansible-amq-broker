TEST_INVENTORY?=tests/inventory

clean:
	rm ansible.cfg

test:
	printf '[defaults]\nroles_path=../' >ansible.cfg
	ansible-playbook tests/test.yml -i $(TEST_INVENTORY)
	rm ansible.cfg
