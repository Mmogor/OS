NAME := mogor_os

SRC := ./src
OUT := ./bin
OUT_INT := $(OUT)/int
OUT_ISO := $(OUT)/iso

iso: kernel
	if grub-file --is-x86-multiboot $(OUT)/$(NAME).bin; then \
		echo "multiboot confirmed"; \
		mkdir -p $(OUT_ISO)/boot/grub; \
		cp $(OUT)/$(NAME).bin $(OUT_ISO)/boot/$(NAME).bin; \
		cp ./grub.cfg $(OUT_ISO)/boot/grub/grub.cfg; \
		grub-mkrescue -o $(OUT)/$(NAME).iso $(OUT_ISO); \
	else \
		echo "the file is not multiboot"; \
	fi

kernel: intermediary
	i386-elf-gcc -T $(SRC)/linker.ld -o $(OUT)/$(NAME).bin -ffreestanding -O2 -nostdlib $(OUT_INT)/boot.o $(OUT_INT)/kernel.o -lgcc

intermediary:
	i386-elf-as $(SRC)/boot.s -o $(OUT_INT)/boot.o
	i386-elf-gcc -c $(SRC)/kernel.c -o $(OUT_INT)/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

clean:
	rm -r ./bin/*
	mkdir ./bin/int/
