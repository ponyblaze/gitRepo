REM  %1 == $file
REM  %2 == $file_path
REM  %3 == $file_base_name

REM need to tell the parser[or w/e] to treat variables as variables
setlocal enabledelayedexpansion

REM Call gfortran compiler
REM -fopenmp flag for openmp stuff i guess
REM -c flag does something important idk
gfortran -fopenmp -c %1

REM 
set "output=%2\%3.o"
set output=%output:"=%

REM
gfortran -fopenmp %output% -o %3
set "exec=%2\%3.exe"
set exec=%exec:"=%
start "%2" %exec%