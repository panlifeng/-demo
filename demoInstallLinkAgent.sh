#!/bin/bash
#安装demo——探针模式
source ./demoEnv.conf
install(){
# create table and pt_table
mysql -h${MYSQLURL} -P${PORT} -u${USERNAME} -p"${PASSWD}" < create_table.sql
if [ $? == 0 ];then
    echo "数据库创建成功."
fi
sleep 1
}

# replace application mysql connection
cd app/user
sed -i "s/192.*.\//${MYSQLURL}:${PORT}\//g" ./application.properties
sed -i "s/spring.datasource.username\=.*/spring.datasource.username\=${USERNAME}/g" ./application.properties
sed -i "s/spring.datasource.password\=.*/spring.datasource.password\=${PASSWD}/g" ./application.properties

# start applications
bash ./usercenterLinkAgent.sh restart
cd ../gateway && bash ./gatewayLinkAgent.sh restart

