#/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id
data "aws_ssm_parameter" "aws_ecs_ami_id" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

#ecs_cluster_arn
data "template_file" "userdata" {
  template = "${file("${path.module}/userdata.sh")}"

  vars {
    cluster_name = "${element(split("/", aws_batch_compute_environment.unmanaged.ecs_cluster_arn), 1)}"
  }
}