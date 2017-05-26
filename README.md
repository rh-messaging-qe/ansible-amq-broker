Role Name
=========

An AMQ Broker deployment role.

Requirements
------------

None.

Role Variables: Basic Variables
--------------

Variables controlling what will be executed by the role.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `jamq7_skip_install` | false | Whether to skip installation process. |
| `jamq7_skip_create` | false | Whether to skip instance creation process. |
| `jamq7_skip_configure` | true | Whether to skip instance configure process. |


Role Variables: Installation Variables
--------------

Variables controlling broker installation parameters.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `jamq7_download_dest` | `/tmp` | Download destination |
| `jamq7_install_dest` | `/home/{{ jamq7_user }}` | Install destination |
| `jamq7_user` | jamq | System user to create for running JAMQ |
| `jamq7_install_link` | jboss-amq-7 | Friendly link name for the installation dir |
| `jamq7_download_url` | http://host/path/to/amq/jboss-amq-7.0.0.redhat-1-bin.zip | Download URL |
| `jamq7_broker_java_install` | true | Whether to install a Java JVM. |
| `jamq7_broker_java` | java-1.8.0-openjdk-devel | The Java JVM to install. |


Role Variables: Instance Variables
--------------

Variables controlling the creation of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `jamq7_instance_journal_type` | nio | The type of the journal (aio or nio) |
| `jamq7_instance_role` | amq | The role |
| `jamq7_instance_user` | admin | The instance user |
| `jamq7_instance_web_host` | 0.0.0.0 | |
| `jamq7_instance_create_options` | --force --require-login --password=admin --http-host {{ jamq7_instance_web_host }} | Extra options for creating the instance |
| `jamq7_instance_jmx_port` | 1099 | JMX port |
| `jamq7_instance_create_java_options` | -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port={{ jamq7_instance_jmx_port }} -Djava.rmi.server.hostname={{ ansible_default_ipv4.address }} -Dcom.sun.management.jmxremote.rmi.port={{ jamq7_instance_jmx_port }} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false  | Java options to pass to the instance create command |


Role Variables: Configuration Variables
--------------

Variables controlling the configuration of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `jamq7_instance_type` | default | Instance type (one of default, default-cluster or default-ha) |



Role Variables: Cluster Variables
--------------

Variables controlling cluster parameters (for jamq7_instance_type = default-cluster or default-ha)

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `jamq7_cluster_broadcast_group_name` | my-broadcast-group | Cluster broadcast address |
| `jamq7_cluster_broadcast_group_address` | 231.7.7.7 | Cluster group address |
| `jamq7_cluster_broadcast_group_port` | 9876 | Cluster group port |
| `jamq7_cluster_discovery_group_name` | my-discovery-group | Cluster discovery group |
| `jamq7_cluster_name` | my-cluster | Cluster name |
| `jamq7_cluster_username` | ACTIVEMQ.CLUSTER.ADMIN.USER | Cluster username |
| `jamq7_cluster_password` | redhat | Cluster password |


Dependencies
------------

A Java JVM must be present in the system if `jamq7_broker_java_install` is false.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

	- hosts: all
		remote_user: root
		vars:
			jamq7_download_url: http://host/path/to/amq/jboss-amq-7.0.0.redhat-1-bin.zip
			jamq7_download_dest: /tmp
			jamq7_install_dest: /home/{{ jamq7_user }}
			jamq7_user: jamq
			jamq7_install_link: jboss-amq-7
			jamq7_broker_java: java-1.8.0-openjdk-devel
			jamq7_broker_java_install: true
			jamq7_instance_dir: jboss-amq-7-i0
			jamq7_instance_jmx_port: 1099
		roles:
			- jamq-7-install


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
