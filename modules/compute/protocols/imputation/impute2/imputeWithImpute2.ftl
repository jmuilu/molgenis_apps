#MOLGENIS walltime=48:00:00 nodes=1 cores=1 mem=16

#INPUTS impute2ResultDir/${chr}/,referenceImpute2HapFile,referenceImpute2LegendFile,referenceImpute2MapFile,preparedStudyDir/chr${chr}.gen
#OUTPUTS impute2ResultChrBinTemp
#EXES impute2Bin
#LOGS log
#TARGETS project,studyInputPedMap,referencePanel,chr,fromChrPos,toChrPos

#FOREACH project,studyInputPedMap,referencePanel,chr,fromChrPos,toChrPos

inputs "${impute2ResultDir}/${chr}/"
inputs "${referenceImpute2HapFile}"
inputs "${referenceImpute2LegendFile}"
inputs "${referenceImpute2MapFile}"
inputs "${preparedStudyDir}/chr${chr}.gen"
alloutputsexist "${impute2ResultChrBinTemp}"

mkdir -p ${impute2ResultDir}/${chr}/
${impute2Bin} -h ${referenceImpute2HapFile} -l ${referenceImpute2LegendFile} -m ${referenceImpute2MapFile} -g ${preparedStudyDir}/chr${chr}.gen -int ${fromChrPos} ${toChrPos} -o ${impute2ResultChrBinTemp}


#Get return code from last program call
returnCode=$?

if [ $returnCode -eq 0 ]
then
	
	echo -e "\nMoving temp files to final files\n\n"

	for tempFile in ${impute2ResultDir}/${chr}/~chr_${chr}_from_${fromChrPos}_to_${toChrPos}* ; do
		finalFile=`echo $tempFile | sed -e "s/~//g"`
		mv $tempFile $finalFile
	done
	
else
  
	echo -e "\nNon zero return code not making files final. Existing temp files are kept for debuging purposes\n\n"
	#Return non zero return code
	exit 1

fi