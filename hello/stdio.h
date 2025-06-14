/*
 *    SPDX-FileCopyrightText: 2025 Brunelli <gubrunelli@hotmail.com>
 *   
 *    SPDX-License-Identifier: GPL-3.0-or-later
 *
 *  This file is a derivative of SYSeg (https://gitlab.com/monaco/syseg)
 *  and includes modifications made by the following author(s):
 *  Brunelli <gubrunelli@hotmail.com>
 */

#ifndef E8_H
#define E8_H

void __attribute__((fastcall, naked)) printf(const char *); 
extern void __attribute__((fastcall)) int_to_str(int num, char *buffer);
extern int get_memory_size(void);

#endif	
