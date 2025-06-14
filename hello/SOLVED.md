# Implementation Details

### BIOS Function Implementation (libc.S)
---------------------------------------
- Added a new function `get_memory_size` that uses BIOS interrupt 0x12
- This interrupt returns the conventional memory size in KiB in register AX
- The function is declared as global so it can be called from C code
- The return value is automatically placed in AX, which is the standard return register for GCC

### String Conversion Implementation (libc.S)
------------------------------------------
- Added `int_to_str` function to convert integers to strings
- Uses fastcall convention (parameters in registers) to match printf's calling convention:
  - First parameter (number) in %cx
  - Second parameter (buffer) in %dx
- Algorithm:
  - Handles zero as a special case
  - For non-zero numbers:
    - Repeatedly divides by 10 to get each digit
    - Converts digits to ASCII by adding '0'
    - Stores digits on stack (automatically reverses them)
    - Pops digits into buffer in correct order
  - Adds null terminator at the end
- Register usage:
  - %ax: Input number and division result
  - %bx: Buffer address
  - %cx: Digit counter (saved/restored for parameter)
  - %dx: Division remainder and buffer parameter
  - %di: Divisor (10)

### Header File Changes (stdio.h)
-------------------------------
- Added external declarations for assembly functions:
  - `get_memory_size()`: Function to retrieve conventional memory size
  - `int_to_str()`: Function to convert integers to strings
- Both functions are declared with fastcall attribute to ensure proper calling convention
- These declarations allow the functions to be called from C code in main.c

### Main Program Changes (main.c)
-------------------------------
- Modified main() to:
  - Call get_memory_size() to get memory size
  - Use int_to_str() to convert the number to string
  - Print the result using the custom printf function

### Technical Details
-------------------
- BIOS interrupt 0x12 returns the conventional memory size in KiB
- The value is returned in AX register (16-bit value)
- Maximum conventional memory is 640KiB, so the value will be <= 640
- The custom printf function uses fastcall convention (parameter in %cx)
- All assembly functions are designed to work together with the same calling convention

### Testing
---------
To test the implementation:
1. Run 'make hello.bin' to build
2. Run 'make hello.bin/run' to test in QEMU
3. The output should show:
   - "Conventional memory size: XXX KiB"
