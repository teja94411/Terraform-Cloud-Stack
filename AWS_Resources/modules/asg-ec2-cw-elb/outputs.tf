output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "elb_name" {
  value = aws_lb.web_lb.id
}

output "web_server_template_id" {
  value = aws_launch_template.web_server_template.id
}

output "cloudwatch_high_cpu_alarm" {
  value = aws_cloudwatch_metric_alarm.asg_high.id
}

output "cloudwatch_high_elb_alarm" {
  value = aws_cloudwatch_metric_alarm.elb_high.id
}
