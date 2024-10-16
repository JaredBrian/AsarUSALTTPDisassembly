@echo off
@setlocal

echo -----------------------Starting patch------------------------------

CALL asar.exe zelda3.asm DissasemblyAlttp.sfc

echo -----------------------Done applying patch------------------------------

PAUSE