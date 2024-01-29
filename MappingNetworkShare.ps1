###==================================================
### Mapping a network Drive 
###==================================================
### Date   : 15 January 2019
### Author : Chukwuemeka Evulukwu
### 
### Script Details:
### --------------
###  This will map the TCSSERVICEFOLDER to the computer
###       
###        
###           
###      
### 
###===========================================


#mapping Command
New-PSDRive -name "G" -PSProvider FileSystem -Root "\\tcses.org\files\software\TCSSERVICEFOLDER"