
# Use below command to run script on remote target server. This will kill that application on target node.

aws ssm send-command \
  --document-name "AWS-RunShellScript" \
  --targets "Key=tag:Name,Values=dev-instance" \
  --parameters commands=["sudo /opt/chaos/kill_flask.sh"]

