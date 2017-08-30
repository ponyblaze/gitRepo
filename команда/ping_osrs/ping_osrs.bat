@ECHO off
 
SET worlds=1,2,5,6,7,10,11,12,13,14,15,17,19,20,21,22,23,24,27,28,31,32,33,34,36,38,39,40,41,42,43,46,47,48,51,52,53,54,55,56,57,58,59,60,61,62,65,66,67,68,69,70,73,74,87,88,89,90,91
 
FOR %%i IN (%worlds%) DO (
Echo | SET /p=World %%i
FOR /F "tokens=5" %%a IN ('Ping oldschool%%i.runescape.com -n 1 ^| FIND "time="') DO Echo %%a
)
PAUSE