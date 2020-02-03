# Instalacion y Uso del toolchain RV32I

En este repositorio se encuentran los archivos necesarios para descargar, instalar y usar el toolchain de GNU para la arquitectura RV32I de RISC-V. El objetivo de este tutorial es poder compilar un programa en C para RV32I, validando que se genera el lenguaje ensamblador y el lenguaje de máquina correcto. Esta validación es necesaria debido a que RISC-V tiene distintos objetivos de compilación.


## Instalación del toolchain

Para la instalación del toolchain de RV32I se debe ejecutar un script de bash contenido en este repositorio. Para la ejecución del script se debe ejecutar:

~~~~
$ chown +x rv32i_toolchain_install.sh
$ ./rv32i_toolchain_install.sh
~~~~

Al ejecutar este script se realizan las diferentes acciones necesarias para instalar el toolchain de RISC-V. Estas acciones consisten en descargar el repositorio con el toolchain, configurarlo para la arquitectura RV32I e instalarlo en el directorio recomendado. Adicionalmente, se realizan modificaciones en el archivo ```.bashrc``` para utilizar los archivos binarios correctamente. Para efecturar la instalación correctamente, se deberá introducir la contraseña de superusuario.


## Verificación de la instalación

Para verificar la instalación se debe ejecutar el comando de consola que se indica a continuación. Este comando va a compilar una adición entre dos números enteros y generar el archivo binario.

~~~~
$ riscv32-unknown-elf-gcc ./src/int_add.c -o bin/int_add
~~~~

Si el comando puede ser ejecutado sin ningún error, entonces el toolchain fue instalado correctamente. Ahora es posible compilar diferentes archivos de código fuente con la cadena de herramientas de GNU.


## Compilación de múltiples archivos

Debido a que la mayoría de proyectos contienen múltiples archivos fuente, es necesario entender la metodología para compilar múltiples archivos.

~~~~
$ riscv32-unknown-elf-gcc -o bin/multiple src/multiple_files_main.c src/int_functions.c
~~~~

Si bien esta estrategia de compilación es útil, una mejor aproximación para lidiar con proyectos de múltiples archivos es utilizar un makefile. Vale la pena mencionar que un makefile no está limitado a proyectos escritos en C, sino que funciona para cualquier clase de proyecto.


## Conversión de C a lenguaje ensamblador

Es posible utilizar el compilador para obtener el equivalente del programa en C en lenguaje ensamblador de RISC-V. Para obtener el equivalente de la suma de números enteros en C, en lenguaje ensamblador de RISC-V se debe ejecutar:

~~~~
$ riscv32-unknown-elf-gcc -S -o asm/int_add.s src/int_add.c
~~~~

Al ejecutarlo, el archivo ```asm/int_add.s``` contendrá el lenguaje ensamblador de RISC-V del programa de suma de números enteros. Para visualizar el archivo desde consola se puede ejecutar:

~~~~
$ cat asm/int_add.s
~~~~

## Compilación de lenguaje ensamblador

## Deconstrucción de un archivo binario

