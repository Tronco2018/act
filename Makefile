AS = as
TARGET=act
DESTDIR=/usr/bin

.PHONY: clean link build install

all: link

build:
	$(AS) --32 src/act.S -o src/act.o
link: build
	ld -m elf_i386 src/act.o -o $(TARGET)
$(TARGET): link

install:
	install -m 755 $(TARGET) $(DESTDIR)/$(TARGET)

uninstall:
	rm -f $(DESTDIR)/$(TARGET)

clean:
	rm -rf src/*.o $(TARGET)
