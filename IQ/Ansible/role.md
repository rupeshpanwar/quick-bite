ansible-galaxy init <role_name>


myrole/
├── tasks/
│   └── main.yml
├── templates/
├── files/
├── vars/
├── defaults/
├── meta/
└── README.md

tasks/main.yml: This is the main tasks file of the role. It contains the sequence of tasks that should be executed by the role.

templates/: This directory is used to store Jinja2 templates that can be used to generate configuration files dynamically.

files/: This directory is used to store static files that need to be copied to the target hosts.

vars/: This directory is used to store variables specific to the role. These variables can be accessed and used within the tasks of the role.

defaults/: This directory is used to store default variable values. These values can be overridden by users of the role.

meta/: This directory contains metadata about the role, such as dependencies on other roles.

README.md: This file provides documentation and instructions for using the role.