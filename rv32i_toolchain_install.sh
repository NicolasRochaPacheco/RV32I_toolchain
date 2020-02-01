#!/bin/bash

#------------------------------------------------------------------------------
# Script para la instalación del toolchain de RISC-V (compilación).
# En este script solo se instala el toolchain de RV32I.
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#		PREPARACIÓN
#------------------------------------------------------------------------------
# Este script debe ser ejecutable. En caso de no lo sea, se debe hacer:
# $ chmod +x rv32i_toolchain.sh
#------------------------------------------------------------------------------

# Path de instalación de las herramientas
RISCV_PATH=/opt/riscv/rv32i

# Path de descarga del repositorio. Será eliminado después de la instalación.
DOWNLOAD_PATH=~/riscv_download

# Variable con el archivo de log
RV_LOG=~/risv_toolchain_install.log

# Informa al usuario donde se va a instalar el toolchain
echo Instalando el toolchain de RISC-V para RV32I!
echo Path de instalación: $RISCV_PATH

# Crea un archivo de log en el home. Este script no genera outputs.
if [[ -d $RV_LOG ]];
then
	rm $RV_LOG
	touch $RV_LOG
else
	touch $RV_LOG
fi

if [[ -d $DOWNLOAD_PATH ]];
then
	sudo rm -r $DOWNLOAD_PATH
	echo Directorio de descarga limpio!
else
	echo Directorio de descarga limpio!
fi


# Instala los prerequisitos 
echo Instalando prerequisitos!
sudo apt-get update > $RV_LOG
sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev \
		libmpfr-dev libgmp-dev gawk build-essential	bison flex texinfo gperf \
		libtool patchutils bc zlib1g-dev libexpat-dev > $RV_LOG
echo Los prerequisitos han sido instalados!

# Revisa que el directorio en el cual se va a instalar el toolchain exista.
# Si el directorio existe, se eliminan los contenidos de este. De lo contrario
# se crea el directorio.
if [[ -d $RISCV_PATH ]];
then
	echo El directorio existe!
	sudo rm -r $RISCV_PATH > $RV_LOG
	sudo mkdir -p $RISCV_PATH > $RV_LOG
	echo Se ha limpiado el directorio!
else
	echo El directorio no existe!
	sudo mkdir -p $RISCV_PATH > $RV_LOG
	echo Se ha creado el directorio
fi

# Descarga el repositorio del toolchain de RISC-V. Este proceso puede tomar
# unos minutos. El repositorio es clonado en la carpeta home.
echo Descargando los archivos del toolchain de RISC-V.
echo Esto puede tomar unos minutos
mkdir -p $DOWNLOAD_PATH
git clone https://github.com/riscv/riscv-gnu-toolchain $DOWNLOAD_PATH
cd $DOWNLOAD_PATH
git submodule update --init --recursive
echo Se han descargado los archivos

# Configura el toolchain para RV32I
echo Configurando el toolchain para RV32I
./configure --prefix=$RISCV_PATH \
			--with-arch=rv32i \
			--with-abi=ilp32 > $RV_LOG

# Instala el toolchain
echo Instalando el toolchain
sudo make
echo El toolchain ha sido instalado!

# Elimina los archivos descargados para la instalación
cd ~
sudo rm -r $DOWNLOAD_PATH
sudo rm -r $RV_LOG

# Da permisos del usuario sobre la carpeta de instalación del toolchain
sudo chown $USER $RISCV_PATH

# Modifica la variable PATH para usar los binarios de RISC-V
echo export PATH=${PATH}:$RISCV_PATH/bin >> ~/.bashrc
