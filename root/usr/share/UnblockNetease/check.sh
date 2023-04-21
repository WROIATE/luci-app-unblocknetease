#!/bin/sh

APP_NAME="UnblockNetease"
LOG_MAX_SIZE="128"
LOG_PATH="/tmp/log/${APP_NAME}"
APP_LOG_FILE="${LOG_PATH}/app.log"
RETRY_LOG="${LOG_PATH}/retry.log"
UNLOCK_LOG_FILE="${LOG_PATH}/unlock.log"
DAEMON_PROC="$(uci get ${APP_NAME}.@${APP_NAME}[0].daemon_proc)"
BIN_FILE="UnblockNeteaseGo"
MAX_RETRY=5

[ "$DAEMON_PROC" != "1" ] && return
[ ! -d "$RETRY_LOG" ] && touch $RETRY_LOG
if [ "$(wc -l "${RETRY_LOG}" | awk '{print $1}')" -ge "${MAX_RETRY}" ]; then
    uci set ${APP_NAME}.@${APP_NAME}[0].daemon_proc=0
    uci commit ${APP_NAME}
fi

LOG_SIZE=$(expr $(ls -l "${APP_LOG_FILE}" | awk -F ' ' '{print $5}') / 1024)
[ "${LOG_SIZE}" -ge "${LOG_MAX_SIZE}" ] && echo -n "" >"${APP_LOG_FILE}"

LOG_SIZE=$(expr $(ls -l "${UNLOCK_LOG_FILE}" | awk -F ' ' '{print $5}') / 1024)
[ "${LOG_SIZE}" -ge "${LOG_MAX_SIZE}" ] && echo -n "" >"${UNLOCK_LOG_FILE}"

if [ -z "$(ps | grep "${BIN_FILE}" | grep -v "grep")" ]; then
    echo "$(date -R) try restart..." >>"${RETRY_LOG}"
    echo "$(date -R) try restart..." >>"${UNLOCK_LOG_FILE}"
    /etc/init.d/${APP_NAME} restart
else
    echo -n "" >"${RETRY_LOG}"
fi
