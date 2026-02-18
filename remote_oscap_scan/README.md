Remote OpenSCAP CIS Automation with Ansible  
A fully automated, end‑to‑end OpenSCAP CIS scanning workflow for RHEL‑based systems.  

This project provides a production‑ready Ansible role and playbook that remotely installs OpenSCAP, selects the correct SCAP Security Guide content based on OS version, runs CIS benchmark scans, and fetches the results back to the control node in a clean, timestamped directory structure.  

It’s designed for real‑world DevSecOps, compliance, and security automation environments — and built to work across RHEL 8, 9, and 10.  

Why This Project Exists  
Security compliance is a critical requirement in enterprise Linux environments. Running CIS scans manually is slow, error‑prone, and difficult to scale. This automation solves that by providing:  

A repeatable and idempotent scanning workflow  

Automatic package installation (OpenSCAP + SSG)  

Automatic benchmark selection based on OS version  

Clean report collection on the controller  

Support for RHEL 8, 9, and 10  

A structure that’s easy to extend (STIG, PCI, remediation, S3 uploads, etc.)  

This is the kind of automation used by real Red Hat support engineers, security teams, and compliance auditors.  

-----------------------------------------

🧩 Features  
✔ Automatic OpenSCAP installation  
Installs openscap-scanner and scap-security-guide using a DNF CLI fallback for RHEL 10 compatibility.  

✔ OS‑aware benchmark selection  
Automatically maps the correct SCAP datastream file:  

OS Version	Benchmark File  
RHEL 8	ssg-rhel8-ds.xml  
RHEL 9	ssg-rhel9-ds.xml  
RHEL 10	ssg-rhel10-ds.xml  

✔ CIS profile scanning  
Runs the CIS profile using:  

xccdf_org.ssgproject.content_profile_cis  

✔ Handles OpenSCAP exit codes correctly  
Exit code 2 (findings detected) is treated as a successful scan, not a failure.  

✔ Fetches reports to the controller  
Results are stored under:  

/var/reports/oscap/<hostname>/<timestamp>/  

✔ Clean, timestamped output  
Each scan is isolated and easy to audit.  

-----------------------------------------

📁 Repository Structure  
Code  
playbooks/  
└── remote_oscap_scan/  
    ├── cis_oscap_scan.yml  
    └── roles/  
        └── oscap_scan/  
            ├── tasks/  
            │   ├── main.yml  
            │   ├── install.yml  
            │   ├── scan.yml  
            │   └── fetch.yml  
            ├── vars/  
            │   └── main.yml  
            └── defaults/  

----------------------------------------
▶️ How to Run the Scan  
Run the playbook against a host or group:  


ansible-playbook playbooks/remote_oscap_scan/cis_oscap_scan.yml --limit rhel  


Or target a single host:  


ansible-playbook playbooks/remote_oscap_scan/cis_oscap_scan.yml --limit 10.0.1.55  

----------------------------------------

📄 Example Output  
At the end of the run, Ansible displays:  


OpenSCAP scan results saved to:  
/var/reports/oscap/10.0.1.55/2026-02-18_22-40-02/  

XML:  results-2026-02-18_22-40-02.xml  
HTML: report-2026-02-18_22-40-02.html  

You can open the HTML report in any browser to review CIS compliance findings.  
