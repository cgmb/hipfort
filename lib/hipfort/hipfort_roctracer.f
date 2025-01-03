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

! ROCTRACER_API uint32_t roctracer_version_major() ROCTRACER_VERSION_4_1;
! ROCTRACER_API uint32_t roctracer_version_minor() ROCTRACER_VERSION_4_1;
! typedef enum {
!   ROCTRACER_STATUS_SUCCESS = 0,
!   ROCTRACER_STATUS_ERROR = -1,
!   ROCTRACER_STATUS_ERROR_INVALID_DOMAIN_ID = -2,
!   ROCTRACER_STATUS_ERROR_INVALID_ARGUMENT = -3,
!   ROCTRACER_STATUS_ERROR_DEFAULT_POOL_UNDEFINED = -4,
!   ROCTRACER_STATUS_ERROR_DEFAULT_POOL_ALREADY_DEFINED = -5,
!   ROCTRACER_STATUS_ERROR_MEMORY_ALLOCATION = -6,
!   ROCTRACER_STATUS_ERROR_MISMATCHED_EXTERNAL_CORRELATION_ID = -7,
!   ROCTRACER_STATUS_ERROR_NOT_IMPLEMENTED = -8,
!   ROCTRACER_STATUS_UNINIT = 2,
!   ROCTRACER_STATUS_BREAK = 3,
!   ROCTRACER_STATUS_BAD_DOMAIN = ROCTRACER_STATUS_ERROR_INVALID_DOMAIN_ID,
!   ROCTRACER_STATUS_BAD_PARAMETER = ROCTRACER_STATUS_ERROR_INVALID_ARGUMENT,
!   ROCTRACER_STATUS_HIP_API_ERR = 6,
!   ROCTRACER_STATUS_HIP_OPS_ERR = 7,
!   ROCTRACER_STATUS_HCC_OPS_ERR = ROCTRACER_STATUS_HIP_OPS_ERR,
!   ROCTRACER_STATUS_HSA_ERR = 7,
!   ROCTRACER_STATUS_ROCTX_ERR = 8,
! } roctracer_status_t;
! ROCTRACER_API const char* roctracer_error_string() ROCTRACER_VERSION_4_1;
! typedef activity_domain_t roctracer_domain_t;
! ROCTRACER_API const char* roctracer_op_string(
!     uint32_t domain, uint32_t op, uint32_t kind) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t
! roctracer_op_code(uint32_t domain, const char* str, uint32_t* op,
!                   uint32_t* kind) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_set_properties(
!     roctracer_domain_t domain, void* properties) ROCTRACER_VERSION_4_1;
! typedef activity_rtapi_callback_t roctracer_rtapi_callback_t;
! ROCTRACER_API roctracer_status_t roctracer_enable_op_callback(
!     activity_domain_t domain, uint32_t op, activity_rtapi_callback_t callback,
!     void* arg) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_enable_domain_callback(
!     activity_domain_t domain, activity_rtapi_callback_t callback,
!     void* arg) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_disable_op_callback(
!     activity_domain_t domain, uint32_t op) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_disable_domain_callback(
!     activity_domain_t domain) ROCTRACER_VERSION_4_1;
! typedef activity_record_t roctracer_record_t;
! ROCTRACER_API roctracer_status_t
! roctracer_next_record(const activity_record_t* record,
!                       const activity_record_t** next) ROCTRACER_VERSION_4_1;
! typedef void (*roctracer_allocator_t)(char** ptr, size_t size, void* arg);
! typedef void (*roctracer_buffer_callback_t)(const char* begin, const char* end,
!                                             void* arg);
! typedef struct {
!   uint32_t mode;
!   size_t buffer_size;
!   roctracer_allocator_t alloc_fun;
!   void* alloc_arg;
!   roctracer_buffer_callback_t buffer_callback_fun;
!   void* buffer_callback_arg;
! } roctracer_properties_t;
! typedef void roctracer_pool_t;
! ROCTRACER_API roctracer_status_t
! roctracer_open_pool_expl(const roctracer_properties_t* properties,
!                          roctracer_pool_t** pool) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_open_pool(
!     const roctracer_properties_t* properties) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t
! roctracer_close_pool_expl(roctracer_pool_t* pool) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_close_pool() ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_pool_t* roctracer_default_pool_expl(
!     roctracer_pool_t* pool) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_pool_t* roctracer_default_pool() ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_enable_op_activity_expl(
!     activity_domain_t domain, uint32_t op,
!     roctracer_pool_t* pool) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_enable_op_activity(
!     activity_domain_t domain, uint32_t op) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_enable_domain_activity_expl(
!     activity_domain_t domain, roctracer_pool_t* pool) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_enable_domain_activity(
!     activity_domain_t domain) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_disable_op_activity(
!     activity_domain_t domain, uint32_t op) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_disable_domain_activity(
!     activity_domain_t domain) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t
! roctracer_flush_activity_expl(roctracer_pool_t* pool) ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_flush_activity()
!     ROCTRACER_VERSION_4_1;
! ROCTRACER_API roctracer_status_t roctracer_get_timestamp(
!     roctracer_timestamp_t* timestamp) ROCTRACER_VERSION_4_1;
! 
! ! roctracer_ext
! typedef enum {
!   ACTIVITY_EXT_OP_MARK = 0,
!   ACTIVITY_EXT_OP_EXTERN_ID = 1
! } activity_ext_op_t;
! 
! typedef void (*roctracer_start_cb_t)();
! typedef void (*roctracer_stop_cb_t)();
! typedef struct {
!   roctracer_start_cb_t start_cb;
!   roctracer_stop_cb_t stop_cb;
! } roctracer_ext_properties_t;
! typedef struct {
!   roctracer_start_cb_t start_cb;
!   roctracer_stop_cb_t stop_cb;
! } roctracer_ext_properties_t;
! void ROCTRACER_API roctracer_start() ROCTRACER_VERSION_4_1;
! void ROCTRACER_API roctracer_stop() ROCTRACER_VERSION_4_1;
! roctracer_status_t ROCTRACER_API
! roctracer_activity_push_external_correlation_id(activity_correlation_id_t id)
!     ROCTRACER_VERSION_4_1;
! roctracer_status_t ROCTRACER_API
! roctracer_activity_pop_external_correlation_id(
!     activity_correlation_id_t* last_id) ROCTRACER_VERSION_4_1;
! typedef enum {
!   HIP_OP_ID_DISPATCH = 0,
!   HIP_OP_ID_COPY = 1,
!   HIP_OP_ID_BARRIER = 2,
!   HIP_OP_ID_NUMBER = 3
! } hip_op_id_t;
! enum hsa_op_id_t {
!   HSA_OP_ID_DISPATCH = 0,
!   HSA_OP_ID_COPY = 1,
!   HSA_OP_ID_BARRIER = 2,
!   HSA_OP_ID_RESERVED1 = 3,
!   HSA_OP_ID_NUMBER
! };
! 
! // HSA EVT ID enumeration
! enum hsa_evt_id_t {
!   HSA_EVT_ID_ALLOCATE = 0,  // Memory allocate callback
!   HSA_EVT_ID_DEVICE = 1,    // Device assign callback
!   HSA_EVT_ID_MEMCOPY = 2,   // Memcopy callback
!   HSA_EVT_ID_SUBMIT = 3,    // Packet submission callback
!   HSA_EVT_ID_KSYMBOL = 4,   // Loading/unloading of kernel symbol
!   HSA_EVT_ID_CODEOBJ = 5,   // Loading/unloading of device code object
!   HSA_EVT_ID_NUMBER
! };
! 
! struct hsa_ops_properties_t {
!   void* reserved1[4];
! };
! 
! // HSA EVT data type
! typedef struct {
!   union {
!     struct {
!       const void* ptr;  // allocated area ptr
!       size_t size;      // allocated area size, zero size means 'free' callback
!       hsa_amd_segment_t segment;  // allocated area's memory segment type
!       hsa_amd_memory_pool_global_flag_t
!           global_flag;  // allocated area's memory global flag
!       int is_code;      // equal to 1 if code is allocated
!     } allocate;
! 
!     struct {
!       hsa_device_type_t type;  // type of assigned device
!       uint32_t id;             // id of assigned device
!       hsa_agent_t agent;       // device HSA agent handle
!       const void* ptr;         // ptr the device is assigned to
!     } device;
! 
!     struct {
!       const void* dst;  // memcopy dst ptr
!       const void* src;  // memcopy src ptr
!       size_t size;      // memcopy size bytes
!     } memcopy;
! 
!     struct {
!       const void* packet;  // submitted to GPU packet
!       const char*
!           kernel_name;     // kernel name, NULL if not a kernel dispatch packet
!       hsa_queue_t* queue;  // HSA queue the packet was submitted to
!       uint32_t device_type;  // type of device the packet is submitted to
!       uint32_t device_id;    // id of device the packet is submitted to
!     } submit;
! 
!     struct {
!       uint64_t object;       // kernel symbol object
!       const char* name;      // kernel symbol name
!       uint32_t name_length;  // kernel symbol name length
!       int unload;            // symbol executable destroy
!     } ksymbol;
! 
!     struct {
!       uint32_t storage_type;  // code object storage type
!       int storage_file;       // origin file descriptor
!       uint64_t memory_base;   // origin memory base
!       uint64_t memory_size;   // origin memory size
!       uint64_t load_base;     // code object load base
!       uint64_t load_size;     // code object load size
!       uint64_t load_delta;    // code object load size
!       uint32_t uri_length;  // URI string length (not including the terminating
!                             // NUL character)
!       const char* uri;      // URI string
!       int unload;           // unload flag
!     } codeobj;
!   };
! } hsa_evt_data_t;
! 
! enum roctx_api_id_t {
!   ROCTX_API_ID_roctxMarkA = 0,
!   ROCTX_API_ID_roctxRangePushA = 1,
!   ROCTX_API_ID_roctxRangePop = 2,
!   ROCTX_API_ID_roctxRangeStartA = 3,
!   ROCTX_API_ID_roctxRangeStop = 4,
!   ROCTX_API_ID_NUMBER,
! };
! 
! /**
!  *  ROCTX callbacks data type
!  */
! typedef struct roctx_api_data_s {
!   union {
!     struct {
!       const char* message;
!       roctx_range_id_t id;
!     };
!     struct {
!       const char* message;
!     } roctxMarkA;
!     struct {
!       const char* message;
!     } roctxRangePushA;
!     struct {
!       const char* message;
!     } roctxRangePop;
!     struct {
!       const char* message;
!       roctx_range_id_t id;
!     } roctxRangeStartA;
!     struct {
!       const char* message;
!       roctx_range_id_t id;
!     } roctxRangeStop;
!   } args;
! } roctx_api_data_t;
! 
! ROCTRACER_EXPORT int roctracer_plugin_initialize(
!     uint32_t roctracer_major_version, uint32_t roctracer_minor_version);
! ROCTRACER_EXPORT void roctracer_plugin_finalize();
! ROCTRACER_EXPORT int roctracer_plugin_write_callback_record(
!     const roctracer_record_t* record, const void* callback_data);
! ROCTRACER_EXPORT int roctracer_plugin_write_activity_records(
!     const roctracer_record_t* begin, const roctracer_record_t* end);
! typedef enum {
!   ACTIVITY_DOMAIN_HSA_API = 0, /* HSA API domain */
!   ACTIVITY_DOMAIN_HSA_OPS = 1, /* HSA async activity domain */
!   ACTIVITY_DOMAIN_HIP_OPS = 2, /* HIP async activity domain */
!   ACTIVITY_DOMAIN_HCC_OPS =
!       ACTIVITY_DOMAIN_HIP_OPS, /* HCC async activity domain */
!   ACTIVITY_DOMAIN_HIP_VDI =
!       ACTIVITY_DOMAIN_HIP_OPS, /* HIP VDI async activity domain */
!   ACTIVITY_DOMAIN_HIP_API = 3, /* HIP API domain */
!   ACTIVITY_DOMAIN_KFD_API = 4, /* KFD API domain */
!   ACTIVITY_DOMAIN_EXT_API = 5, /* External ID domain */
!   ACTIVITY_DOMAIN_ROCTX = 6,   /* ROCTX domain */
!   ACTIVITY_DOMAIN_HSA_EVT = 7, /* HSA events */
!   ACTIVITY_DOMAIN_NUMBER
! } activity_domain_t;
! 
! /* API callback type */
! typedef void (*activity_rtapi_callback_t)(uint32_t domain, uint32_t cid,
!                                           const void* data, void* arg);
! typedef uint32_t activity_kind_t;
! typedef uint32_t activity_op_t;
! 
! /* API callback phase */
! typedef enum {
!   ACTIVITY_API_PHASE_ENTER = 0,
!   ACTIVITY_API_PHASE_EXIT = 1
! } activity_api_phase_t;
! 
! /* Trace record types */
! 
! /* Correlation id */
! typedef uint64_t activity_correlation_id_t;
! 
! /* Timestamp in nanoseconds */
! typedef uint64_t roctracer_timestamp_t;
! 
! /* Activity record type */
! typedef struct activity_record_s {
!   uint32_t domain;      /* activity domain id */
!   activity_kind_t kind; /* activity kind */
!   activity_op_t op;     /* activity op */
!   union {
!     struct {
!       activity_correlation_id_t correlation_id; /* activity ID */
!       roctracer_timestamp_t begin_ns;           /* host begin timestamp */
!       roctracer_timestamp_t end_ns;             /* host end timestamp */
!     };
!     struct {
!       uint32_t se;    /* sampled SE */
!       uint64_t cycle; /* sample cycle */
!       uint64_t pc;    /* sample PC */
!     } pc_sample;
!   };
!   union {
!     struct {
!       int device_id;     /* device id */
!       uint64_t queue_id; /* queue id */
!     };
!     struct {
!       uint32_t process_id; /* device id */
!       uint32_t thread_id;  /* thread id */
!     };
!     struct {
!       activity_correlation_id_t external_id; /* external correlation id */
!     };
!   };
!   union {
!     size_t bytes;            /* data size bytes */
!     const char* kernel_name; /* kernel name */
!     const char* mark_message;
!   };
! } activity_record_t;
! 
! /* Activity sync callback type */
! typedef void (*activity_sync_callback_t)(uint32_t cid, activity_record_t* record, const void* data,
!                                          void* arg);
! /* Activity async callback type */
! typedef void (*activity_async_callback_t)(uint32_t op, void* record, void* arg);
! 

! ROCTRACER_API uint32_t () ROCTRACER_VERSION_4_1;
! ROCTRACER_API uint32_t roctracer_version_minor() ROCTRACER_VERSION_4_1;

  interface roctracer_version_major
    function roctracer_version_major_() bind(c, name="roctracer_version_major")
      use iso_c_binding
      implicit none
      integer(C_INT32_T) :: roctracer_version_major_
    end function
  end interface

  interface roctracer_version_minor
    function roctracer_version_minor_() bind(c, name="roctracer_version_minor")
      use iso_c_binding
      implicit none
      integer(C_INT32_T) :: roctracer_version_minor_
    end function
  end interface

  interface roctracer_error_string
    function roctracer_error_string_() bind(c, name="roctracer_error_string")
      use iso_c_binding
      implicit none
      type(c_ptr),value :: roctracer_error_string_
    end function
  end interface

  interface roctracer_op_string
    function roctracer_op_string_() bind(c, name="roctracer_op_string")
      use iso_c_binding
      implicit none
      type(c_ptr),value :: roctracer_op_string_
      integer(C_INT32_T) :: domain
      integer(C_INT32_T) :: op
      integer(C_INT32_T) :: kind
    end function
  end interface

  interface roctracer_op_code
    function roctracer_op_code_() bind(c, name="roctracer_op_code")
      use iso_c_binding
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_op_code_
      integer(C_INT32_T) :: domain
      type(c_ptr),value :: str
      integer(c_ptr),value :: op
      integer(C_INT32_T),value :: kind
    end function
  end interface

  interface roctracer_set_properties
    function roctracer_op_code_() bind(c, name="roctracer_set_properties")
      use iso_c_binding
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_set_properties_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_ptr),value :: properties
    end function
  end interface

  interface roctracer_enable_op_callback
    function roctracer_op_code_() bind(c, name="roctracer_enable_op_callback")
      use iso_c_binding
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_op_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      integer(c_ptr),value :: op
      type(c_funptr),value :: callback
      type(c_ptr),value :: arg
    end function
  end interface

  interface roctracer_enable_domain_callback
    function roctracer_op_code_() bind(c, name="roctracer_enable_domain_callback")
      use iso_c_binding
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_enable_domain_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_funptr),value :: callback
      type(c_ptr),value :: arg
    end function
  end interface

  interface roctracer_disable_op_callback
    function roctracer_op_code_() bind(c, name="roctracer_disable_op_callback")
      use iso_c_binding
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_disable_op_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      integer(c_ptr),value :: op
    end function
  end interface

  interface roctracer_disable_domain_callback
    function roctracer_op_code_() bind(c, name="roctracer_disable_domain_callback")
      use iso_c_binding
      implicit none
      integer(kind(ROCTRACER_STATUS_SUCCESS)) :: roctracer_disable_domain_callback_
      integer(kind(ACTIVITY_DOMAIN_HSA_API)) :: domain
      type(c_funptr),value :: callback
      type(c_ptr),value :: arg
    end function
  end interface

end module hipfort_roctracer
