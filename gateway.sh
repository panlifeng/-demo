#!/bin/bash
#创建全链路网关-立峰
function red_echo(){
        echo -e "\033[31;49;1m $1 \033[39;49;0m"
}

function yellow_echo(){
        echo -e "\E[1;33m $1 \E[1;33m"
}

function blue_echo(){
        echo -e "\033[34;49;1m $1 \033[39;49;0m"
}

usage(){
        blue_echo "Usage: $0 [OPTIONS]"
        blue_echo "-h --help  display help info ."
        blue_echo "bash $0 [start/stop/status]"
        exit 1
}
start(){
    nohup  java -jar easydemo-gateway.jar >> gateway.log 2>&1 &
}

restart(){
    blue_echo "程序状态:"
    status
    stop
    blue_echo "应用启动中..."
    start
    sleep 1
    status
}

stop(){
    pid=`ps axu | grep java | grep easydemo-gateway.jar | awk '{print $2}'`
    if [ -z $pid ];then
        echo "gateway app didn't start"
    else
        kill -9 $pid
    fi
}

status(){
    pid=`ps axu | grep java | grep easydemo-gateway.jar | awk '{print $2}'`
    if [ ! -z ${pid} ];then
        echo "gateway app's status is running...  pid is " $pid
    else
        echo "gateway app's status is stop."
    fi
}


case $1 in
        -h|--help)
        usage
        ;;
        start)
        blue_echo "启动应用状态..."
        start
        ;;
        restart)
        blue_echo "重启应用..."
        restart
        ;;
        stop)
        blue_echo "停止应用状态..."
        stop
        ;;
        status)
        blue_echo "查看应用状态..."
        status
        ;;
esac
