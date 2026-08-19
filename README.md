# Act
A simple and bloat free way to read your files

## Usage
`act <filename>`

## Building
To build the binary use the makefile present in the directory, **the current setup builds the binary with i386 as the target architecture**. Begin retrocompatible you can run it on all x86_64 systems.

### Installing
To install the tool run the following commands
```bash
    make
    sudo make install
```
To remove the tool from your machine do
```bash
    sudo make uninstall
```
To change the installation destination you can use
```bash
    make DESTDIR=rootfs/usr/sbin install    
```

## Language
The whole tool is written in x86 Assembly with AT&T syntax.

## Issues
The tool is very basic and stripped down and might have some majour bugs and issues. If you find any feel free to open an issue on the Github repository.

