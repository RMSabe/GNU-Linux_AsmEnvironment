#!/bin/bash

nasm main.asm -f elf32 -o main.o
ld main.o -o run.elf

