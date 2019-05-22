Role Name
=========

A JBoss AMQ 7 Broker deployment role.

Requirements
------------

None.

Build/Test Status
------------

Linux Build Status: [![Linux Build Status](https://api.travis-ci.org/msgqe/ansible-amq-broker.svg?branch=master)](https://travis-ci.org/msgqe/ansible-amq-broker)

Role Variables: Basic Variables
--------------

Variables controlling what will be executed by the role.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_skip_install` | false | Whether to skip installation process. |
| `amq_broker_skip_create` | false | Whether to skip instance creation process. |
| `amq_broker_skip_configure` | true | Whether to skip instance configure process. |
| `amq_broker_start_server` | true | Whether to start broker instance. |
| `amq_broker_service_start` | true | Whether to start/operate broker as service. (preferred way) |
| `amq_broker_force_kill` | false | Whether to allow kill broker or not. |
| `amq_broker_kill_all` | false | Whether to allow kill all broker processes via root or not. |
| `amq_broker_skip_iptables` | false | Whether to skip setting firewall for broker. |
| `amq_broker_perform_teardown` | false | Whether to perform tear down actions or not (close ports, clean environment, etc). |
| `amq_broker_write_amq_facts` | false | Whether to dump system facts to a file (used to integrate this role in some test automation tools). |

**Note**: amq_broker_write_amq_facts is disabled by default because it's broken. It's part of a larger requirement that is still in development.
Users are advised to not use it at the moment.

Role Variables: Installation Variables
--------------

Variables controlling broker installation parameters.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_download_dest` | `/tmp` | Download destination |
| `amq_broker_install_dest` | `/home/{{ amq_broker_user }}` | Install destination |
| `amq_broker_user` | jamq | System user to create for running JBoss AMQ 7 Broker |
| `amq_broker_user_uid` | 5672 | System user uid to create for running JBoss AMQ 7 Broker |
| `amq_broker_install_link` | jboss-amq-7 | Friendly link name for the installation dir |
| `amq_broker_custom_install_link` | `/opt/jboss-amq-7` | Optional custom link to the used broker. |
| `amq_broker_download_url` | Upstream Apache Artemis 2+ | Download URL exported as environment variable AMQ_BROKER_DOWNLOAD_URL. If not defined, it uses Apache Artemis (upstream version)  (must be a zip file) |
| `amq_broker_db_driver_url` | undefined | Download JDBC DB driver if environment variable AMQ_BROKER_DB_DRIVER_DOWNLOAD_URL is provided. |
| `amq_broker_jvm_manage` | true | Whether to allow any management operations in regards to JVM/JDK. |
| `amq_broker_jvm_install` | true | Whether to install a Java JVM. |
| `amq_broker_jvm` | java-1.8.0-openjdk | The Java JVM to install. Use `JAVA_TYPE` env variable for custom java (`openjdk-java-11`). |
| `amq_broker_default_facts_file` | `/etc/ansible/facts.d/amq_broker.fact` | Generate broker related information to this file. |



Role Variables: Instance Variables
--------------

Variables controlling the creation of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_instance_name` | amq | The instance name |
| `amq_broker_instance_journal_type` | nio | The type of the journal (aio, nio or disabled) |
| `+amq_broker_instance_journal_nio_fsync` | false | Enable/disable usage of fdatasync (f/ NIO) |
| `amq_broker_instance_create_force` | true | Whether to force instance creation (this does not create fresh broker instance) |
| `amq_broker_instance_role` | amq | The role |
| `amq_broker_instance_user` | admin | The instance user |
| `amq_broker_instance_require_login` | true | Whether the instance requires login |
| `amq_broker_instance_password` | admin | The instance password |
| `amq_broker_instance_web_host` | 0.0.0.0 | The listen address for the web administration interface |
| `amq_broker_instance_rmi_host` | 0.0.0.0 | The listen address for the JMX RMI |
| `amq_broker_instance_broker_host` | undefined | The host address to use (used for clustering) |
| `amq_broker_instance_create_options` | --force --require-login --password=admin --http-host {{ amq_broker_instance_web_host }} | Extra options for creating the instance |
| `amq_broker_instance_jmx_port` | 1099 | JMX port |
| `amq_broker_instance_create_java_options` | -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port={{ amq_broker_instance_jmx_port }} -Djava.rmi.server.hostname={{ amq_broker_default_ipv4_address }} -Dcom.sun.management.jmxremote.rmi.port={{ amq_broker_instance_jmx_port }} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false {{ }} | Java options to pass to the instance create command |
| `amq_broker_instance_queues` | null | A list of queues to create when creating the instance |


Role Variables: Ports
--------------

Variables controlling which ports are used for the messaging services.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_default_port`  | 61616 | Default broker port |
| `amq_broker_default_amqp`  | 5672  | Default AMQP broker port |
| `amq_broker_default_stomp` | 61613 | Default STOMP broker port |
| `amq_broker_default_mqtt`  | 1883  | Default MQTT broker port |
| `amq_broker_default_core`  | 5445  | Default Core broker port |




Role Variables: Jolokia
--------------

Variables controlling the configuration of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_jolokia_allow_origin` | *://0.0.0.0* | Cross-origin access settings for the management console |

Role Variables: Configuration Variables
--------------

Variables controlling the configuration of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_instance_type` | default | Instance type (one of default, default-cluster, default-ha or jgroups-cluster) |


Role Variables: Configuration of GSSAPI
--------------

Variables controlling the configuration of a broker instance.

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_gssapi_enabled` | false | Whether GSSAPI/Kerberos configuration is enabled or not |
| `amq_broker_gssapi_sasl_login_config_scope` | msgqekerb | JAAS login config scope name |
| `amq_broker_gssapi_broker_principal` | `amqp/<hostname_fqdn>` | GSSAPI Principal name of broker |
| `amq_broker_gssapi_broker_keytab_path` | None | Path to file or directory for principal keytab use env `AMQ_GSSAPI_KEYTABS_PATH` (if folder, `<hostname --short>.keytab` is assumed |
| `amq_broker_gssapi_conf_file_path` | None | Path to `krb5.conf` file for used GSSAPI realm; use env `AMQ_GSSAPI_KRB_CONF_PATH` |


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
| `amq_broker_cluster_balancing` | ON_DEMAND | Load balancing type (OFF, ON_DEMAND, STRICT) |
| `amq_broker_cluster_broadcast_period` | 2000 | Broadcast interval in milliseconds |
| `amq_broker_cluster_max_hops` | 1 | Cluster max hopes (use for CHAIN or SYMETRIC clustering) |
| `amq_broker_cluster_replicated` | false | Set cluster to Replication mode |
| `amq_broker_cluster_sharedstore` | false | Set cluster to Shared store mode |
| `amq_broker_shared_store_dir` | None | Set root directory of shared store |

Supported Inventory: Host Variables
------------

Variables which are defined in inventory file specific for given host

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `amq_broker_external_address` | Not used by default | Useful if broker is running on internal network, but is VM is accessed from outside of this network |


Dependencies
------------

* A Java JVM must be present in the system if `amq_broker_jvm_install` is false.
* For RHEL/CentOS 6 due to dependency of `ansible-xml` module, you have to install following packages
```yum install -y libxml2-devel libxslt-devel``` and upgrade python-lxml, because we need at least 2.5.0+: ```pip install --upgrade lxml``` This works even for deprecated python 2.6.



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
			- ansible-amq-broker


Testing
----------------

To test this role you need docker. If your system has docker, this role can be tested using the following command:

```make test```

**Note**: you need to install python2-docker for the test to run.

License
-------

Apache 2.0

Author Information
------------------

Messaging QE team @ redhat.com
