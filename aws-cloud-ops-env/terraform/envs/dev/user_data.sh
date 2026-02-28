#!/bin/bash
yum update -y
yum install -y python3 git

# Create app directory
mkdir -p /opt/app
cd /opt/app

# Simple Flask app
cat <<EOF > app.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def index():
    return "Hello from the ASG app!"

@app.route("/healthz")
def health():
    return "OK"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
EOF

# Install Flask
pip3 install flask

# Create systemd service
cat <<EOF > /etc/systemd/system/app.service
[Unit]
Description=Simple Flask App
After=network.target

[Service]
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable app
systemctl start app

