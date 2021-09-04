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

PLATFORM_BUILD_PATH_FILE=${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/build_path
if [ -e $PLATFORM_BUILD_PATH_FILE ]; then
    . $PLATFORM_BUILD_PATH_FILE
    if [ -n "$TUYA_SDK_TOOLCHAIN_ZIP" ];then
        if [ ! -f ${ROOT_DIR}/platforms/${TARGET_PLATFORM}/toolchain/${TUYA_SDK_BUILD_PATH}gcc ]; then
            echo "unzip file $TUYA_SDK_TOOLCHAIN_ZIP"
            tar -xf ${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/$TUYA_SDK_TOOLCHAIN_ZIP -C ${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/
            echo "unzip finish"
        fi
    fi
else
    echo "$PLATFORM_BUILD_PATH_FILE not found in platform[$TARGET_PLATFORM]!"
fi

if [ -z "$TUYA_SDK_BUILD_PATH" ]; then
    COMPILE_PREX=
else
    COMPILE_PREX=${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/$TUYA_SDK_BUILD_PATH
fi

cd $APP_PATH
if [ -f build.sh ]; then
    sh ./build.sh $APP_NAME $APP_VERSION $TARGET_PLATFORM $USER_CMD
elif [ -f Makefile -o -f makefile ]; then
    export COMPILE_PREX TARGET_PLATFORM
    make APP_BIN_NAME=$APP_NAME USER_SW_VER=$APP_VERSION all
elif [ -f ${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/$TUYA_APPS_BUILD_PATH/$TUYA_APPS_BUILD_CMD ]; then
    cd ${ROOT_DIR}/platforms/$TARGET_PLATFORM/toolchain/$TUYA_APPS_BUILD_PATH
    sh $TUYA_APPS_BUILD_CMD $APP_NAME $APP_VERSION $TARGET_PLATFORM $USER_CMD
else
    echo "No Build Command!"
    exit 1
fi

