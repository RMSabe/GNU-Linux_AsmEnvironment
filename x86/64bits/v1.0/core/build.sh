#!/bin/bash

nasm main.asm -f elf64 -o main.o
ld main.o -o run.elf

