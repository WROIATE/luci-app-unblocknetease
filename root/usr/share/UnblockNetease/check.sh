#!/bin/sh
set -x
APP_NAME="UnblockNetease"
LOG_MAX_SIZE="128"
LOG_PATH="/tmp/log/${APP_NAME}"
APP_LOG_FILE="${LOG_PATH}/app.log"
UNLOCK_LOG_FILE="${LOG_PATH}/unlock.log"
DAEMON_PROC="$(uci get ${APP_NAME}.@${APP_NAME}[0].daemon_proc)"
BIN_FILE="UnblockNeteaseGo"

[ "$DAEMON_PROC" != "1" ] && return

LOG_SIZE=$(expr $(ls -l "${APP_LOG_FILE}" | awk -F ' ' '{print $5}') / 1024)
[ "${LOG_SIZE}" -ge "${LOG_MAX_SIZE}" ] && echo -n "" >"${APP_LOG_FILE}"

LOG_SIZE=$(expr $(ls -l "${UNLOCK_LOG_FILE}" | awk -F ' ' '{print $5}') / 1024)
[ "${LOG_SIZE}" -ge "${LOG_MAX_SIZE}" ] && echo -n "" >"${UNLOCK_LOG_FILE}" 

if [ -z "$(ps | grep "${BIN_FILE}" | grep -v "grep")" ]; then
    echo "$(date -R) try restart..." >>"${UNLOCK_LOG_FILE}"
    /etc/init.d/${APP_NAME} restart
fi
