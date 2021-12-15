#!/bin/bash
#Script to get current task definition, and based on that add new ecr image address to old template and remove attributes that are not needed, then we send new task definition, get new revision number from output and update service
AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID
AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
IMAGE_REPO_NAME=$BRANCH_NAME
TASK_FAMILY=$BRANCH_NAME

ENV="$( cut -d '-' -f 1 <<< "$BRANCH_NAME" )"
ECS_CLUSTER=$ENV'-cluster'

#echo "ECS_CLUSTER>>"$ECS_CLUSTER

SERVICE_NAME=$BRANCH_NAME
#exit 1

#filter based on family name
SERVICE_EXISTS = $(aws ecs describe-services --services "$SERVICE_NAME" --cluster "$ECS_CLUSTER")


if [ -f "$SERVICE_EXISTS" ]; then
    echo "$SERVICE_EXISTS already exists."
    set -e
else
        set -e
        ECR_IMAGE="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:latest"

        TASK_DEFINITION=$(aws ecs describe-task-definition --task-definition "$TASK_FAMILY" --region "$AWS_DEFAULT_REGION")
        NEW_TASK_DEFINTIION=$(echo $TASK_DEFINITION | jq --arg IMAGE "$ECR_IMAGE" '.taskDefinition | .containerDefinitions[0].image = $IMAGE | del(.taskDefinitionArn) | del(.revision) | del(.status) | del(.requiresAttributes) | del(.compatibilities)')
        NEW_TASK_INFO=$(aws ecs register-task-definition --region "$AWS_DEFAULT_REGION" --cli-input-json "$NEW_TASK_DEFINTIION")
        for task in $(aws ecs list-tasks --cluster ${ECS_CLUSTER} --family ${TASK_FAMILY} | jq -r '.taskArns[]'); do
            aws ecs stop-task --cluster ${ECS_CLUSTER} --task ${task};
        done
        NEW_REVISION=$(echo $NEW_TASK_INFO | jq '.taskDefinition.revision')
        aws ecs update-service --cluster ${ECS_CLUSTER} \
                            --service ${SERVICE_NAME} \
                            --task-definition ${TASK_FAMILY}:${NEW_REVISION} \
                            --desired-count 2 \
                            --force-new-deployment
        sleep 50
fi

