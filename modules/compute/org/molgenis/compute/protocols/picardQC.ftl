#
# =====================================================
# $Id$
# $URL$
# $LastChangedDate$
# $LastChangedRevision$
# $LastChangedBy$
# =====================================================
#

<#include "macros.ftl"/>
<@begin/>
#MOLGENIS walltime=35:59:00 mem=4
#INPUTS 
#OUTPUTS
#EXEC
#FOREACH

inputs "${sortedbam}"
inputs "${indexfile}
outputs "${alignmentmetrics}"
outputs "${gcbiasmetrics}"
outputs "${gcbiasmetricspdf}"
outputs "${insertsizemetrics}"
outputs "${insertsizemetricspdf}"
outputs "${meanqualitybycycle}"
outputs "${meanqualitybycyclepdf}"
outputs "${qualityscoredistribution}"
outputs "${qualityscoredistributionpdf}"

${alignmentmetricsjar} \
I=${sortedbam} \
O=${alignmentmetrics} \
R=${indexfile} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir}

${gcbiasmetricsjar} \
R=${indexfile} \
I=${sortedbam} \
O=${gcbiasmetrics} \
CHART=${gcbiasmetricspdf} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir}

${insertsizemetricsjar} \
I=${sortedbam} \
O=${insertsizemetrics} \
H=${insertsizemetricspdf} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir}

${meanqualitybycyclejar} \
I=${sortedbam} \
O=${meanqualitybycycle} \
CHART=${meanqualitybycyclepdf} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir}

${qualityscoredistributionjar} \
I=${sortedbam}
O=${qualityscoredistribution} \
CHART=${qualityscoredistributionpdf} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir}

${hsmetricsjar} \
INPUT=${sortedbam} \
OUTPUT=${hsmetrics} \
BAIT_INTERVALS=${baitintervals} \
TARGET_INTERVALS=${targetintervals} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir}

${bamindexstatsjar} \
INPUT=${sortedbam} \
VALIDATION_STRINGENCY=LENIENT \
TMP_DIR=${tempdir} \
> ${bamindexstats}
<@end />