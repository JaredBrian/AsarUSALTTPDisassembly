@echo off
@setlocal

echo -----------------------Starting patch------------------------------

CALL asar.exe Test.asm TestBuild.sfc

echo -----------------------Done applying patch------------------------------

PAUSE