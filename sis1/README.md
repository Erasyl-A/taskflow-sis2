# SIS 1 — TaskFlow machine verification

This pack is a read-only evidence collector for the currently deployed TaskFlow WSL installation. It does **not** create two virtual machines, install packages, or alter the running SIS 2 / SIS 3 project.

## Run inside Ubuntu WSL

```bash
mkdir -p ~/taskflow-sis2/sis1
# Copy verify_machine.sh to ~/taskflow-sis2/sis1/
cd ~/taskflow-sis2
bash sis1/verify_machine.sh
```

The script writes `sis1/evidence/machine-check.txt` (intentionally excluded from Git) and prints command outputs for screenshots.

## Important distinction

* Current actual environment: one Ubuntu instance running under WSL on Windows 11.
* Proposed SIS 1 two-VM architecture: app-server and db-server. **Not yet verified as provisioned.**
* Do not submit the target architecture as screenshots of deployed virtual machines.

## GitHub

```bash
git add sis1/verify_machine.sh sis1/README.md sis1/.gitignore
git commit -m "Add SIS1 machine verification"
git push origin HEAD
```
