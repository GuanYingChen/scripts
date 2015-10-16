#!/bin/bash
#
# Bash script to check RPM Headers consistency
# in a given RPM folder.
# Author: luismartingil
# Year: 2015
#

RPM_FOLDER_PATH=/rpms
NOT_STRING=third-party

check_rpm_header_consistency () {
    RPM_HEADER=$1
    echo 'Checking consistency for "'$RPM_HEADER'" rpm header...'
    ret=`find $RPM_FOLDER_PATH -not -path "*$NOT_STRING*" -type f -name '*.rpm' -exec rpm -qp --qf "%{$RPM_HEADER}\n" {} \; 2> /dev/null | sort -n | uniq | wc -l`;
    if [ "$ret" -gt 1 ]; then
	echo 'Failed. Found "'$ret'" different values.'
    else
	echo 'Success.'
    fi
}

for i in packager url license group vendor; do
    check_rpm_header_consistency $i
done
