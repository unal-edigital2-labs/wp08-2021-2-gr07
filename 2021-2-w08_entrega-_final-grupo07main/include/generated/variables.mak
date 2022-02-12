PACKAGES=libc libcompiler_rt libbase libfatfs liblitespi liblitedram libliteeth liblitesdcard liblitesata bios
PACKAGE_DIRS=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libc /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libcompiler_rt /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libbase /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libfatfs /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitespi /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitedram /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libliteeth /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitesdcard /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitesata /usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/bios
LIBS=libc libcompiler_rt libbase libfatfs liblitespi liblitedram libliteeth liblitesdcard liblitesata
TRIPLE=riscv64-unknown-elf
CPU=picorv32
CPUFAMILY=riscv
CPUFLAGS=-mno-save-restore -march=rv32im     -mabi=ilp32 -D__picorv32__ 
CPUENDIANNESS=little
CLANG=0
CPU_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/cores/cpu/picorv32
SOC_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc
PICOLIBC_DIRECTORY=/home/gaspar/.local/lib/python3.8/site-packages/pythondata_software_picolibc/data
COMPILER_RT_DIRECTORY=/opt/Litex/pythondata-software-compiler_rt/pythondata_software_compiler_rt/data
export BUILDINC_DIRECTORY
BUILDINC_DIRECTORY=/home/gaspar/Escritorio/Digital_2/2021-2-w08_entrega-_final-grupo07main/build/nexys4ddr/software/include
LIBC_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libc
LIBCOMPILER_RT_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libcompiler_rt
LIBBASE_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libbase
LIBFATFS_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libfatfs
LIBLITESPI_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitespi
LIBLITEDRAM_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitedram
LIBLITEETH_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/libliteeth
LIBLITESDCARD_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitesdcard
LIBLITESATA_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/liblitesata
BIOS_DIRECTORY=/usr/local/lib/python3.8/dist-packages/litex-0.0.0-py3.8.egg/litex/soc/software/bios