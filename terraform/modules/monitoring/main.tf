# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/ec2/app-logs"
  retention_in_days = 7
}

# CPU Alarm for Web Server
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "web-server-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    InstanceId = var.web_instance_id
  }

  alarm_description = "Triggers if CPU > 70%"
}

resource "aws_cloudwatch_log_metric_filter" "failed_login" {
  name           = "failed-login-detection"
  log_group_name = aws_cloudwatch_log_group.app_logs.name

  pattern = "FAILED"

  metric_transformation {
    name      = "FailedLoginCount"
    namespace = "Security"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "failed_login_alarm" {
  alarm_name          = "failed-login-alert"
  metric_name         = "FailedLoginCount"
  namespace           = "Security"
  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 1
  threshold           = 2
  comparison_operator = "GreaterThanOrEqualToThreshold"

  alarm_actions = [aws_sns_topic.alerts.arn]

  alarm_description = "Alert on failed login attempts"
}
