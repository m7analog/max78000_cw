/*****************************************************************************
 * Copyright (c) 2018 Rowley Associates Limited.                             *
 *                                                                           *
 * This file may be distributed under the terms of the License Agreement     *
 * provided with this software.                                              *
 *                                                                           *
 * THIS FILE IS PROVIDED AS IS WITH NO WARRANTY OF ANY KIND, INCLUDING THE   *
 * WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. *
 *                                                                           *
 *****************************************************************************/

function Reset()
{
  TargetInterface.pokeWord(0xE000EDFC, 0x01000000); // DEMCR - Disable vector catch and enable DWT
  TargetInterface.pokeWord(0xE0001020, TargetInterface.peekWord(0x00000004) & 0xFFFFFFFE); // DWT_COMP0
  TargetInterface.pokeWord(0xE0001024, 0x00000000); // DWT_MASK0
  TargetInterface.pokeWord(0xE0001028, 0x00000004); // DWT_FUNCTION0
  TargetInterface.pokeWord(0xE000ED0C, 0x05FA0004); // AIRCR - system reset request
  TargetInterface.waitForDebugState(1000);
  TargetInterface.peekWord(0xE0001028); // DWT_FUNCTION0 - Clear match
  TargetInterface.pokeWord(0xE0001024, 0x00000000); // DWT_MASK0
  TargetInterface.pokeWord(0xE0001028, 0x00000000); // DWT_FUNCTION0
}

function GetPartName()
{
  return "";
}

function MatchPartName(name)
{
  return true;
}

function EnableTrace(traceInterfaceType)
{
}

