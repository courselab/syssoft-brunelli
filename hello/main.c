/*
 *    SPDX-FileCopyrightText: 2021 Monaco F. J. <monaco@usp.br>
 *    SPDX-FileCopyrightText: 2025 Brunelli <gubrunelli@hotmail.com>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *  This file is a derivative of SYSeg (https://gitlab.com/monaco/syseg)
 *  and includes modifications made by the following author(s):
 *  Brunelli <gubrunelli@hotmail.com>
 */

#include <stdio.h>

int main(void)   
{
  int mem_size;
  char buffer[20];
  
  mem_size = get_memory_size();
  
  int_to_str(mem_size, buffer);
  
  printf("Conventional memory size: ");
  printf(buffer);
  printf(" KiB\n");
  return 0;
}
