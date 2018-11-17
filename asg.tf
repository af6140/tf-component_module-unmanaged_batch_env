resource "aws_launch_template" "ecs" {
  name_prefix= "${var.vpc_name}_${var.app_tier}_${var.service}_lt"

  disable_api_termination = false

  ebs_optimized = true


  iam_instance_profile {
    name = "${aws_iam_instance_profile.ecs_instance_profile.name}"
  }

  image_id = "${data.aws_ssm_parameter.aws_ecs_ami_id}"

  instance_initiated_shutdown_behavior = "stop"

  instance_type = "${var.instance_type}"


  key_name = "default_${var.app_iter}"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = "${var.associate_public_ip == "true" ? true : false }"
  }

  vpc_security_group_ids = [
     "${var.security_goup_ids}"
  ]

  tag_specifications {
    resource_type = "instance"

    tags {
      app_tier = "${var.app_iter}"
      service = "${var.service}"
      role = "batch"
    }
  }

  user_data = "${base64encode(data.template_file.userdata.rendered)}"
}
resource "aws_autoscaling_group" "ecs_cluster" {
  name                      = "${var.vpc_name}_${var.app_tier}_${var.service}_batch"
  max_size                  = "${var.asg_size}"
  min_size                  = "${var.asg_size}"
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = "${var.asg_size}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.foobar.name}"

  tag {
    key                 = "app_tier"
    value               = "${var.app_tier}"
    propagate_at_launch = true
  }

  tag {
    key                 = "service"
    value               = "${var.service}"
    propagate_at_launch = true
  }

  tag {
    key                 = "role"
    value               = "batch"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

