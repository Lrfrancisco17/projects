# Monitoring modiule  

Overview  

Creates CloudWatch monitoring components for the environment, including dashboards and alarms. Sends alerts to an SNS topic.  

What it includes 
 
 * CloudWatch dashboard for ASG metrics  

 * High CPU alarm  

 * SNS integration for notifications  

Inputs  

 * asg_name  

 * sns_topic_arn  

 * region  

 * name  

Outputs  
 
 * dashboard_name

