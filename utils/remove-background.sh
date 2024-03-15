ORIGINAL=${1}
NEW=${2}

convert ${ORIGINAL} -fuzz 10% -transparent white ${NEW} 