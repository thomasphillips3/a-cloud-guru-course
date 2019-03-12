# Lecture 42: EC2 Instance Metadata

## Objective
Learn how to gather metadata about EC2 instances. 

## Steps
While logged into the EC2 instance, running `curl http://169.254.169.254/latest/meta-data` retrieves a list of attributes about it.

```
# curl http://169.254.169.254/latest/meta-data/
ami-id
ami-launch-index
ami-manifest-path
block-device-mapping/
events/
hostname
iam/
identity-credentials/
instance-action
instance-id
instance-type
local-hostname
local-ipv4
mac
metrics/
network/
placement/
profile
public-hostname
public-ipv4
public-keys/
reservation-id
security-groups
```
So, to save the public IP address to a file named `public-ipv4`, run ```curl http://169.254.169.254/latest/meta-data/public-ipv4 > public-ipv4```

## Thoughts
Remember the metadata link for the exam: `http://169.254.169.254/latest/meta-data`