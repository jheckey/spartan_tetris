################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/qepn.c \
../src/qfn.c \
../src/qfn_init.c \
../src/tetris.c \
../src/tetris_states.c \
../src/tetris_vga.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/qepn.o \
./src/qfn.o \
./src/qfn_init.o \
./src/tetris.o \
./src/tetris_states.o \
./src/tetris_vga.o 

C_DEPS += \
./src/qepn.d \
./src/qfn.d \
./src/qfn_init.d \
./src/tetris.d \
./src/tetris_states.d \
./src/tetris_vga.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo Building file: $<
	@echo Invoking: MicroBlaze gcc compiler
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -Wl,--no-relax -I../../tetris_bsp/microblaze_0/include -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.40.b -mno-xl-soft-mul -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo Finished building: $<
	@echo ' '


