#!/bin/bash
cat <<'EOF' >> /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
ECS_CONTAINER_INSTANCE_PROPAGATE_TAGS_FROM=ec2_instance
#ECS_ENGINE_AUTH_DATA=docker: {"https://index.docker.io/v1/":{"username":"my_name","password":"my_password","email":"email@example.com"}}
EOF