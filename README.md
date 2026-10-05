# TaskFlow SIS #2 — Users and Permissions

## Topic

Users and Permissions

## Target

Define a role table and prepare automation of the setup.

## Project

TaskFlow is a simple web application environment used to demonstrate Linux users, groups, permissions, SSH authentication, sudoers configuration and systemd service management.

## Role Table

| Role | Description | Permissions | Superuser permissions |
|---|---|---|---|
| administrator | System administrator | Manage system, users, files, services and software | Full sudo |
| developer | TaskFlow developer | Read and modify application files, check application status | Restart and check TaskFlow service |
| auditor | Security/audit user | Read logs and check service status | journalctl and TaskFlow status |
| automation_bot | Automated deployment account | SSH access and application deployment | Restart and check TaskFlow without password |
| taskflow | TaskFlow service account | Run application and access application files | None |
| postgres | PostgreSQL service account | Access PostgreSQL processes and database files | None |
| www-data | Nginx service account | Read and serve frontend/static files | None |

## Users and Groups

Groups:

- taskflow-admin
- taskflow-dev
- taskflow-audit
- taskflow-automation

Users:

- administrator
- developer
- auditor
- automation_bot
- taskflow

Service accounts:

- taskflow
- postgres
- www-data

## File Permissions

Application directory:

```text
/opt/taskflow
owner: taskflow
group: taskflow-dev
permissions: 775

/etc/taskflow
owner: root
group: taskflow
permissions: 750

/var/log/taskflow
owner: taskflow
group: taskflow-audit
permissions: 750

/srv/taskflow/backups
owner: root
group: taskflow-admin
permissions: 750

SSH

OpenSSH Server is installed and enabled.

The automation_bot user authenticates using an ED25519 SSH key pair.

The private key is stored only on the client and is not included in this repository.

The public key is installed in:

/home/automation_bot/.ssh/authorized_keys
Sudoers

The developer role can restart and check the TaskFlow service.

The auditor role can read TaskFlow logs and check service status.

The automation_bot can restart and check TaskFlow without entering a password.

The configuration follows the Principle of Least Privilege.

Systemd Service

TaskFlow runs as a systemd service:

taskflow.service

The service runs as the taskflow service account and starts automatically after boot.

Useful commands:

systemctl status taskflow
systemctl restart taskflow
systemctl is-enabled taskflow
Automation

The full environment can be configured using:

sudo ./setup.sh

The setup script runs:

01_users_groups.sh
02_permissions.sh
03_sudoers.sh
04_ssh_setup.sh
05_systemd_setup.sh
Repository Structure
taskflow-sis2/
├── setup.sh
├── README.md
├── scripts/
│   ├── 01_users_groups.sh
│   ├── 02_permissions.sh
│   ├── 03_sudoers.sh
│   ├── 04_ssh_setup.sh
│   └── 05_systemd_setup.sh
├── service/
│   └── app.py
└── systemd/
    └── taskflow.service
Conclusion

In this work, a role-based permission model was created for TaskFlow. Human users, service accounts and automation users were separated. File permissions, sudo permissions, SSH key authentication and a systemd service were configured. All configuration steps were automated using Bash scripts.


