@echo off

:CheckMode

REM Valida la entrada de datos del primer parámetro.			

	set p1=%1

	if "%p1%" == "I" (goto :MENU)
	if "%p1%" == "C" (goto :COMMAND)
	if "%p1%" == "" ( 
		echo ERROR: Debe introducir algun parametro válido.
		echo Indique 'C' para iniciar desde el Modo Comando. 
		echo Indique 'I' para acceder al Menu Interactivo.
	)
	goto :Fin


:Clean

REM Limpia la pantalla al finalizar alguna de las opciones.			

	echo.
	pause
	cls


:MENU

REM Opción de menú interactivo. Toda la información será recogida por teclado.

	echo.
	echo ---------------------------------------------
	echo               MENU INTERACTIVO	   
	echo ---------------------------------------------
	echo    1. Crear Nuevo Usuario			   
	echo    2. Generar Informe de Procesos	   
	echo    3. Mover Ficheros		   
	echo    4. Replicar Estructura de Directorio   
	echo    5. Generar Fichero con Arbol Directorio		   
	echo    6. Mandar a Papelera		  
	echo    7. Ocultar Fichero bajo Clave			
	echo    0. Salir			
	echo ---------------------------------------------
	echo.
	
	set "op="
	set /p op="Introduzca la operacion que desea realizar: "

	if "%op%" == "1" goto :I1
	if "%op%" == "2" goto :I2
	if "%op%" == "3" goto :I3
	if "%op%" == "4" goto :I4
	if "%op%" == "5" goto :I5
	if "%op%" == "6" goto :I6
	if "%op%" == "7" goto :I7
	if "%op%" == "0" goto :Fin

	echo.
	echo ATENCION: Elija una opcion valida.
	goto :Clean

	:I1

	REM Crea un usuario, pidiendo usuario y contraseña por teclado.

		set "user="
		set "pass="

		:I1CkUser

		REM Valida la entrada de datos para el usuario.

			echo.
			set /p user="Nombre de usuario: "

			if "%user%" == "Q" (goto :Clean)
			if "%user%" == "" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I1CkPass)
			goto :I1

		:I1CkPass

		REM Valida la entrada de datos para la contraseña.

			echo.
			set /p pass="Clave: "

			if "%pass%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I1exe)
			goto :I1

		:I1exe
		
		REM Ejecuta el comando para crear un usuario.

			net user %user% %pass% /add

			echo.
			echo El usuario ha sido creado con exito.
			goto :Clean


	:I2

	REM Genera un fichero.csv con los procesos en ejecución + timestamp.

		tasklist /V /FI "STATUS eq running" /FO CSV > c:\Users\%USERNAME%\Desktop\tasklist%date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%-%Time:~3,2%-%Time:~6,2%.csv
		
		echo.
		echo Hecho! Puede encontrar su Informe de Procesos en c:\Users\%USERNAME%\Desktop\tasklist%date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%-%Time:~3,2%-%Time:~6,2%.csv
		goto :Clean


	:I3

	REM Mueve un fichero de un directorio origen a uno destino.

		set "src="
		set "dest="
		set "file="


		:I3CkSrc

		REM Valida la entrada de datos para el directorio origen.

			echo.
			set /p src="Directorio origen: "

			if "%src%" == "Q" (goto :Clean)
			if "%src%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I3ExSrc)
			goto :I3

		:I3ExSrc

		REM Comprueba la existencia del directorio origen.
	
			if not exist %src% (echo El directorio origen no existe. Introduzca 'Q' para volver al Menu.) else (goto :I3CkDest)
			goto :I3

		:I3CkDest

		REM Valida la entrada de datos para el directorio destino.
			
			echo.
			set /p dest="Directorio destino: "

			if "%dest%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I3ExDest)
			goto :I3

		:I3ExDest

		REM Comprueba la existencia del directorio destino.

			if not exist %dest% (echo El directorio destino no existe. Introduzca 'Q' para volver al Menu.) else (goto :I3CkFile)
			goto :I3

		:I3CkFile

		REM Valida la entrada de datos del fichero.

			echo.
			set /p file="Nombre del fichero: "

			if "%file%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I3ExFile)
			goto :I3

		:I3ExFile

		REM Comprueba la existencia del fichero.

			if not exist %src%\%file% (echo El archivo %file% no existe en el directorio indicado. Introduzca 'Q' para volver al Menu.) else (goto :I3exe)
			goto :I3
		
		:I3exe

		REM Ejecuta el comando para mover el fichero.

			move %src%\%file% %dest%

			echo.
			echo El fichero ha sido movido con exito.
			goto :Clean


	:I4

	REM Replica una estructura de directorios en otra ruta.

		set "src="
		set "dest="

		:I4CkSrc

		REM Valida la entrada de datos del directorio origen.

			echo.
			set /p src="Directorio origen: "

			if "%src%" == "Q" (goto :Clean)
			if "%src%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I4ExSrc)
			goto :I4

		:I4ExSrc

		REM Comprueba la existencia del directorio origen.
	
			if not exist %src% (echo El directorio origen no existe. Introduzca 'Q' para volver al Menu.) else (goto :I4CkDest)
			goto :I4

		:I4CkDest

		REM Valida la entrada de datos del directorio destino.
			
			echo.
			set /p dest="Directorio destino: "

			if "%dest%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I4ExDest)
			goto :I4

		:I4ExDest

		REM Comprueba la existencia del directorio destino.

			if not exist %dest% (echo El directorio destino no existe. Introduzca 'Q' para volver al Menu.) else (goto :I4exe)
			goto :I4
		
		:I4exe

		REM Ejecuta el comando para replicar el directorio.

			xcopy /E %src% %dest%

			echo.
			echo El directorio ha sido copiado con exito.
			goto :Clean


	:I5

	REM Genera un fichero.txt con la estructura de directorios en árbol contenida a partir de una ruta.

		set "dir="
		set "filename="
		set "indicator="

		:I5CkDir

		REM Valida la entrada de datos del directorio.

			echo.
			set /p dir="Ruta del directorio: "

			if "%dir%" == "Q" (goto :Clean)
			if "%dir%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I5ExDir)
			goto :I5

		:I5ExDir

		REM Comprueba la existencia del directorio.
	
			if not exist %dir% (echo El directorio especificado no existe. Introduzca 'Q' para volver al Menu.) else (goto :I5FileName)
			goto :I5

		:I5FileName

		REM Valida la entrada de datos del nombre del fichero.

			echo.
			set /p filename="Nombre del fichero.txt: "

			if "%filename%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I5CkInd)
			goto :I5
		
		:I5CkInd

		REM Expone los parámetros, verifica y ejecuta el modo seleccionado.

			echo.
			echo F - Con Ficheros
			echo S - Sin Ficheros

			echo.
			set /p indicator="Introduzca uno de los dos parametros: "

			if "%indicator%" == "F" (
				tree %dir% /F /A > C:\Users\%USERNAME%\Desktop\%filename%.txt
				echo.
				echo El archivo ha sido creado con exito. Puede encontrarlo en C:\Users\%USERNAME%\Desktop\%filename%.txt
				goto :Clean
			)
			if "%indicator%" == "S" (
				tree %dir% /A > C:\Users\%USERNAME%\Desktop\%filename%.txt
				echo.
				echo El archivo ha sido creado con exito. Puede encontrarlo en C:\Users\%USERNAME%\Desktop\%filename%.txt
				goto :Clean
			)
			echo Parametro no valido. Introduzca 'Q' para volver al Menu.
			goto :I5


	:I6

	REM Funciona como la papelera de Windows pero en verdad es un archivo tar.

		echo.
		echo V - Ver contenido		   
		echo B - Borrar archivo o directorio y hacer una copia en la papelera
		echo R - Restaurar archivo o directorio
		echo Q - Salir
		echo.

		:I6Options

			set "choice="
			set /p choice="Elija una de las opciones anteriores: "

			if "%choice%" == "V" goto :I6V
			if "%choice%" == "B" goto :I6B
			if "%choice%" == "R" goto :I6R
			if "%choice%" == "Q" goto :Clean

			echo ATENCION: Debe elegir un parametro valido, intentelo de nuevo.
			goto :I6Options

		:I6V

		REM Muestra el contenido de la papelera, si existe.

			if not exist c:\Users\%USERNAME%\papelera\papelera.tar (echo ATENCION: Primero debe borrar algun archivo.) else (tar -tf C:\Users\%USERNAME%\papelera\papelera.tar)
			goto :Clean
		
		:I6B

		REM Borra un archivo o directorio y hace una copia en la papelera.

			REM Comprueba la existencia del directorio papelera. Si no existe, lo crea.

			if not exist "C:\Users\%USERNAME%\papelera" (mkdir C:\Users\%USERNAME%\papelera)

			set "file="

			:I6BCkFile

			REM Valida la entrada de datos del archivo o directorio que se desea borrar.

				echo.
				set /p file="Ruta del archivo o directorio: "

				if "%file%" == "Q" (goto :I6)
				if "%file%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I6BExFile)
				goto :I6B

			:I6BExFile

			REM Comprueba la existencia del archivo o directorio que se desea borrar.
		
				if not exist %file% (echo El archivo o directorio especificado no existe. Introduzca 'Q' para volver al Menu.) else (goto :I6Bexe)
				goto :I6B
			
			:I6Bexe

			REM Manda el archivo o directorio a la papelera.tar. En caso de no existir la papelera, la crea. 

				if not exist c:\Users\%USERNAME%\papelera\papelera.tar (tar -cvf C:\Users\%USERNAME%\papelera\papelera.tar %file%) else (tar -rvf C:\Users\%USERNAME%\papelera\papelera.tar %file%)
				if exist %file%\ (rmdir /S /Q %file%) else (del /F %file%)

				echo.
				echo El archivo o fichero ha sido enviado a la papelera correctamente.
				goto :Clean
		
		:I6R

		REM Restaura un archivo o directorio de la papelera.

			set "file="

			:I6RCkFileTar

			REM Valida la entrada de datos del archivo o directorio que se desea extraer.

				echo.
				set /p file="Nombre del archivo o directorio: "

				if "%file%" == "Q" (goto :I6)
				if "%file%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I6Rexe)
				goto :I6R
			
			:I6Rexe

			REM Extrae el archivo o directorio de la papelera.tar.
				
				tar -xf C:\Users\%USERNAME%\papelera\papelera.tar %file%

				echo El archivo o fichero ha sido restaurado correctamente.
				goto :Clean
		
	:I7
	
	REM Oculta y revela ficheros o directorios ocultos protegidos bajo contraseña a través del uso de atributos.

		echo.
		echo B - Bloquear Fichero
		echo D - Desbloquear Fichero
		echo Q - Salir
		echo.

		:I7Options

			set "op="
			set /p op="Elija una de las opciones anteriores: "

			if "%op%" == "B" goto :I7B
			if "%op%" == "D" goto :I7D
			if "%op%" == "Q" goto :Clean

			echo ATENCION: Debe elegir una opcion valida, intentelo de nuevo.
			goto :I7Options

		:I7B

		REM Oculta un fichero o directorio.

			set "file="
			set "pass="

			:I7BCkFile

			REM Valida la entrada de datos del archivo o directorio que se desea ocultar.

				echo.
				set /p file="Ruta del fichero o directorio: "

				if "%file%" == "Q" (goto :I7)
				if "%file%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I7BExFile)
				goto :I7B

			:I7BExFile

			REM Comprueba la existencia del archivo o directorio que se desea ocultar.
		
				if not exist %file% (echo El fichero especificado no existe. Introduzca 'Q' para volver al Menu.) else (goto :I7Bexe)
				goto :I7B
			
			:I7Bexe

			REM Añade atributos que ocultan el archivo o directorio y plasma la acción en un fichero .txt para nada sospechoso.

				attrib +h +s %file%
				echo.
				echo El bloqueo se ha aplicado con exito. Su clave es '1ASIRA'.
				echo Has ocultado %~dp0%file% -- %date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%:%Time:~3,2%:%Time:~6,2% >> C:\Users\%USERNAME%\Desktop\listatotalmentenormal.txt
				goto :Clean

		:I7D

		REM Hace visible un fichero o directorio tras la introducción de una contraseña.

			set "file="
			set "pass="

			:I7DCkLockFile

			REM Valida la entrada de datos del archivo o directorio que se desea revelar.

				echo.
				set /p file="Ruta del archivo o fichero: "

				if "%file%" == "Q" (goto :I7)
				if "%file%"=="" (echo ATENCION: Este campo no puede quedar vacio. Introduzca 'Q' para volver al Menu.) else (goto :I7Dexe)
				goto :I7D

			:I7Dexe

			REM Quita los atributos que ocultan el archivo o directorio y plasma la acción en un fichero .txt para nada sospechoso.

				echo.
				set /p pass="Introduzca la clave correcta: "

				if NOT %pass%== 1ASIRA (goto :ClaveIncorrecta) else (
					attrib -h -s %file%
					echo.
					echo El desbloqueo se ha aplicado con exito.
					echo Has desbloqueado %~dp0%file% -- %date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%:%Time:~3,2%:%Time:~6,2% >> C:\Users\%USERNAME%\Desktop\listatotalmentenormal.txt
					goto :Clean
				)
			
			:ClaveIncorrecta

			REM Indica que la clave es incorrecta.

				echo.
				echo ERROR: Clave incorrecta.
				goto :I7


:COMMAND

REM La modalidad comando permite definir toda la acción en una única sentencia.

	set p2=%2

	if "%p2%" == "1" goto :C1
	if "%p2%" == "2" goto :C2
	if "%p2%" == "3" goto :C3
	if "%p2%" == "4" goto :C4
	if "%p2%" == "5" goto :C5
	if "%p2%" == "6" goto :C6
	if "%p2%" == "7" goto :C7
	if "%p2%" == "0" goto :Fin
	
	echo ATENCION: Introduzca un segundo parametro entre 0-7.
	goto :Fin


	:C1

	REM Crea un usuario, pidiendo usuario y contraseña en la propia línea de comando.

		set user=%3
		set pass=%4
		
		:C1User

		REM Valida la entrada de datos para el usuario.
		
			if "%user%" == "" (echo ATENCION: Debe introducir el nombre de usuario y la clave del nuevo usuario.) else (goto :C1Pass)
			goto :Fin

		:C1Pass

		REM Valida la entrada de datos para la contraseña.

			if "%pass%" == "" (echo ATENCION: Debe introducir la clave del nuevo usuario.) else (goto :C1exe)
			goto :Fin

		:C1exe

		REM Ejecuta el comando para crear un usuario.

			net user %3 %4 /add

			echo El usuario %3 se ha creado con exito. Recuerde que su clave es '%4'.
			goto :Fin


	:C2

	REM Genera un fichero.csv con los procesos en ejecución + timestamp.

		tasklist /V /FI "STATUS eq running" /FO CSV > C:\Users\%USERNAME%\Desktop\tasklist%date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%-%Time:~3,2%-%Time:~6,2%.csv
		
		echo Hecho! Puede encontrar su Informe de Procesos en C:\Users\%USERNAME%\Desktop\tasklist%date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%-%Time:~3,2%-%Time:~6,2%.csv
		goto :Fin


	:C3

	REM Mueve un fichero de un directorio origen a uno destino.

		set src=%3
		set dest=%4
		set file=%5

		:C3CkSrc

		REM Valida la entrada de datos para el directorio origen.

			if "%src%"=="" (echo ATENCION: Debe introducir el directorio origen, el directorio destino y el fichero que desea mover.) else (goto :C3ExSrc)
			goto :Fin

		:C3ExSrc

		REM Comprueba la existencia del directorio origen.
	
			if not exist %src% (echo ERROR: El directorio origen no existe.) else (goto :C3CkDest)
			goto :Fin

		:C3CkDest

		REM Valida la entrada de datos para el directorio destino.

			if "%dest%"=="" (echo ATENCION: Debe introducir el directorio destino y el fichero que desea mover.) else (goto :C3ExDest)
			goto :Fin

		:C3ExDest

		REM Comprueba la existencia del directorio destino.

			if not exist %dest% (echo ERROR: El directorio destino no existe.) else (goto :C3CkFile)
			goto :Fin

		:C3CkFile

		REM Valida la entrada de datos para el fichero.

			if "%file%"=="" (echo ATENCION: Debe introducir el nombre del fichero que desea mover.) else (goto :C3ExFile)
			goto :Fin

		:C3ExFile

		REM Comprueba la existencia del fichero.

			if not exist %src%\%file% (echo ERROR: El archivo %file% no existe en el directorio indicado.) else (goto :C3exe)
			goto :Fin
		
		:C3exe

		REM Ejecuta el comando para mover el fichero.

			move %3\%5 %4

			echo El fichero ha sido movido con exito.
			goto :Fin


	:C4

	REM Replica una estructura de directorios en otra ruta.

		set src=%3
		set dest=%4

		:C4CkSrc
		
		REM Valida la entrada de datos para el directorio origen.

			if "%src%"=="" (echo ATENCION: Debe introducir el directorio origen y el directorio destino.) else (goto :C4ExSrc)
			goto :Fin

		:C4ExSrc

		REM Comprueba la existencia del directorio origen.
	
			if not exist %src% (echo ERROR: El directorio origen no existe.) else (goto :C4CkDest)
			goto :Fin

		:C4CkDest

		REM Valida la entrada de datos para el directorio destino.

			if "%dest%"=="" (echo ATENCION: Debe introducir el directorio destino.) else (goto :C4ExDest)
			goto :Fin

		:C4ExDest

		REM Comprueba la existencia del directorio destino.

			if not exist %dest% (echo ERROR: El directorio destino no existe.) else (goto :C4exe)
			goto :Fin
		
		:C4exe

		REM Ejecuta el comando para replicar el directorio.

			xcopy /E %3 %4

			echo El directorio ha sido copiado con exito.
			goto :Fin

	:C5

	REM Genera un fichero.txt con la estructura de directorios en árbol contenida a partir de una ruta.

		set dir=%3
		set filename=%4
		set indicator=%5

		:C5CkDir

		REM Valida la entrada de datos para el directorio.

			if "%dir%"=="" (echo ATENCION: Debe introducir la ruta del directorio, el nombre del fichero txt y un parametro.) else (goto :C5ExDir)
			goto :Fin

		:C5ExDir

		REM Comprueba la existencia del directorio.
	
			if not exist %dir% (echo ERROR: El directorio especificado no existe.) else (goto :C5FileName)
			goto :Fin

		:C5FileName

		REM Valida la entrada de datos para el nombre del fichero.

			if "%filename%"=="" (echo ATENCION: Debe introducir el nombre del fichero txt y un parametro.) else (goto :C5CkInd)
			goto :Fin
		
		:C5CkInd

		REM Expone los parámetros, verifica y ejecuta el modo seleccionado.

			if "%indicator%" == "F" (
				tree %3 /F /A > C:\Users\%USERNAME%\Desktop\%4.txt
				echo El archivo ha sido creado con exito. Puede encontrarlo en c:\Users\%USERNAME%\Desktop\%4.txt
				goto :Fin
			)
			if "%indicator%" == "S" (
				tree %3 /A > %4.txt
				echo El archivo ha sido creado con exito. Puede encontrarlo en c:\Users\%USERNAME%\Desktop\%4.txt
				goto :Fin
			)
			
			echo ERROR: Debe introducir un parametro valido.
			goto :Fin

	:C6

	REM Funciona como la papelera de Windows pero en verdad es un archivo tar.

		set choice=%3

		:C6CkOptions

			if "%choice%"=="" (echo ATENCION: Debe introducir el parametro de ejecucion.) else (goto :C6ExOptions)
			goto :Fin

		:C6ExOptions

			if "%choice%" == "V" goto :COP6V
			if "%choice%" == "B" goto :COP6B
			if "%choice%" == "R" goto :COP6R

			echo ERROR: El tercer parametro no es valido.
			goto :Fin

		:C6V

		REM Muestra el contenido de la papelera, si existe.

			if not exist c:\Users\%USERNAME%\papelera\papelera.tar (echo ATENCION: Primero debe borrar algun archivo.) else (tar -tf C:\Users\%USERNAME%\papelera\papelera.tar)
			goto :Fin
		
		:COP6B

		REM Borra un archivo o directorio y hace una copia en la papelera.

			REM Comprueba la existencia del directorio papelera. Si no existe, lo crea.

			if not exist "C:\Users\%USERNAME%\papelera" (mkdir C:\Users\%USERNAME%\papelera)

			set file=%4

			:C6BCkFile

			REM Valida la entrada de datos del archivo o directorio que se desea borrar.

				if "%file%"=="" (echo ATENCION: Debe introducir el elemento que desea enviar a la papelera.) else (goto :C6BExFile)
				goto :Fin

			:C6BExFile

			REM Comprueba la existencia del archivo o directorio que se desea borrar.
		
				if not exist %file% (echo ERROR: El archivo o directorio especificado no existe.) else (goto :COP6Bexe)
				goto :Fin
			
			:C6Bexe

			REM Manda el archivo o directorio a la papelera.tar. En caso de no existir la papelera, la crea.
				
				if not exist c:\Users\%USERNAME%\papelera\papelera.tar (tar -cvf C:\Users\%USERNAME%\papelera\papelera.tar %file%) else (tar -rvf C:\Users\%USERNAME%\papelera\papelera.tar %file%)
				if exist %file%\ (rmdir /S /Q %file%) else (del /F %file%)

				echo El archivo o fichero ha sido enviado a la papelera correctamente.
				goto :Fin
		
		:C6R

		REM Restaura un archivo o directorio de la papelera.

			set file=%4

			:C6RCkFile

			REM Valida la entrada de datos del archivo o directorio que se desea extraer.

				if "%file%"=="" (echo ATENCION: Debe introducir el elemento que desea restaurar.) else (goto :C6Rexe)
				goto :Fin
			
			:C6Rexe

			REM Extrae el archivo o directorio de la papelera.tar.
				
				tar -xf C:\Users\%USERNAME%\papelera\papelera.tar %file%

				echo El archivo o fichero ha sido restaurado correctamente.
				goto :Fin
			
	:C7

	REM Oculta y revela ficheros o directorios ocultos protegidos bajo contraseña a través del uso de atributos.

		set choice=%3

		:C7CkOptions

			if "%choice%"=="" (echo ATENCION: Debe introducir el parametro de ejecucion.) else (goto :C7ExOptions)
			goto :Fin

		:C7ExOptions

			if "%choice%" == "B" goto :C7B
			if "%choice%" == "D" goto :C7D

			echo ERROR: El tercer parametro no es valido.
			goto :Fin

		:C7B

		REM Oculta un fichero o directorio.

			set file=%4

			:C7BCkFile

			REM Valida la entrada de datos del archivo o directorio que se desea ocultar.

				if "%file%"=="" (echo ATENCION: Debe introducir el elemento que desea proteger.) else (goto :C7BExFile)
				goto :Fin

			:C7BExFile

			REM Comprueba la existencia del archivo o directorio que se desea ocultar.
				
				if not exist %file% (echo ERROR: El archivo o directorio especificado no existe.) else (goto :C7Bexe)
				goto :Fin
			
			:C7Bexe

			REM Manda el archivo o directorio a la papelera.tar. En caso de no existir la papelera, la crea.

				attrib +h +s %file%
				echo El bloqueo se ha aplicado con exito. Su clave es '1ASIRA'.
				echo Has ocultado %~dp0%file% -- %date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%:%Time:~3,2%:%Time:~6,2% >> C:\Users\%USERNAME%\Desktop\listatotalmentenormal.txt
				goto :Fin

		:C7D

		REM Hace visible un fichero o directorio tras la introducción de una contraseña.

			set file=%4
			set pass=%5

			:C7DCkLockFile
			
			REM Valida la entrada de datos del archivo o directorio que se desea revelar.			

				if "%file%"=="" (echo ATENCION: Debe introducir el elemento que desea desbloquear.) else (goto :C7DCkPass)
				goto :Fin

			:C7DCkPass

			REM Comprueba la existencia del archivo o directorio que se desea revelar.			

				if "%pass%"=="" (echo ATENCION: Debe introducir la clave para el desbloqueo.) else (goto :C7Dexe)
				goto :Fin

			:C7Dexe

			REM Quita los atributos que ocultan el archivo o directorio y plasma la acción en un fichero .txt para nada sospechoso.

				if NOT %pass%== 1ASIRA (goto :ClaveIncorrecta) else (			
					attrib -h -s %file%
					echo El desbloqueo se ha aplicado con exito.
					echo Has desbloqueado %~dp0%file% -- %date:~6,4%-%date:~3,2%-%date:~0,2%_%Time:~0,2%:%Time:~3,2%:%Time:~6,2% >> C:\Users\%USERNAME%\Desktop\listatotalmentenormal.txt
					goto :Fin
				)

			:ClaveIncorrecta

			REM Indica que la clave es incorrecta.

				echo ERROR: Clave incorrecta.
				goto :Fin


:Fin