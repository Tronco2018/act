AS = as
TARGET=args

.PHONY: clean link build

all: link

build:
	$(AS) --32 src/args.S -o src/args.o
link: build
	ld -m elf_i386 src/args.o -o $(TARGET)

clean:
	rm -rf src/*.o $(TARGET)
