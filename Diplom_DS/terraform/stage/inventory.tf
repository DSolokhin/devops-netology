resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.

      [node01]
    nginx.${var.domain_name} ansible_host=${yandex_compute_instance.node01.network_interface[0].nat_ip_address}

    [node02]
    db01.${var.domain_name} ansible_host=${yandex_compute_instance.node02.network_interface[0].ip_address}

    [node03]
    db02.${var.domain_name} ansible_host=${yandex_compute_instance.node03.network_interface[0].ip_address}

    [node04]
    www.${var.domain_name} ansible_host=${yandex_compute_instance.node04.network_interface[0].ip_address}

    [node05]
    gitlab.${var.domain_name} ansible_host=${yandex_compute_instance.node05.network_interface[0].ip_address}

    [node06]
    runner.${var.domain_name} ansible_host=${yandex_compute_instance.node06.network_interface[0].ip_address}

    [node07]
    monitoring.${var.domain_name} ansible_host=${yandex_compute_instance.node07.network_interface[0].ip_address}


    [allhosts:children]
    node01
    node02
    node03
    node04
    node05
    node06
    node07

    [allhosts:vars]
    domain_name = "${var.domain_name}"
    ip_node01 = ${yandex_compute_instance.node01.network_interface.0.ip_address}
    ip_node02 = ${yandex_compute_instance.node02.network_interface.0.ip_address}
    ip_node03 = ${yandex_compute_instance.node03.network_interface.0.ip_address}
    ip_node04 = ${yandex_compute_instance.node04.network_interface.0.ip_address}
    ip_node05 = ${yandex_compute_instance.node05.network_interface.0.ip_address}
    ip_node06 = ${yandex_compute_instance.node06.network_interface.0.ip_address}
    ip_node07 = ${yandex_compute_instance.node07.network_interface.0.ip_address}

    [db:children]
    node02
    node03

    [db:vars]
    replication_passwd = "${var.replication_passwd}"

    [node01:vars]
    domain_name = "${var.domain_name}"

    [node02:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"'
    mysql_replication_role = "primary"

    [node03:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"'
    mysql_replication_role = "replica"

    [node04:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"'
    domain_name = "${var.domain_name}"

    [node05:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"'
    gitlab_passwd = "${var.gitlab_passwd}"
    gitlab_runner = "${var.gitlab_runner}"
    domain_name = "${var.domain_name}"

    [node06:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"'
    gitlab_runner = "${var.gitlab_runner}"
    domain_name = "${var.domain_name}"

    [node07:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"'
    grafana_passwd = "${var.grafana_passwd}"

    DOC
  filename = "../../ansible/inventory"

  depends_on = [
    yandex_compute_instance.node01,
    yandex_compute_instance.node02,
    yandex_compute_instance.node03,
    yandex_compute_instance.node04,
    yandex_compute_instance.node05,
    yandex_compute_instance.node06,
    yandex_compute_instance.node07
  ]
}


