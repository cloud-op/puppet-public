#检查history.log和inotify.log日志文件大小，并根据条件做日志切割或清空处理

#! /bin/bash
set -o nounset
# 在当前目录下包含logrotate.d目录和logsize_check.sh
#.
#├── logrotate.d
#└── logsize_check.sh
#

cd $(dirname "$0") || exit
SOURCE_PATH=$(readlink "$0" || echo "")
[[ -z $SOURCE_PATH ]] || cd "$SOURCE_PATH" || exit

#LOG_DICT,LOGROTATE_DICT 是一个字典，对应日志和logrotate的配置文件
declare -A LOG_DICT LOGROTATE_DICT
readonly CWD=$(pwd)
readonly SERVICE_LIST=("inotify" "history")
readonly LOG_DICT=([inotify]="/var/log/inotify/inotify.log" [history]="/var/log/history.log")
readonly LOGROTATE_DICT=([inotify]="${CWD}/logrotate.d/inotify-monitor" [history]="${CWD}/logrotate.d/history")

# 如果日志文件大小超过上限40M，则直接清空
# 如果日志文件大小超过下限20M，则做日志切割
readonly LOGSIZE_LOW=20000
readonly LOGSIZE_HIGH=40000

readonly LOGSIZE_STATUS_OK=0
readonly LOGSIZE_STATUS_WARN=1
readonly LOGSIZE_STATUS_CRITICAL=2

readonly EXIT_STATUS_OK=0

# 检查日志大小，判断是否超过上下限
function log::sizecheck
{
    if [ -f "$1" ]; then
        local size=$(du -k "$1" | awk '{print $1}')
    else
        local size=-1
    fi

    if (( ${size} > ${LOGSIZE_HIGH} ));then
        return "${LOGSIZE_STATUS_CRITICAL}"
    elif (( ${size} > ${LOGSIZE_LOW} ));then
        return "${LOGSIZE_STATUS_WARN}"
    fi
    return "${LOGSIZE_STATUS_OK}" 
}

#使用logrotate 做日志切割，最多保留三个
function log::rotate
{
    local exit_status=$(/usr/sbin/logrotate -f $1 2>&1 1>/dev/null ; echo $?) 
    return "${exit_status}"
}

function main
{
    for service in "${SERVICE_LIST[@]}"
    do
        local logfile=${LOG_DICT[${service}]} 
        local rotate_conf=${LOGROTATE_DICT[${service}]} 
        local logsize_status=$(log::sizecheck ${logfile}; echo $?)
        if (( ${logsize_status} == ${LOGSIZE_STATUS_WARN} ));then
            log::rotate "${rotate_conf}" 
        elif (( ${logsize_status} == ${LOGSIZE_STATUS_CRITICAL} ));then
            > "${logfile}" 
        fi
    done 
}

main "$@"
