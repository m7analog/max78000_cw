#include "libmem_max78000.h"
#include "max78000.h"
#include "flc_regs.h"

static libmem_driver_paged_write_ctrlblk_t paged_write_ctrlblk;

static uint8_t write_buffer[MXC_FLASH_PAGE_SIZE];

static int
flash_wait_while_busy(uint32_t timeout_ticks)
{
  uint32_t start_ticks = libmem_get_ticks();
  do
    {
      if (libmem_busy_handler_fn)
        libmem_busy_handler_fn();


      if ( !(MXC_FLC->ctrl & (MXC_F_FLC_CTRL_WR | MXC_F_FLC_CTRL_ME | MXC_F_FLC_CTRL_PGE) ) )
        {
          if (MXC_FLC->intr & MXC_F_FLC_INTR_AF)
            {
              MXC_FLC->intr &= ~MXC_F_FLC_INTR_AF;
              return LIBMEM_STATUS_ERROR;
            }
          return LIBMEM_STATUS_SUCCESS;
        }
    }
  while (timeout_ticks == 0 || (libmem_get_ticks() - start_ticks) < timeout_ticks);
  return LIBMEM_STATUS_TIMEOUT;
}

static int
flash_erase_sector(libmem_driver_handle_t *h, libmem_sector_info_t *si)
{

  int res;
  MXC_FLC->ctrl = (MXC_FLC0->ctrl & ~MXC_F_FLC_CTRL_UNLOCK) | MXC_S_FLC_CTRL_UNLOCK_UNLOCKED;
  MXC_FLC->ctrl = (MXC_FLC0->ctrl & ~MXC_F_FLC_CTRL_ERASE_CODE) | MXC_S_FLC_CTRL_ERASE_CODE_ERASEPAGE;
  MXC_FLC->addr = (uint32_t)si->start;
  MXC_FLC->ctrl |= MXC_F_FLC_CTRL_PGE;
  res = flash_wait_while_busy(h->flash_info ? h->flash_info->erase_sector_timeout_ticks : 0);
  MXC_FLC->ctrl = (MXC_FLC0->ctrl & ~MXC_F_FLC_CTRL_UNLOCK) | MXC_S_FLC_CTRL_UNLOCK_LOCKED;
  return res;
}

int
flash_erase_chip(libmem_driver_handle_t *h)
{
  int res;
  MXC_FLC->ctrl = (MXC_FLC0->ctrl & ~MXC_F_FLC_CTRL_UNLOCK) | MXC_S_FLC_CTRL_UNLOCK_UNLOCKED;

  MXC_FLC->ctrl = (MXC_FLC->ctrl & ~MXC_F_FLC_CTRL_ERASE_CODE) | MXC_S_FLC_CTRL_ERASE_CODE_ERASEALL;
  MXC_FLC->ctrl |= MXC_F_FLC_CTRL_ME;
  res = flash_wait_while_busy(h->flash_info ? h->flash_info->erase_sector_timeout_ticks : 0);
  MXC_FLC0->ctrl &= ~(MXC_F_FLC_CTRL_UNLOCK | MXC_F_FLC_CTRL_ERASE_CODE);
  MXC_FLC0->ctrl = (MXC_FLC0->ctrl & ~MXC_F_FLC_CTRL_UNLOCK) | MXC_S_FLC_CTRL_UNLOCK_LOCKED;
  return res;
}

int
flash_write_page(libmem_driver_handle_t *h, uint8_t *dest, const uint8_t *src)
{

  int res = LIBMEM_STATUS_SUCCESS;
  uint32_t dest32 = (uint32_t)dest - MXC_FLASH_MEM_BASE;
  uint32_t *src32 = (uint32_t *)src;
  MXC_FLC->ctrl = (MXC_FLC->ctrl & ~MXC_F_FLC_CTRL_UNLOCK) | MXC_S_FLC_CTRL_UNLOCK_UNLOCKED;
  MXC_FLC->ctrl &= ~MXC_F_FLC_CTRL_WDTH;
  for (int i = sizeof(write_buffer) / 16; i; i--)
    {
      MXC_FLC->addr = dest32;
      dest32 += sizeof(int);
      MXC_FLC->data[0] = *src32++;
      MXC_FLC->data[1] = *src32++;
      MXC_FLC->data[2] = *src32++;
      MXC_FLC->data[3] = *src32++;
      MXC_FLC->ctrl |= MXC_F_FLC_CTRL_WR;
      res = flash_wait_while_busy(h->flash_info ? h->flash_info->write_timeout_ticks : 0);
      if (res != LIBMEM_STATUS_SUCCESS)
        break;
    }
  MXC_FLC->ctrl &= ~MXC_F_FLC_CTRL_UNLOCK;
  return res;
}

static int
libmem_write_impl(libmem_driver_handle_t *h, uint8_t *dest, const uint8_t *src, size_t size)
{
  return libmem_driver_paged_write(h, dest, src, size, &paged_write_ctrlblk);
}

static int
libmem_erase_impl(libmem_driver_handle_t *h, uint8_t *start, size_t size, uint8_t **erase_start, size_t *erase_size)
{
  int res;
  if (LIBMEM_RANGE_WITHIN_RANGE(h->start, h->start + h->size - 1, start, start + size - 1))
    {
      if (erase_start)
        *erase_start = h->start;
      if (erase_size)
        *erase_size = h->size;
      res = flash_erase_chip(h);
    }
  else
    res = libmem_foreach_sector_in_range(h, start, size, flash_erase_sector, erase_start, erase_size);
  return res;
}

static int
libmem_flush_impl(libmem_driver_handle_t *h)
{
  return libmem_driver_paged_write_flush(h, &paged_write_ctrlblk);
}

static const libmem_driver_functions_t driver_functions =
{
  libmem_write_impl,
  0,
  libmem_erase_impl,
  0,
  0,
  libmem_flush_impl
};

static const libmem_geometry_t geometry[] =
{
  { MXC_FLASH_MEM_SIZE/MXC_FLASH_PAGE_SIZE, MXC_FLASH_MEM_SIZE },
  { 0, 0 }
};

int
libmem_max32660_register_internal_flash_driver(libmem_driver_handle_t *h)
{
  MXC_FLC->clkdiv = SystemCoreClock / 1000000;
  libmem_register_driver(h, (uint8_t *)0, libmem_get_geometry_size(geometry), geometry, 0, &driver_functions, 0);
  libmem_driver_paged_write_init(&paged_write_ctrlblk, write_buffer, sizeof(write_buffer), flash_write_page, 16, 0);
  return LIBMEM_STATUS_SUCCESS;
}
