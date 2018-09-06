from ctypes import *

dll = cdll.LoadLibrary('msvcrt.dll')
# dll = windll.LoadLibrary('msvcrt.dll')
print(dir(dll))
dll.printf(b'abc')
