# Instalacion y Uso del toolchain RV32I
En este repositorio se encuentran los archivos necesarios para descargar, instalar y usar el toolchain de GNU para la arquitectura RV32I de RISC-V. El objetivo de este tutorial es poder compilar un programa en C para RV32I, validando que se genera el lenguaje ensamblador y el lenguaje de máquina correcto. Esta validación es necesaria debido a que RISC-V tiene distintos objetivos de compilación.

## Instalación del toolchain
Para la instalación del toolchain de RV32I se debe ejecutar un script de bash contenido en este repositorio. Para la ejecución del script se debe ejecutar:

~~~~
$ chown +x rv32i_toolchain_install.sh
$ ./rv32i_toolchain_install.sh
~~~~

Al ejecutar este script se realizan las diferentes acciones necesarias para instalar el toolchain de RISC-V. Estas acciones consisten en descargar el repositorio con el toolchain, configurarlo para la arquitectura RV32I e instalarlo en el directorio recomendado. Adicionalmente, se realizan modificaciones en el archivo ```.bashrc``` para utilizar los archivos binarios correctamente.

## Verificación de la instalación

Para verificar la instalación se debe ejecutar el siguiente comando:

~~~~
$ riscv32-unknown-elf-gcc ./src/tests/int_add.c -o bin/int_add
~~~~

Si el comando puede ser ejecutado sin ningún error, entonces el toolchain fue instalado correctamente.
