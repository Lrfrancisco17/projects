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

