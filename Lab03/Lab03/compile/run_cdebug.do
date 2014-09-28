#############################################################
# vsimsa environment configuration
set dsn $curdir
log $dsn/log/vsimsa.log
@echo
@echo #################### Starting C Code Debug Session ######################
cd $dsn/src
amap Lab03 $dsn/Lab03/Lab03.lib
set worklib Lab03
# simulation
asim -callbacks D_Latch_Test Beh 
run -all
#############################################################