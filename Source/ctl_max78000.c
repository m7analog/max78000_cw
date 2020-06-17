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

#include <ctl_api.h>
#include <max32660.h>

#define ONE_MS (SystemCoreClock / 1000)
#define TEN_MS (ONE_MS * 10)

static CTL_ISR_FN_t userTimerISR;

void
SysTick_Handler()
{
  ctl_enter_isr();
  if (SysTick->CTRL & SysTick_CTRL_COUNTFLAG_Msk)
    {
#ifdef CTL_TASKING
      ctl_time_increment = (SysTick->LOAD + 1) / ONE_MS;
#endif
      userTimerISR();
    }
  ctl_exit_isr();
}

void
ctl_set_priority(int irq, int priority)
{
  NVIC_SetPriority(irq, (1 << (__NVIC_PRIO_BITS - 1)) + priority);
}

int
ctl_unmask_isr(unsigned int irq)
{
  NVIC_EnableIRQ(irq);
  return 1;
}

int
ctl_mask_isr(unsigned int irq)
{
  NVIC_DisableIRQ(irq);
  return 1;
}

void
ctl_start_timer(CTL_ISR_FN_t timerFn)
{
  userTimerISR = timerFn;

  SysTick->LOAD = TEN_MS - 1;
  SysTick->VAL = 0;
  SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_TICKINT_Msk | SysTick_CTRL_ENABLE_Msk;

#ifdef CTL_TASKING
  // Set PendSV priority (PendSV must have lowest priority)
  NVIC_SetPriority(PendSV_IRQn, (1 << __NVIC_PRIO_BITS) - 1);
#endif
  // Set SysTick priority
  ctl_set_priority(SysTick_IRQn, 0);
}

unsigned long
ctl_get_ticks_per_second(void)
{
#ifdef CTL_TASKING
  return 1000;
#else
  return 100;
#endif
}

#ifdef CTL_TASKING

void ctl_sleep(unsigned delay)
{
  if (delay > 10)
    {
      SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
      if ((ONE_MS * delay) > 0x00FFFFFF || (ONE_MS * delay) < ONE_MS)
        SysTick->LOAD = 0x00FFFFFF;
      else
        SysTick->LOAD = (ONE_MS * delay) - 1;
      SysTick->VAL = 0;
      SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;
    }
  __asm("wfi");
  if (delay > 10)
    {
      SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
      SysTick->LOAD = TEN_MS - 1;
      SysTick->VAL = 0;
      SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;
    }
}

void ctl_woken()
{
  if (SysTick->CTRL & SysTick_CTRL_COUNTFLAG_Msk)
    ctl_time_increment = (SysTick->LOAD + 1) / ONE_MS;
  else
    ctl_time_increment = (SysTick->LOAD + 1 - SysTick->VAL) / ONE_MS;
  ctl_increment_tick_from_isr();
}

#endif
