#!/usr/bin/env bash

set -e

if [[ ! -f "./.eslintrc.js" ]]; then
    echo "Cannot find .eslintrc.js file. Please make sure you run this script from the frontend directory."
    exit 1
fi

echo "Running eslint on all spec files."

RAW_FILES=$(yarn eslint-high-memory 'apps/create/**/*.spec.{ts,tsx}' --quiet --config=./.eslintrc.js | grep -o "^/.*\|\s*[0-9]*:[0-9]*\s*error.*")
FILES=$(echo "$RAW_FILES" | sed -E 's/^\s*[0-9]*:[0-9]*\s*error\s\s.*?\s\s//g')

CURRENT_FILE=''
CURRENT_LINTS=''

for LINE in $(echo "$FILES"); do
    if [[ $LINE == /* ]]; then
        if [[ ! -z "$CURRENT_FILE" ]] && [[ ! -z "$CURRENT_LINTS" ]]; then
            UNIQUE_LINTS=$(echo "$CURRENT_LINTS" | uniq)

            for LINT in $(echo "$UNIQUE_LINTS"); do
                DISABLE_LINE="\/* eslint-disable $LINT *\/"

                if grep -q "$DISABLE_LINE" $CURRENT_FILE; then
                    echo "Skipping $LINT for $CURRENT_FILE"
                else
                    echo "Disabling $LINT in $CURRENT_FILE"
                    sed -i "1s;^;$DISABLE_LINE\n;" $CURRENT_FILE
                fi

            done

            CURRENT_FILE=''
            CURRENT_LINTS=''
        fi

        CURRENT_FILE=$LINE
    else
        ERROR=$(echo "$LINE" | sed 's/error: //g')
        CURRENT_LINTS=$(printf "$CURRENT_LINTS\n$ERROR")
    fi
done
