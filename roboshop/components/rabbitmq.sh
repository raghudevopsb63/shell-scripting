#!/bin/bash

source components/common.sh

Print "Configure YUM Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${LOG_FILE}
StatCheck $?

Print "Install ErLang & RabbitMQ"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>${LOG_FILE}
StatCheck $?


Print "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>${LOG_FILE} && systemctl start rabbitmq-server &>>${LOG_FILE}
StatCheck $?

Print "Create Application User"
rabbitmqctl add_user roboshop roboshop123 &>>${LOG_FILE}
StatCheck $?

# rabbitmqctl set_user_tags roboshop administrator
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
```

Ref link : [https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management](https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management)