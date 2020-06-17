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

#ifndef libmem_max32660_h
#define libmem_max32660_h

#include <libmem.h>

/*! \brief Register a libmem driver for MAX32660 internal FLASH.
 *  \param h Pointer to libmem driver handle.
 *  \return The LIBMEM status result.
 */
int libmem_max32660_register_internal_flash_driver(libmem_driver_handle_t *h);

#endif
