AS = as
TARGET=act

.PHONY: clean link build

all: link

build:
	$(AS) --32 src/act.S -o src/act.o
link: build
	ld -m elf_i386 src/act.o -o $(TARGET)

clean:
	rm -rf src/*.o $(TARGET)
