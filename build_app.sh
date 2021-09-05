#!/bin/sh

APP_PATH=$1
APP_NAME=$2
APP_VERSION=$3
USER_CMD=$4


fatal() {
    echo -e "\033[0;31merror: $1\033[0m"
    exit 1
}


[ -z $APP_PATH ] && fatal "no app path!"
[ -z $APP_NAME ] && fatal "no app name!"
[ -z $APP_VERSION ] && fatal "no version!"


DEBUG_FLAG=`echo $APP_VERSION | sed -n 's,^[0-9]\+\.\([0-9]\+\)\.[0-9]\+\.*$,\1,p'`
if [ $((DEBUG_FLAG%2))=0 ]; then
    export APP_DEBUG=1
fi

cd `dirname $0`

TARGET_PLATFORM=bk7231t
ROOT_DIR=$(pwd)

. ${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/build_path

cd ${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/$TUYA_APPS_BUILD_PATH
sh $TUYA_APPS_BUILD_CMD $APP_NAME $APP_VERSION $USER_CMD

