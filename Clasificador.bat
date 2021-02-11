@echo off

IF Exist "Bien.txt" (
  del Bien.txt
)

IF Exist "Mal.txt" (
  del Mal.txt
)

:Inicio
echo -------------------------------------------------
echo Opcion 1: MODO NOMINAS
echo Opcion 2: MODO PAGA EXTRA
echo Opcion 3: MODO RETENCION
echo Opcion 4: MODO PRUEBA
echo Opcion 5: MODO FINIQUITO
echo Opcion 6: MODO BORRAR
echo Opcion 7: SALIR
echo -------------------------------------------------
echo Inserte el numero con la opcion deseada:
set /p extra=
if %extra%==1 (Call:Normal)
if %extra%==2 (Call:PagaExtra)
if %extra%==3 (Call:Retencion)
if %extra%==4 (Call:Prueba)
if %extra%==5 (Call:Finiquito)
if %extra%==6 (Call:BorrarMenu)
if %extra%==7 (exit)
if not defined %extra% (
  cls
  echo -------------------------------------------------
  echo ERROR: Respuesta incorrecta, vuelva a intentarlo
  echo -------------------------------------------------
  Goto Inicio
)
exit

:BucleExtraVerano
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo -----------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo -----------------------------

  IF Exist Nominas/%%a.pdf (
    Robocopy.exe C:\Clasificador\PagaExtra\ C:\Clasificador\Clasificado\%%b\%anyoPagaExtra%\PagaExtra\Verano\ "%%a.pdf" /E
    echo %%a>> Bien.txt
  ) ELSE (
    echo Error: %%a>> Mal.txt
  )
)
Call:MensajeError
timeout 5
exit

:BucleExtraNavidad
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo -----------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo -----------------------------

  IF Exist Nominas/%%a.pdf (
    Robocopy.exe C:\Clasificador\Nominas\ C:\Clasificador\Clasificado\%%b\%anyoPagaExtra%\PagaExtra\Navidad\ "%%a.pdf" /E
    echo %%a>> Bien.txt
  ) ELSE (
    echo Error: %%a>> Mal.txt
  )
)
Call:MensajeError
timeout 5
exit

:BucleNormal
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  IF Exist Nominas/%%a.pdf (
    Robocopy.exe C:\Clasificador\Nominas\ C:\Clasificador\Clasificado\%%b\%anyoFuncionNormal%\%mes%\ "%%a.pdf" /E
    echo %%a>> Bien.txt
  ) ELSE (
    echo Error: %%a>> Mal.txt
  )
)
Call:MensajeError
timeout 5
exit

:BucleNormalPrueba
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperariosPrueba.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  IF Exist Nominas/%%a.pdf (
    Robocopy.exe C:\Clasificador\Pruebas\Nominas\ C:\Clasificador\Clasificado\%%b\%anyoFuncionNormal%\%mes%\ "%%a.pdf" /E
    echo %%a>> Bien.txt
  ) ELSE (
    echo Error: %%a>> Mal.txt
  )
)
Call:MensajeError
timeout 5
exit

:PagaExtra
echo -----------------------------
echo INICIANDO Modo Paga Extra
echo -----------------------------
echo Introduzca del anyo:
set /p anyoPagaExtra=
echo El anyo introducido es: %anyoPagaExtra%
echo 01: Verano
echo 02: Navidad
echo Introduzca el numero de paga (01 o 02):
set /p numPagaExtra=
if %numPagaExtra% GEQ 01 if %numPagaExtra% LEQ 02 (
  echo El numero de mes introducido es: %numPagaExtra%
  timeout 1
  if %numPagaExtra%==01 (
    Call:BucleExtraVerano
  ) else (
    if %numPagaExtra%==02 (
      Call:BucleExtraNavidad
    ) else (
      echo ERROR: Valor de paga incorrecto
      timeout 3
      cls
      Call:PagaExtra
    )
  )
) else (
  echo ERROR: Valor de paga incorrecto
  timeout 3
  cls
  Call:PagaExtra
)
Call:MensajeError
timeout 5
exit

:BucleRetencion
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  IF Exist Nominas/%%a.pdf (
    Robocopy.exe C:\Clasificador\Retencion\ C:\Clasificador\Clasificado\%%b\%anyoRetencion%\Retencion\ "%%a.pdf" /E
    echo %%a>> Bien.txt
  ) ELSE (
    echo Error: %%a>> Mal.txt
  )
)
Call:MensajeError
timeout 5
exit

:Normal
echo -----------------------------
echo INICIANDO Modo Nominas
echo -----------------------------
echo Introduzca del anyo:
set /p anyoFuncionNormal=
echo El anyo introducido es: %anyoFuncionNormal%
echo Introduzca el mes de la nomina (01 al 12):
set /p mes=
if %mes% GEQ 01 if %mes% LEQ 12 (
  echo El mes introducido es: %mes%
  timeout 3
  Call:BucleNormal
  cls
  timeout 3
  exit
) else (
  echo ERROR: Mes insertado incorrecto
  timeout 3
  cls
  Call:Normal
)

:Retencion
echo -----------------------------
echo INICIANDO Modo Retencion
echo -----------------------------
echo Introduzca del anyo:
set /p anyoRetencion=
echo El anyo introducido es: %anyoRetencion%
Call:BucleRetencion
timeout 3
exit

:Prueba
echo -----------------------------
echo INICIANDO Modo Prueba
echo -----------------------------
echo Introduzca del anyo:
set /p anyoFuncionNormalPrueba=
echo El anyo introducido es: %anyoFuncionNormalPrueba%
echo Introduzca el mes de la nomina (01 al 12):
set /p mes=
if %mes% GEQ 01 if %mes% LEQ 12 (
  echo El mes introducido es: %mes%
  timeout 3
  Call:BucleNormalPrueba
  cls
  timeout 3
  exit
) else (
  echo ERROR: Mes insertado incorrecto
  timeout 3
  cls
  Call:Prueba
)

:BorrarMenu
echo -------------------------------------------------
echo Opcion 1: MODO BORRAR TODAS LAS NOMINAS
echo Opcion 2: MODO BORRAR NOMINAS DE UN OPERARIO
echo Opcion 3: MODO BORRAR TODAS LAS PAGAS DE VERANO
echo Opcion 4: MODO BORRAR TODAS LAS PAGAS DE NAVIDAD
echo Opcion 5: MODO BORRAR LA PAGA DE VERANO DE UN OPERARIO
echo Opcion 6: MODO BORRAR LA PAGA DE NAVIDAD DE UN OPERARIO
echo Opcion 7: MODO BORRAR TODAS LAS RETENCIONES
echo Opcion 8: MODO BORRAR LA RETENCION DE UN OPERARIO
echo Opcion 9: SALIR
echo -------------------------------------------------
echo Inserte el numero con la opcion deseada:
set /p extra=
if %extra%==1 (Call:BorrarNominasTodos)
if %extra%==2 (Call:BorrarNominasUno)
if %extra%==3 (Call:BorrarPagaVeranoTodos)
if %extra%==4 (Call:BorrarPagaNavidadTodos)
if %extra%==5 (Call:BorrarPagaVeranoUno)
if %extra%==6 (Call:BorrarPagaNavidadUno)
if %extra%==7 (Call:BorrarRetencionTodos)
if %extra%==8 (Call:BorrarRetencionUno)
if %extra%==9 (exit)
if not defined %extra% (
  cls
  echo -------------------------------------------------
  echo ERROR: Respuesta incorrecta, vuelva a intentarlo
  echo -------------------------------------------------
  Goto Inicio
)
exit

:BucleBorrarNominasTodos
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  rmdir /s /q C:\Clasificador\Clasificado\%%b\%anyoBorrar%\%mes%\
)
Call:MensajeError
timeout 5
exit

:BorrarNominasTodos
echo -----------------------------
echo INICIANDO Modo Borrar Nominas Todos
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
echo Introduzca el mes de la nomina (01 al 12):
set /p mes=
if %mes% GEQ 01 if %mes% LEQ 12 (
  echo El mes introducido es: %mes%
  timeout 3
  Call:BucleBorrarNominasTodos
  cls
  timeout 3
  exit
) else (
  echo ERROR: Mes insertado incorrecto
  timeout 3
  cls
  Call:Normal
)

:BorrarNominasUno
echo -----------------------------
echo INICIANDO Modo Borrar Nominas Uno
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
echo Introduce el numero de operario:
set /p operario=
echo El operario introducido es: %operario%
echo Introduzca el mes de la nomina (01 al 12):
set /p mes=
if %mes% GEQ 01 if %mes% LEQ 12 (
  echo El mes introducido es: %mes%
  timeout 3
  rmdir /s /q C:\Clasificador\Clasificado\%operario%\%anyoBorrar%\%mes%\
  cls
  timeout 3
  exit
) else (
  echo ERROR: Mes insertado incorrecto
  timeout 3
  cls
  Call:Normal
)

:BucleBorrarPagaVeranoTodos
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  rmdir /s /q C:\Clasificador\Clasificado\%%b\%anyoBorrar%\PagaExtra\Verano
)
Call:MensajeError
timeout 5
exit

:BorrarPagaVeranoTodos
echo -----------------------------
echo INICIANDO Modo Borrar Paga Verano Todos
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
timeout 3
Call:BucleBorrarPagaVeranoTodos
cls
timeout 3
exit

:BucleBorrarPagaNavidadTodos
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  rmdir /s /q C:\Clasificador\Clasificado\%%b\%anyoBorrar%\PagaExtra\Navidad
)
Call:MensajeError
timeout 5
exit

:BorrarPagaNavidadTodos
echo -----------------------------
echo INICIANDO Modo Borrar Paga Navidad Todos
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
timeout 3
Call:BucleBorrarPagaNavidadTodos
cls
timeout 3
exit

:BorrarPagaVeranoUno
echo -----------------------------
echo INICIANDO Modo Borrar Paga Verano Un Operario
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
echo Introduce el numero de operario:
set /p operario=
echo El operario introducido es: %operario%
timeout 3
rmdir /s /q C:\Clasificador\Clasificado\%operario%\%anyoBorrar%\PagaExtra\Verano
cls
timeout 3
exit

:BorrarPagaNavidadUno
echo -----------------------------
echo INICIANDO Modo Borrar Paga Navidad Un Operario
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
echo Introduce el numero de operario:
set /p operario=
echo El operario introducido es: %operario%
timeout 3
rmdir /s /q C:\Clasificador\Clasificado\%operario%\%anyoBorrar%\PagaExtra\Navidad
cls
timeout 3
exit

:BucleBorrarRetencionTodos
for /f "usebackq tokens=1-2 delims=," %%a in ("listaOperarios.csv") do (
  echo ------------------------------------------
  echo Realizando:
  echo Nombre:%%a
  echo Numero:%%b
  echo ------------------------------------------

  rmdir /s /q C:\Clasificador\Clasificado\%%b\%anyoBorrar%\Retencion\
)
Call:MensajeError
timeout 5
exit

:BorrarRetencionTodos
echo -----------------------------
echo INICIANDO Modo Borrar Retencion Todos
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
timeout 3
Call:BucleBorrarRetencionTodos
cls
timeout 3
exit

:BorrarRetencionUno
echo -----------------------------
echo INICIANDO Modo Borrar Retencion Todos
echo -----------------------------
echo Introduzca del anyo:
set /p anyoBorrar=
echo El anyo introducido es: %anyoBorrar%
echo Introduce el numero de operario:
set /p operario=
echo El operario introducido es: %operario%
timeout 3
rmdir /s /q C:\Clasificador\Clasificado\%operario%\%anyoBorrar%\Retencion\
cls
timeout 3
exit

:Finiquito
echo -----------------------------
echo INICIANDO Modo Finiquito
echo -----------------------------
echo Metodo no implementado
timeout 3
cls
Call:Inicio

:MensajeError
if Exist Mal.txt (
   msg * Algo ha Fallado. Revisar Archivo de Texto. Departamento de IT
   timeout 4
   start Mal.txt
) else (
   msg * Las Nominas se han Cargado Correctamente. Departamento de IT
)
