#!/bin/bash

function print_points {
	TESTCASE=$*
	NUM=$((55 - ${#TESTCASE}))
	for i in $(seq $NUM)
	do
		echo -n .
	done
}

function printResult {
	pointsPerTest=${@: -1}
	if [ $testResult == FAILED ]
	then
		echo "$printTestName$(print_points $printTestName)FAILED"
	else
		echo "$printTestName$(print_points $printTestName)PASSED"
		points=$(echo "$points+$pointsPerTest"| bc -l)
	fi
}

function checkReturnCode {
	ret=$1
	if [ $ret == 124 ]
	then
		echo -e "\nERROR: Program took more than $maxRunTime seconds to execute"
		echo "ERROR: It is possible you have an infinte loop bug or recursive jump conditions"
		echo "Check the value provided in the CX register"
	elif [ $ret != 0 ]
	then
		echo -e "\nERROR: Program ended with non-zero return code $ret."
		echo "ERROR: Does your program return 0?"
	elif [ -s out/output ] &&  grep -qE 'Illegal\s+command' out/output
	then
		errorMessage=$(tail -n 1 out/output | cut -f1 -d:)
		echo -e "\nERROR: Program ended with following message: '$errorMessage'."
		echo "Check for illegal instructions, divide-by-zero, stack overflows or invalid memory access."
	fi
}

tests="test/test1.txt test/test2.txt test/test3.txt"
len=$(echo "$tests" | wc -w)
pointsForOneTest=$(echo "(90.0/${len})" | bc -l)
points=10
maxRunTime=25
for TEST in $tests
do
    testName=${TEST##*/}
    testNameWithoutExt=${testName%.*}
    currentIndex=${testNameWithoutExt: -1}
    testResult="FAILED"
    if [ $currentIndex -gt 1 ]
    then
        sed -i "s/in$((currentIndex - 1))/in${currentIndex}/g" open.asm
        sed -i "s/out$((currentIndex - 1))/out${currentIndex}/g" write.asm
    fi
    sudo /usr/bin/time --quiet -f "%e" timeout $maxRunTime dosbox -c "mount c: ." -c "c:" -c "tasm *.asm" -c "tlink homework open readLine close task write" -c "homework.exe > out/output" -c "exit" &> /dev/null
	ret=$?
    outputPath="out/out${currentIndex}.txt"
	checkReturnCode $ret
	if [ $ret != 0 ]
	then
		echo -e "\n"
    elif [ ! -e $outputPath ]
	then
		echo -e "\nERROR: Output file does not exist"
	else
		diff $TEST $outputPath &> /dev/null
		if [ $? != 0 ]
		then
			echo -e "\nERROR: Output files differ"
		else
			echo -e "\n"
			testResult="PASSED"
		fi
	fi
    printTestName="Checking outputs for $testNameWithoutExt"
	printResult $printTestName $pointsForOneTest
    rm -f ./out/*.TXT
	rm homework.MAP
	rm homework.EXE
	rm *.OBJ
done
echo "$(echo $points | cut -d '.' -f1)" >> ./out/output
echo "                                      Total  =  [ $(echo "scale=3; $points" | bc)/100.000 ]"
