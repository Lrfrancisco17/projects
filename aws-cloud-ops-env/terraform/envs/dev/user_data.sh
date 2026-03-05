#!/bin/bash
yum update -y
yum install -y python3 python3-pip git

# Create app directory
mkdir -p /opt/webapp
cd /opt/webapp

# Write Flask app
cat <<EOF > app.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def index():
    return "<h1>AWS Cloud Ops Demo App</h1><p>Deployed via Terraform + ASG</p>"

@app.route("/healthz")
def health():
    return "ok", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
EOF

# Write requirements
echo "flask==3.0.0" > requirements.txt

# Install dependencies
pip3 install --upgrade pip
pip3 install -r requirements.txt

# Fix permissions
chown -R ec2-user:ec2-user /opt/webapp

# Create systemd service
cat <<EOF > /etc/systemd/system/webapp.service
[Unit]
Description=Simple Flask Web App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/opt/webapp
ExecStart=/usr/bin/python3 /opt/webapp/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable webapp
systemctl start webapp

