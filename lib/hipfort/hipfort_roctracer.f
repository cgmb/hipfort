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

module hipfort_roctracer

  interface roctracer_version_major
    function roctracer_version_major_() bind(c, name="roctracer_version_major")
      use iso_c_binding
      implicit none
      integer(c_int32_t) :: roctracer_version_major_
    end function
  end interface

  interface roctracer_version_minor
    function roctracer_version_minor_() bind(c, name="roctracer_version_minor")
      use iso_c_binding
      implicit none
      integer(c_int32_t) :: roctracer_version_minor_
    end function
  end interface

  interface roctracer_error_string
    function roctracer_error_string_() bind(c, name="roctracer_error_string")
      use iso_c_binding
      implicit none
      type(c_ptr) :: roctracer_error_string_
    end function
  end interface

  interface roctracer_op_string
    function roctracer_op_string_(domain, op, kind_) bind(c, name="roctracer_op_string")
      use iso_c_binding
      implicit none
      type(c_ptr) :: roctracer_op_string_
      integer(c_int32_t) :: domain
      integer(c_int32_t) :: op
      integer(c_int32_t) :: kind_
    end function
  end interface

  interface roctracer_op_code
    function roctracer_op_code_(domain, str, op, kind_) bind(c, name="roctracer_op_code")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_op_code_
      integer(c_int32_t) :: domain
      character(kind=c_char) :: str(*)
      character(kind=c_char) :: op(*)
      integer(c_int32_t) :: kind_
    end function
  end interface

  interface roctracer_set_properties
    function roctracer_set_properties_(domain, properties) bind(c, name="roctracer_set_properties")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_set_properties_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_ptr),value :: properties
    end function
  end interface

  interface roctracer_enable_op_callback
    function roctracer_enable_op_callback_(domain, op, callback, arg) bind(c, name="roctracer_enable_op_callback")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_op_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_ptr),value :: op
      type(c_funptr),value :: callback
      type(c_ptr),value :: arg
    end function
  end interface

  interface roctracer_enable_domain_callback
    function roctracer_enable_domain_callback_(domain, callback, arg) bind(c, name="roctracer_enable_domain_callback")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_domain_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_funptr),value :: callback
      type(c_ptr),value :: arg
    end function
  end interface

  interface roctracer_disable_op_callback
    function roctracer_disable_op_callback_(domain, op) bind(c, name="roctracer_disable_op_callback")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_disable_op_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_ptr),value :: op
    end function
  end interface

  interface roctracer_disable_domain_callback
    function roctracer_disable_domain_callback_(domain, callback, arg) bind(c, name="roctracer_disable_domain_callback")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_disable_domain_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_funptr),value :: callback
      type(c_ptr),value :: arg
    end function
  end interface

  interface roctracer_next_record
    function roctracer_next_record_(domain, record, next) bind(c, name="roctracer_next_record")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_next_record_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_ptr),value :: record
      type(c_ptr),value :: next
    end function
  end interface

  interface roctracer_open_pool_expl
    function roctracer_open_pool_expl_(properties, pool) bind(c, name="roctracer_open_pool_expl")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_open_pool_expl_
      type(c_ptr),value :: properties
      type(c_ptr),value :: pool
    end function
  end interface

  interface roctracer_close_pool_expl
    function roctracer_close_pool_expl_(properties) bind(c, name="roctracer_close_pool_expl")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_close_pool_expl_
      type(c_ptr),value :: properties
    end function
  end interface

  interface roctracer_close_pool
    function roctracer_close_pool_() bind(c, name="roctracer_close_pool")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_close_pool_
    end function
  end interface

  interface roctracer_default_pool_expl
    function roctracer_default_pool_expl_(pool) bind(c, name="roctracer_default_pool_expl")
      use iso_c_binding
      implicit none
      type(c_ptr) :: roctracer_default_pool_expl_
      type(c_ptr),value :: pool
    end function
  end interface

  interface roctracer_default_pool
    function roctracer_default_pool_() bind(c, name="roctracer_default_pool")
      use iso_c_binding
      implicit none
      type(c_ptr) :: roctracer_default_pool_
    end function
  end interface

  interface roctracer_enable_op_activity_expl
    function roctracer_enable_op_activity_expl_(domain, op, pool) bind(c, name="roctracer_enable_op_activity_expl")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_op_activity_expl_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      integer(c_int32_t),value :: op
      type(c_ptr),value :: pool
    end function
  end interface

  interface roctracer_enable_op_activity
    function roctracer_enable_op_activity_(domain, op) bind(c, name="roctracer_enable_op_activity")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_op_activity_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      integer(c_int32_t),value :: op
    end function
  end interface

  interface roctracer_enable_domain_activity_expl
    function roctracer_enable_domain_activity_expl_(domain, pool) bind(c, name="roctracer_enable_domain_activity_expl")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_domain_activity_expl_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_ptr),value :: pool
    end function
  end interface

  interface roctracer_enable_domain_activity
    function roctracer_enable_domain_activity_(domain) bind(c, name="roctracer_enable_domain_activity")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_domain_activity_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
    end function
  end interface

  interface roctracer_disable_op_activity
    function roctracer_disable_op_activity_(domain, op) bind(c, name="roctracer_disable_op_activity")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_disable_op_activity_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      integer(c_int32_t),value :: op
    end function
  end interface

  interface roctracer_disable_domain_activity
    function roctracer_disable_domain_activity_(domain, op) bind(c, name="roctracer_disable_domain_activity")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_disable_domain_activity_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      integer(c_int32_t),value :: op
    end function
  end interface

  interface roctracer_flush_activity_expl
    function roctracer_flush_activity_expl_(pool) bind(c, name="roctracer_flush_activity_expl")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_flush_activity_expl_
      type(c_ptr),value :: pool
    end function
  end interface

  interface roctracer_flush_activity
    function roctracer_flush_activity_() bind(c, name="roctracer_flush_activity")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_flush_activity_
    end function
  end interface

  interface roctracer_get_timestamp
    function roctracer_get_timestamp_(timestamp) bind(c, name="roctracer_get_timestamp")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_get_timestamp_
      integer(c_int64_t) :: timestamp
    end function
  end interface

  interface roctracer_start
    subroutine roctracer_start_() bind(c, name="roctracer_start")
      use iso_c_binding
      implicit none
    end subroutine
  end interface

  interface roctracer_stop
    subroutine roctracer_stop_() bind(c, name="roctracer_stop")
      use iso_c_binding
      implicit none
    end subroutine
  end interface

  interface roctracer_activity_push_external_correlation_id
    function roctracer_activity_push_external_correlation_id_(id) bind(c, name="roctracer_activity_push_external_correlation_id")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_activity_push_external_correlation_id_
      integer(c_int64_t),value :: id
    end function
  end interface

  interface roctracer_activity_pop_external_correlation_id
    function roctracer_activity_pop_external_correlation_id_(last_id) bind(c, name="roctracer_activity_pop_external_correlation_id")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_activity_pop_external_correlation_id_
      type(c_ptr),value :: last_id
    end function
  end interface

  interface roctracer_plugin_initialize
    function roctracer_plugin_initialize_(roctracer_major_version, roctracer_minor_version) bind(c, name="roctracer_plugin_initialize")
      use iso_c_binding
      use hipfort_roctracer_enums
      implicit none
      integer(c_int) :: roctracer_plugin_initialize_
      integer(c_int32_t) :: roctracer_major_version
      integer(c_int32_t) :: roctracer_minor_version
    end function
  end interface

  interface roctracer_plugin_finalize
    subroutine roctracer_plugin_finalize_() bind(c, name="roctracer_plugin_finalize")
      use iso_c_binding
      implicit none
    end subroutine
  end interface

  interface roctracer_plugin_write_callback_record
    function roctracer_plugin_write_callback_record_(record, callback_data) bind(c, name="roctracer_plugin_write_callback_record")
      use iso_c_binding
      implicit none
      integer(c_int) :: roctracer_plugin_write_callback_record_
      type(c_ptr) :: record
      type(c_ptr) :: callback_data
    end function
  end interface

  interface roctracer_plugin_write_activity_records
    function roctracer_plugin_write_activity_records_(begin, end) bind(c, name="roctracer_plugin_write_activity_records")
      use iso_c_binding
      implicit none
      integer(c_int) :: roctracer_plugin_write_activity_records_
      type(c_ptr) :: begin
      type(c_ptr) :: end
    end function
  end interface

end module hipfort_roctracer
