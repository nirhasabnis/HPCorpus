#/bin/bash

if [ $# -ne 2 ];
then  
  echo "Usage: $0 <input_directory_containing_c_code><output_log_file>"
  exit 0
fi

FILE_LIST=`mktemp`
TMP_DIR=`mktemp -d`
NUM_PROCS=56

OUTPUT_FILE=$2

find $1 -iname "*.c" > ${FILE_LIST}

function compile() {
  IN=$1
  OUT=$2
  
  `gcc -o /dev/null -c ${IN} 2> /dev/null`
  echo ${IN}:$? >> ${OUT}
}

export -f compile

if ! command -v parallel &> /dev/null
then
  echo "Install parallel"
  exit 0
else
  cat ${FILE_LIST} | parallel --eta --bar --progress \
    -I% -j ${NUM_PROCS} compile % ${TMP_DIR}/proc_{%}.log
fi

for i in `seq 1 $NUM_PROCS`;
do
    if [ -f ${TMP_DIR}/proc_${i}.log ]
    then
      cat ${TMP_DIR}/proc_${i}.log >> ${OUTPUT_FILE}
    fi
done

echo -n "Correctly compiled:"
grep -c ":0" ${OUTPUT_FILE}

echo -n "Total files:"
wc -l ${OUTPUT_FILE}

rm -rf ${TMP_DIR}
rm ${FILE_LIST}
