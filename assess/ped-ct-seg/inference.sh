#!/bin/bash
export image_file=$1
export seg_folder=$2

export file_count=$(ls ${seg_folder}/*.nii.gz | wc -l)
if [ -d "${seg_folder}" ]; then
    if [ "${file_count}" -eq 104 ]; then
        echo "All 104 files found, skipping inference!"
        exit 0
    fi
fi

# inference
echo TotalSegmentator --fast -i ${image_file} -o ${seg_folder}
TotalSegmentator --fast -i ${image_file} -o ${seg_folder}
retVal=$?
if [ $retVal -ne 0 ]; then
    # avoid condor stopping the entire dag
    echo "Error!!!!!!"
    exit 0
fi
exit $retVal
