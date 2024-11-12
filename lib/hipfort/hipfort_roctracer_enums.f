!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! ==============================================================================
! hipfort: FORTRAN Interfaces for GPU kernels
! ==============================================================================
! Copyright (c) 2024 Advanced Micro Devices, Inc. All rights reserved.
! [MITx11 License]
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
!
! The above copyright notice and this permission notice shall be included in
! all copies or substantial portions of the Software.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
! THE SOFTWARE.
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module hipfort_roctracer_enums
  implicit none

  enum, bind(c)
    enumerator :: ROCTRACER_STATUS_SUCCESS = 0
    enumerator :: ROCTRACER_STATUS_ERROR  = -1
    enumerator :: ROCTRACER_STATUS_ERROR_INVALID_DOMAIN_ID = -2
    enumerator :: ROCTRACER_STATUS_ERROR_INVALID_ARGUMENT = -3
    enumerator :: ROCTRACER_STATUS_ERROR_DEFAULT_POOL_UNDEFINED = -4
    enumerator :: ROCTRACER_STATUS_ERROR_DEFAULT_POOL_ALREADY_DEFINED = -5
    enumerator :: ROCTRACER_STATUS_ERROR_MEMORY_ALLOCATION = -6
    enumerator :: ROCTRACER_STATUS_ERROR_MISMATCHED_EXTERNAL_CORRELATION_ID = -7
    enumerator :: ROCTRACER_STATUS_ERROR_NOT_IMPLEMENTED = -8
    enumerator :: ROCTRACER_STATUS_UNINIT = 2
    enumerator :: ROCTRACER_STATUS_BREAK = 3
    enumerator :: ROCTRACER_STATUS_BAD_DOMAIN = -2
    enumerator :: ROCTRACER_STATUS_BAD_PARAMETER = -3
    enumerator :: ROCTRACER_STATUS_HIP_API_ERR = 6
    enumerator :: ROCTRACER_STATUS_HIP_OPS_ERR = 7
    enumerator :: ROCTRACER_STATUS_HCC_OPS_ERR = 7
    enumerator :: ROCTRACER_STATUS_HSA_ERR = 7
    enumerator :: ROCTRACER_STATUS_ROCTX_ERR = 8
  end enum

  enum, bind(c)
    enumerator :: ACTIVITY_EXT_OP_MARK = 0
    enumerator :: ACTIVITY_EXT_OP_EXTERN_ID = 1
  end enum

  enum, bind(c)
    enumerator :: HIP_OP_ID_DISPATCH = 0
    enumerator :: HIP_OP_ID_COPY = 1
    enumerator :: HIP_OP_ID_BARRIER = 2
    enumerator :: HIP_OP_ID_NUMBER = 3
  end enum

  enum, bind(c)
    enumerator :: HSA_OP_ID_DISPATCH = 0
    enumerator :: HSA_OP_ID_COPY = 1
    enumerator :: HSA_OP_ID_BARRIER = 2
    enumerator :: HSA_OP_ID_RESERVED1 = 3
    enumerator :: HSA_OP_ID_NUMBER = 4
  end enum

  enum, bind(c)
    enumerator :: HSA_EVT_ID_ALLOCATE = 0
    enumerator :: HSA_EVT_ID_DEVICE = 1
    enumerator :: HSA_EVT_ID_MEMCOPY = 2
    enumerator :: HSA_EVT_ID_SUBMIT = 3
    enumerator :: HSA_EVT_ID_KSYMBOL = 4
    enumerator :: HSA_EVT_ID_CODEOBJ = 5
    enumerator :: HSA_EVT_ID_NUMBER = 6
  end enum

  enum, bind(c)
    enumerator :: ROCTX_API_ID_roctxMarkA = 0
    enumerator :: ROCTX_API_ID_roctxRangePushA = 1
    enumerator :: ROCTX_API_ID_roctxRangePop = 2
    enumerator :: ROCTX_API_ID_roctxRangeStartA = 3
    enumerator :: ROCTX_API_ID_roctxRangeStop = 4
    enumerator :: ROCTX_API_ID_NUMBER = 5
  end enum

  enum, bind(c)
    enumerator :: ACTIVITY_DOMAIN_HSA_API = 0
    enumerator :: ACTIVITY_DOMAIN_HSA_OPS = 1
    enumerator :: ACTIVITY_DOMAIN_HIP_OPS = 2
    enumerator :: ACTIVITY_DOMAIN_HCC_OPS = 2
    enumerator :: ACTIVITY_DOMAIN_HIP_VDI = 2
    enumerator :: ACTIVITY_DOMAIN_HIP_API = 3
    enumerator :: ACTIVITY_DOMAIN_KFD_API = 4
    enumerator :: ACTIVITY_DOMAIN_EXT_API = 5
    enumerator :: ACTIVITY_DOMAIN_ROCTX = 6
    enumerator :: ACTIVITY_DOMAIN_HSA_EVT = 7
    enumerator :: ACTIVITY_DOMAIN_NUMBER = 8
  end enum

  enum, bind(c)
    enumerator :: ACTIVITY_API_PHASE_ENTER = 0
    enumerator :: ACTIVITY_API_PHASE_EXIT = 1
  end enum

end module hipfort_roctracer_enums
