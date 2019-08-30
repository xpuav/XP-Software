set -e

SCRIPT=$(readlink -f "$0")
SCRIPT_PATH=$(dirname "$SCRIPT")

SOURCE_PATH=${SCRIPT_PATH}/..

#check source path

if [ ! -d "${SOURCE_PATH}" ]; then
echo "invalid source path !!"
	exit 1
fi

#check arg

if [ $# = 0 ]; then
	echo "use like this : ./xp_cmake_helper.sh xp_fmu-v1 [cmake | clean] ]"
	exit 1
fi

#check board name

BOARD_NAME=$1
if [ ${BOARD_NAME} != "xp_fmu-v1" ] && [ ${BOARD_NAME} != "xp_fmu-v2" ]; then
	echo "invalid board name $1"
	exit 1
fi

#check cmd

CMD=""
if [ -z "$2" ] || [ "$2" = "cmake" ]; then
	CMD="cmake"
elif [ "$2" = "clean" ]; then
	CMD="clean"
else
	echo "invalid command $2"
	exit 1
fi

BOARD_CONFIG=nuttx_${BOARD_NAME}_default

BUILD_PATH=${SOURCE_PATH}/../build_${BOARD_NAME}

if [ ! -d "${BUILD_PATH}" ]; then
	mkdir ${BUILD_PATH}
fi

echo "cmake_helper : SOURCE_PATH = ${SOURCE_PATH}"
echo "cmake_helper : BUILD_PATH = ${BUILD_PATH}"

cd ${BUILD_PATH}
rm * -rf

echo "cmake_helper : board name ${BOARD_NAME}"
echo "cmake_helper : command ${CMD}"

if [ ${CMD} != "clean" ]; then
	echo "cmake_helper : remove all cmake temp files"
	echo "cmake_helper : cmake start..."
	cmake -DCONFIG=${BOARD_CONFIG} ${SOURCE_PATH}
fi


