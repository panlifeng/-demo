#!/bin/bash
#创建发压数据
NUM=1

userRegister(){
    echo "-----------------------------------------"
    curl --location --request POST 'http://192.168.59.7:28882/user-center/user/biz_data'
    echo
    curl --location --request POST 'http://192.168.59.7:28882/user-center/user/shadow_data'
    echo
    echo "开始发起流量......"
    #for i in `seq 1 "${NUM}"`;
    for i in `seq 10 11`;
    do
    curl --location --request POST 'http://192.168.59.7:28881/gateway/api/register' \
    --header 'Content-Type: application/json' \
    --data '{
    "mobile":"155581722'${i}'",
    "password":"123456",
    "nickName":"name-10000'${i}'",
    "email":"10000000'${i}'@qq.com",
    "birthDay":"2000-11-05",
    "provinceName":"浙江",
    "cityName":"杭州"
    }' > /dev/null  2>&1
    done

    echo "流量发完，统计结果"
    curl --location --request POST 'http://127.0.0.1:28882/user-center/user/biz_data'
    echo
    curl --location --request POST 'http://127.0.0.1:28882/user-center/user/shadow_data'
    echo
    echo "-----------------------------------------"
}

ptuserRegister(){
    echo "-----------------------------------------"
    curl --location --request POST 'http://127.0.0.1:28882/user-center/user/biz_data'
    echo
    curl --location --request POST 'http://127.0.0.1:28882/user-center/user/shadow_data'
    echo
    echo "开始发起流量......"
    #for i in `seq 1 "${NUM}"`;
    for i in `seq 10 12`;
    do
    curl --location --request POST 'http://127.0.0.1:28881/gateway/api/register' \
    --header 'Content-Type: application/json' -H 'User-Agent:PerfomanceTest' \
    --data '{
    "mobile":"155581722'${i}'",
    "password":"123456",
    "nickName":"name-10000'${i}'",
    "email":"10000000'${i}'@qq.com",
    "birthDay":"2000-11-05",
    "provinceName":"浙江",
    "cityName":"杭州"
    }' > /dev/null  2>&1
    done

    echo "流量发完，统计结果"
    curl --location --request POST 'http://127.0.0.1:28882/user-center/user/biz_data'
    echo
    curl --location --request POST 'http://127.0.0.1:28882/user-center/user/shadow_data'
    echo
    echo "-----------------------------------------"
}

while read -p"请输出1:发起业务流量；2:发起压测流量" input
do
    if [ "$input" == "1" ];then
    #1. 业务流量
        userRegister
    elif [ "$input" == "2" ];then
    #2. 压测流量
        ptuserRegister
    else
        echo "ERROR INPUT！ 请输出1:发起业务流量；2:发起压测流量"
    fi
done
