#!/bin/bash

# howto: build jq image and run this script
# docker build -t jq .
# docker run -v ${PWD}/jsonenv.sh:/jsonenv.sh -v ${PWD}/jsonenv.json:/jsonenv.json --rm jq bash jsonenv.sh {$PREFIX} {$OUTPUTFILENAME}

# the basic idea is to use prefixed environment variables which have to follow certain conventions:
# * will be lowercased
# * underscores are replaced to dots (like json path) for nesting
# this creates a jq filter expression: https://jqplay.org/s/EHP-iWpiZO

ENV_PREFIX=$1
PATH_JSON=$2
PATH_TEMP=json_env.tmp

# hello world!
echo '> Parsing json';

# find all prefixed env vars
# https://unix.stackexchange.com/a/245994
prefixed_vars=($(compgen -v "${ENV_PREFIX}"))

# prepare jq vars
jq_filter_delimiter=" | "
jq_filters=()

for env_name in "${prefixed_vars[@]}"
do
    # replace prefix
    # https://stackoverflow.com/a/13210909/1146207
    path_name=$(echo "${env_name/${ENV_PREFIX}/}")

    # replace all underscores by dots
    # https://stackoverflow.com/a/13210909/1146207
    path_name=$(echo "${path_name//_/.}")

    # and lowercase all
    # https://stackoverflow.com/a/2264537/1146207
    # path_name=$(echo "${path_name}" | awk '{print tolower($0)}')

    # add double quotes to strings
    _env_type_check='^([+-]?[0-9]+([.][0-9]+)?)|true|false|null$'
    if ! [[ ${!env_name} =~ ${_env_type_check} ]];
        then env_value="\"${!env_name}\"";
        else env_value=${!env_name}
    fi

    # append to filter
    # https://stackoverflow.com/a/1951523/1146207
    jq_filters+=("${path_name} = ${env_value}")

    # debug output
    echo "${env_name} > ${path_name} = ${env_value}"
done

# join filters, remove delimiter up front
# https://gist.github.com/Integralist/30f5a0eb07f93c90c8ec7e223a040902
jq_filter=$(printf "${jq_filter_delimiter}%s" "${jq_filters[@]}")
jq_filter=${jq_filter:${#jq_filter_delimiter}}

# create a temp file
cp ${PATH_JSON} ${PATH_TEMP}

# replace single entry and store to temporary file
jq "${jq_filter}" ${PATH_JSON} > ${PATH_TEMP}

# copy back to source
cp ${PATH_TEMP} ${PATH_JSON}

# Delete temp file
rm $PATH_TEMP

echo '> Done'
