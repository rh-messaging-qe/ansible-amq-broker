Role Name
=========

A JBoss AMQ 7 Broker deployment role.

Requirements
------------

None.

Role Variables: Basic Variables
--------------

Variables controlling what will be executed by the role.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_skip_install` | false | Whether to skip installation process. |
| `amq_broker_skip_create` | false | Whether to skip instance creation process. |
| `amq_broker_skip_configure` | true | Whether to skip instance configure process. |


Role Variables: Installation Variables
--------------

Variables controlling broker installation parameters.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_download_dest` | `/tmp` | Download destination |
| `amq_broker_install_dest` | `/home/{{ amq_broker_user }}` | Install destination |
| `amq_broker_user` | jamq | System user to create for running JBoss AMQ 7 Broker |
| `amq_broker_install_link` | jboss-amq-7 | Friendly link name for the installation dir |
| `amq_broker_download_url` | http://host/path/to/amq/jboss-amq-7.0.0.redhat-1-bin.zip | Download URL |
| `amq_broker_jvm_install` | true | Whether to install a Java JVM. |
| `amq_broker_jvm` | java-1.8.0-openjdk-devel | The Java JVM to install. |


Role Variables: Instance Variables
--------------

Variables controlling the creation of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_instance_name` | amq | The instance name |
| `amq_broker_instance_journal_type` | nio | The type of the journal (aio or nio) |
| `amq_broker_instance_create_force` | true | Whether to force instance creation |
| `amq_broker_instance_role` | amq | The role |
| `amq_broker_instance_user` | admin | The instance user |
| `amq_broker_instance_require_login` | true | Whether the instance requires login |
| `amq_broker_instance_password` | admin | The instance password |
| `amq_broker_instance_web_host` | 0.0.0.0 | The listen address for the web administration interface |
| `amq_broker_instance_rmi_host` | 0.0.0.0 | The listen address for the JMX RMI |
| `amq_broker_instance_create_options` | --force --require-login --password=admin --http-host {{ amq_broker_instance_web_host }} | Extra options for creating the instance |
| `amq_broker_instance_jmx_port` | 1099 | JMX port |
| `amq_broker_instance_create_java_options` | -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port={{ amq_broker_instance_jmx_port }} -Djava.rmi.server.hostname={{ ansible_default_ipv4.address }} -Dcom.sun.management.jmxremote.rmi.port={{ amq_broker_instance_jmx_port }} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false {{ }} | Java options to pass to the instance create command |
| `amq_broker_instance_queues` | null | A list of queues to create when creating the instance |


Role Variables: Configuration Variables
--------------

Variables controlling the configuration of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_instance_type` | default | Instance type (one of default, default-cluster or default-ha) |



Role Variables: Cluster Variables
--------------

Variables controlling cluster parameters (for amq_broker_instance_type = default-cluster or default-ha)

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_cluster_broadcast_group_name` | my-broadcast-group | Cluster broadcast address |
| `amq_broker_cluster_broadcast_group_address` | 231.7.7.7 | Cluster group address |
| `amq_broker_cluster_broadcast_group_port` | 9876 | Cluster group port |
| `amq_broker_cluster_discovery_group_name` | my-discovery-group | Cluster discovery group |
| `amq_broker_cluster_netty_connector_port` | 61617 | Cluster discovery group |
| `amq_broker_cluster_name` | my-cluster | Cluster name |
| `amq_broker_cluster_username` | ACTIVEMQ.CLUSTER.ADMIN.USER | Cluster username |
| `amq_broker_cluster_password` | redhat | Cluster password |


Dependencies
------------

A Java JVM must be present in the system if `amq_broker_jvm_install` is false.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

	- hosts: all
		remote_user: root
		vars:
			amq_broker_download_url: http://host/path/to/amq/jboss-amq-7.0.0.redhat-1-bin.zip
			amq_broker_download_dest: /tmp
			amq_broker_install_dest: /home/{{ amq_broker_user }}
			amq_broker_user: jamq
			amq_broker_install_link: jboss-amq-7
			amq_broker_jvm: java-1.8.0-openjdk-devel
			amq_broker_jvm_install: true
			amq_broker_instance_dir: jboss-amq-7-i0
			amq_broker_instance_jmx_port: 1099
		roles:
			- amq-broker


Testing
-------

1. Export a test inventory, otherwise it will run on localhost:

`export TEST_INVENTORY=/home/opiske/code/infra/test-inventory-ansible/hosts`

2. Adjust the download URL location accordingly. The default URL points to a non-existent host which renders the test invalid.

3. Run:
`make test`

License
-------

Apache 2.0

Author Information
------------------

Messaging QE team @ redhat.com
