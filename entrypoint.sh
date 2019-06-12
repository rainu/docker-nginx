#!/bin/sh

CONFIG_PREFIX="CFG_"

# CFG_N_FILE
# CFG_N_OWN
# CFG_N_MOD
# CFG_N_CONTENT_N

###
# Functions

processFiles(){
  for i in $(getFiles); do
    processFile ${i}
  done
}

#returns the indexes of files
getFiles() {
  env | grep -o "${CONFIG_PREFIX}[0-9]*_FILE" | grep -o "[0-9]*"
}

# $1: index
processFile(){
  DIR_PATH=$(dirname $(getEnvContent "${CONFIG_PREFIX}${1}_FILE"))
  FILE_PATH=$(getEnvContent "${CONFIG_PREFIX}${1}_FILE")

  if [[ ! -d "${DIR_PATH}" ]]; then
    mkdir -p "${DIR_PATH}"
  fi

  readContent ${1} > "${FILE_PATH}"

  MOD=$(getEnvContent "${CONFIG_PREFIX}${1}_MOD")
  if [[ "${MOD}" != "" ]]; then
    chmod "${MOD}" "${FILE_PATH}"
  fi

  OWNER=$(getEnvContent "${CONFIG_PREFIX}${1}_OWNER")
  if [[ "${OWNER}" != "" ]]; then
    chown "${OWNER}" "${FILE_PATH}"
  fi
}

# $1: index
# return: the concatenated content of each environment variables for the given index
readContent() {
  NUM_OF_LINES=$(env | grep "^${CONFIG_PREFIX}${1}_CONTENT" | wc -l)

  if [[ "${NUM_OF_LINES}" -ne "0" ]]; then
    UNTIL=$(expr ${NUM_OF_LINES} - 1)

    for i in $(seq 0 ${UNTIL}); do
      ENV_NAME=${CONFIG_PREFIX}${1}_CONTENT_${i}
      getEnvContent ${ENV_NAME}
    done
  fi
}

# $1: env name
# return: the content of the environment with the given name
getEnvContent() {
  ENV_NAME=${1}
  env | grep "^${ENV_NAME}=" | sed "s/^${ENV_NAME}=//"
}

###
# Main

processFiles

nginx -g "daemon off;"