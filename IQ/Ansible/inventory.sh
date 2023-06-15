#!/usr/bin/env python3
import boto3

# Fetch EC2 instances from AWS
ec2 = boto3.resource('ec2')
instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

# Generate inventory
inventory = {
    'web': [],
    'database': []
}

for instance in instances:
    if 'web' in instance.tags:
        inventory['web'].append(instance.public_ip_address)
    elif 'database' in instance.tags:
        inventory['database'].append(instance.public_ip_address)

print(json.dumps(inventory))
