[![Watch the video](https://github.com/Lrfrancisco17/projects/blob/main/thumnails/git_action_mini_vid_thumnail.png)](https://www.youtube.com/watch?v=P1uPepiLEgA)

🚀 Terraform CI Workflow with GitHub Actions
This project includes a production‑style Terraform Continuous Integration (CI) pipeline powered by GitHub Actions. The workflow automatically validates infrastructure changes, enforces formatting standards, and generates Terraform plans on every push—mirroring CloudOps and SRE best practices.

🔧 What the CI Pipeline Does
Every push to the repository triggers the following automated steps:

terraform fmt — Ensures consistent formatting across all Terraform files.

terraform validate — Performs static validation to catch syntax issues and configuration errors early.

terraform plan — Generates an execution plan to preview infrastructure changes before they are applied.

This workflow helps maintain a clean codebase, prevents configuration drift, and enforces the same guardrails used in enterprise cloud engineering environments.
