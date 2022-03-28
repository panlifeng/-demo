#!/bin/bash
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
    nohup  java -XX:+PrintGCTimeStamps -Xloggc:gc.log -jar easydemo-usercenter.jar >> usercenter.log 2>&1 &
}

stop(){
    pid=`ps axu | grep java | grep easydemo-usercenter.jar | awk '{print $2}'`
    if [ -z $pid ];then
        echo "usercenter app didn't start"
    else
        kill -9 $pid
    fi
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

status(){
    pid=`ps axu | grep java | grep easydemo-usercenter.jar | awk '{print $2}'`
    if [ ! -z ${pid} ];then
        echo "usercenter app's status is running...  pid is " $pid
    else
        echo "usercenter app's status is stop."
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
