#!/bin/sh
before_diff_bytes=`git diff | wc -c`
diff_files=(`git diff --name-only HEAD ./`)

for diff_file in "${diff_files[@]}"
do
    if [[ $diff_file =~ \.go$ ]]; then
        gofmt -w $diff_file
    fi
done

after_diff_bytes=`git diff | wc -c`

diff_bytes=`expr $after_diff_bytes \- $before_diff_bytes`
if [[ $diff_bytes > 0 ]] ; then
    echo "\033[0;31m Check golang code format! \033[0;39m"
    exit 1
fi

