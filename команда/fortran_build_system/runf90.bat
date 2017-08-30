@echo off
REM =========================================================================================
REM
REM                ________  runf90_alt  _______
REM                                                                              8_29_2017
REM =========================================================================================
REM The purpose of this program is to compile and execute a fortran program.
REM
REM This batch program is called by the sublime text build system [fortran.sublime-build]
REM
REM Three variables are passed to this program:
REM  %1 == $file           [The full path to the current file, e.g., C:\Files\Chapter1.txt]
REM  %2 == $file_path      [The directory of the current file, e.g., C:\Files]
REM  %3 == $file_base_name [The name-only portion of the current file, e.g., Chapter1]
REM =========================================================================================

REM Delayed Expansion will cause variables within a batch file
REM 	to be expanded at execution time rather than at parse time.
REM 	[This does no seem to be necessary, i just always do it]
setlocal enabledelayedexpansion

REM Call the gfortran compiler
REM
REM 	>>>  -fopenmp flag activates the OpenMP extensions for c/c++/fortran
REM 	>>>  -o flag specifies output filename [otherwise it will be named 'a.exe']
REM 	>>>  %3 [$file_base_name] tells the gfortran compiler what basename
REM             to use for the output executable.
REM 	>>>  %1 [$file] tells the compiler the location and name of the .f90
REM             file to compile.
REM
gfortran -fopenmp -o %3 %1

REM Piece together the explicit path to the compiler's output executable.
REM
REM		>>>  %2 is the directory of the executable
REM 	>>>  %3 is the executable's name with no extension
REM 	>>>  The surrounding quotations eliminate quotes from the string 
REM 			being stored in 'exec'
REM
set "exec=%2\%3.exe"

REM Takes the variable 'exec' and removes all instances of quotes by
REM 	replacing them with nothing. EXAMPLE:
REM
REM 	var1:a=7    >>>   replaces all instances of 'a' with '7'
REM
REM Putting percent signs around the argument on the right forces expansion
REM 	of the string initally stored in 'exec' [after removing quotes]
REM The right side of the argument will parse to a string of the file path
REM 	of the executable, and that path string is stored in our variable 'exec'
REM
set exec=%exec:"=%

REM Run the executable file created by the gfortran compiler. SYNTAX:
REM 	>>> START "title" %executablepathstring%
REM
START "%3.exe" %exec%
REM start "%2" %exec%


REM Catches potential lost command pointer from falling out the bottom.
endlocal
set /p pausevar=
exit

REM ==============================================================================================
REM ==============================================================================================
REM Windows Command Line Instructions For Batch Programming:     https://ss64.com/nt/
REM ==============================================================================================
REM ==============================================================================================