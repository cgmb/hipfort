!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! ==============================================================================
! hipfort: FORTRAN Interfaces for GPU kernels
! ==============================================================================
! Copyright (c) 2021 Advanced Micro Devices, Inc. All rights reserved.
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
          
           
module hipfort_rocsparse
  use hipfort_rocsparse_enums
  implicit none

 
  !> ! \ingroup aux_module
  !>    \brief Create a rocsparse handle
  !>  
  !>    \details
  !>    \p rocsparse_create_handle creates the rocSPARSE library context. It must be
  !>    initialized before any other rocSPARSE API function is invoked and must be passed to
  !>    all subsequent library function calls. The handle should be destroyed at the end
  !>    using rocsparse_destroy_handle().
  !>  
  !>    @param[out]
  !>    handle  the pointer to the handle to the rocSPARSE library context.
  !>  
  !>    \retval rocsparse_status_success the initialization succeeded.
  !>    \retval rocsparse_status_invalid_handle \p handle pointer is invalid.
  !>    \retval rocsparse_status_internal_error an internal error occurred.
  !>  
  interface rocsparse_create_handle
    function rocsparse_create_handle_(handle) bind(c, name="rocsparse_create_handle")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_handle_
      type(c_ptr) :: handle
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a rocsparse handle
  !>  
  !>    \details
  !>    \p rocsparse_destroy_handle destroys the rocSPARSE library context and releases all
  !>    resources used by the rocSPARSE library.
  !>  
  !>    @param[in]
  !>    handle  the handle to the rocSPARSE library context.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>    \retval rocsparse_status_internal_error an internal error occurred.
  !>  
  interface rocsparse_destroy_handle
    function rocsparse_destroy_handle_(handle) bind(c, name="rocsparse_destroy_handle")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_handle_
      type(c_ptr),value :: handle
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify user defined HIP stream
  !>  
  !>    \details
  !>    \p rocsparse_set_stream specifies the stream to be used by the rocSPARSE library
  !>    context and all subsequent function calls.
  !>  
  !>    @param[inout]
  !>    handle  the handle to the rocSPARSE library context.
  !>    @param[in]
  !>    stream  the stream to be used by the rocSPARSE library context.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>  
  !>    \par Example
  !>    This example illustrates, how a user defined stream can be used in rocSPARSE.
  !>    \code{.c}
  !>         Create rocSPARSE handle
  !>        rocsparse_handle handle;
  !>        rocsparse_create_handle(&handle);
  !>  
  !>         Create stream
  !>        hipStream_t stream;
  !>        hipStreamCreate(&stream);
  !>  
  !>         Set stream to rocSPARSE handle
  !>        rocsparse_set_stream(handle, stream);
  !>  
  !>         Do some work
  !>         ...
  !>  
  !>         Clean up
  !>        rocsparse_destroy_handle(handle);
  !>        hipStreamDestroy(stream);
  !>    \endcode
  !>  
  interface rocsparse_set_stream
    function rocsparse_set_stream_(handle,stream) bind(c, name="rocsparse_set_stream")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_stream_
      type(c_ptr),value :: handle
      type(c_ptr),value :: stream
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get current stream from library context
  !>  
  !>    \details
  !>    \p rocsparse_get_stream gets the rocSPARSE library context stream which is currently
  !>    used for all subsequent function calls.
  !>  
  !>    @param[in]
  !>    handle the handle to the rocSPARSE library context.
  !>    @param[out]
  !>    stream the stream currently used by the rocSPARSE library context.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>  
  interface rocsparse_get_stream
    function rocsparse_get_stream_(handle,stream) bind(c, name="rocsparse_get_stream")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_get_stream_
      type(c_ptr),value :: handle
      type(c_ptr) :: stream
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify pointer mode
  !>  
  !>    \details
  !>    \p rocsparse_set_pointer_mode specifies the pointer mode to be used by the rocSPARSE
  !>    library context and all subsequent function calls. By default, all values are passed
  !>    by reference on the host. Valid pointer modes are \ref rocsparse_pointer_mode_host
  !>    or \p rocsparse_pointer_mode_device.
  !>  
  !>    @param[in]
  !>    handle          the handle to the rocSPARSE library context.
  !>    @param[in]
  !>    pointer_mode    the pointer mode to be used by the rocSPARSE library context.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>  
  interface rocsparse_set_pointer_mode
    function rocsparse_set_pointer_mode_(handle,pointer_mode) bind(c, name="rocsparse_set_pointer_mode")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_pointer_mode_
      type(c_ptr),value :: handle
      integer(kind(rocsparse_pointer_mode_host)),value :: pointer_mode
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get current pointer mode from library context
  !>  
  !>    \details
  !>    \p rocsparse_get_pointer_mode gets the rocSPARSE library context pointer mode which
  !>    is currently used for all subsequent function calls.
  !>  
  !>    @param[in]
  !>    handle          the handle to the rocSPARSE library context.
  !>    @param[out]
  !>    pointer_mode    the pointer mode that is currently used by the rocSPARSE library
  !>                    context.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>  
  interface rocsparse_get_pointer_mode
    function rocsparse_get_pointer_mode_(handle,pointer_mode) bind(c, name="rocsparse_get_pointer_mode")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_get_pointer_mode_
      type(c_ptr),value :: handle
      type(c_ptr),value :: pointer_mode
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get rocSPARSE version
  !>  
  !>    \details
  !>    \p rocsparse_get_version gets the rocSPARSE library version number.
  !>    - patch = version % 100
  !>    - minor = version  100 % 1000
  !>    - major = version  100000
  !>  
  !>    @param[in]
  !>    handle  the handle to the rocSPARSE library context.
  !>    @param[out]
  !>    version the version number of the rocSPARSE library.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>  
  interface rocsparse_get_version
    function rocsparse_get_version_(handle,version) bind(c, name="rocsparse_get_version")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_get_version_
      type(c_ptr),value :: handle
      type(c_ptr),value :: version
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get rocSPARSE git revision
  !>  
  !>    \details
  !>    \p rocsparse_get_git_rev gets the rocSPARSE library git commit revision (SHA-1).
  !>  
  !>    @param[in]
  !>    handle  the handle to the rocSPARSE library context.
  !>    @param[out]
  !>    rev     the git commit revision (SHA-1).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_handle \p handle is invalid.
  !>  
  interface rocsparse_get_git_rev
    function rocsparse_get_git_rev_(handle,rev) bind(c, name="rocsparse_get_git_rev")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_get_git_rev_
      type(c_ptr),value :: handle
      type(c_ptr),value :: rev
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a matrix descriptor
  !>    \details
  !>    \p rocsparse_create_mat_descr creates a matrix descriptor. It initializes
  !>    \ref rocsparse_matrix_type to \ref rocsparse_matrix_type_general and
  !>    \ref rocsparse_index_base to \ref rocsparse_index_base_zero. It should be destroyed
  !>    at the end using rocsparse_destroy_mat_descr().
  !>  
  !>    @param[out]
  !>    descr   the pointer to the matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr pointer is invalid.
  !>  
  interface rocsparse_create_mat_descr
    function rocsparse_create_mat_descr_(descr) bind(c, name="rocsparse_create_mat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_mat_descr_
      type(c_ptr) :: descr
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Copy a matrix descriptor
  !>    \details
  !>    \p rocsparse_copy_mat_descr copies a matrix descriptor. Both, source and destination
  !>    matrix descriptors must be initialized prior to calling \p rocsparse_copy_mat_descr.
  !>  
  !>    @param[out]
  !>    dest    the pointer to the destination matrix descriptor.
  !>    @param[in]
  !>    src     the pointer to the source matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p src or \p dest pointer is invalid.
  !>  
  interface rocsparse_copy_mat_descr
    function rocsparse_copy_mat_descr_(dest,src) bind(c, name="rocsparse_copy_mat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_copy_mat_descr_
      type(c_ptr),value :: dest
      type(c_ptr),value :: src
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_destroy_mat_descr destroys a matrix descriptor and releases all
  !>    resources used by the descriptor.
  !>  
  !>    @param[in]
  !>    descr   the matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr is invalid.
  !>  
  interface rocsparse_destroy_mat_descr
    function rocsparse_destroy_mat_descr_(descr) bind(c, name="rocsparse_destroy_mat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_mat_descr_
      type(c_ptr),value :: descr
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify the index base of a matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_set_mat_index_base sets the index base of a matrix descriptor. Valid
  !>    options are \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one.
  !>  
  !>    @param[inout]
  !>    descr   the matrix descriptor.
  !>    @param[in]
  !>    base    \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr pointer is invalid.
  !>    \retval rocsparse_status_invalid_value \p base is invalid.
  !>  
  interface rocsparse_set_mat_index_base
    function rocsparse_set_mat_index_base_(descr,base) bind(c, name="rocsparse_set_mat_index_base")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_mat_index_base_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_index_base_zero)),value :: base
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify the matrix type of a matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_set_mat_type sets the matrix type of a matrix descriptor. Valid
  !>    matrix types are \ref rocsparse_matrix_type_general,
  !>    \ref rocsparse_matrix_type_symmetric, \ref rocsparse_matrix_type_hermitian or
  !>    \ref rocsparse_matrix_type_triangular.
  !>  
  !>    @param[inout]
  !>    descr   the matrix descriptor.
  !>    @param[in]
  !>    type    \ref rocsparse_matrix_type_general, \ref rocsparse_matrix_type_symmetric,
  !>            \ref rocsparse_matrix_type_hermitian or
  !>            \ref rocsparse_matrix_type_triangular.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr pointer is invalid.
  !>    \retval rocsparse_status_invalid_value \p type is invalid.
  !>  
  interface rocsparse_set_mat_type
    function rocsparse_set_mat_type_(descr,myType) bind(c, name="rocsparse_set_mat_type")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_mat_type_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_matrix_type_general)),value :: myType
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify the matrix fill mode of a matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_set_mat_fill_mode sets the matrix fill mode of a matrix descriptor.
  !>    Valid fill modes are \ref rocsparse_fill_mode_lower or
  !>    \ref rocsparse_fill_mode_upper.
  !>  
  !>    @param[inout]
  !>    descr       the matrix descriptor.
  !>    @param[in]
  !>    fill_mode   \ref rocsparse_fill_mode_lower or \ref rocsparse_fill_mode_upper.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr pointer is invalid.
  !>    \retval rocsparse_status_invalid_value \p fill_mode is invalid.
  !>  
  interface rocsparse_set_mat_fill_mode
    function rocsparse_set_mat_fill_mode_(descr,fill_mode) bind(c, name="rocsparse_set_mat_fill_mode")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_mat_fill_mode_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_fill_mode_lower)),value :: fill_mode
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify the matrix diagonal type of a matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_set_mat_diag_type sets the matrix diagonal type of a matrix
  !>    descriptor. Valid diagonal types are \ref rocsparse_diag_type_unit or
  !>    \ref rocsparse_diag_type_non_unit.
  !>  
  !>    @param[inout]
  !>    descr       the matrix descriptor.
  !>    @param[in]
  !>    diag_type   \ref rocsparse_diag_type_unit or \ref rocsparse_diag_type_non_unit.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr pointer is invalid.
  !>    \retval rocsparse_status_invalid_value \p diag_type is invalid.
  !>  
  interface rocsparse_set_mat_diag_type
    function rocsparse_set_mat_diag_type_(descr,diag_type) bind(c, name="rocsparse_set_mat_diag_type")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_mat_diag_type_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_diag_type_non_unit)),value :: diag_type
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Specify the matrix storage mode of a matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_set_mat_storage_mode sets the matrix storage mode of a matrix descriptor.
  !>    Valid fill modes are \ref rocsparse_storage_mode_sorted or
  !>    \ref rocsparse_storage_mode_unsorted.
  !>  
  !>    @param[inout]
  !>    descr           the matrix descriptor.
  !>    @param[in]
  !>    storage_mode    \ref rocsparse_storage_mode_sorted or
  !>                    \ref rocsparse_storage_mode_unsorted.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr pointer is invalid.
  !>    \retval rocsparse_status_invalid_value \p storage_mode is invalid.
  !>  
  interface rocsparse_set_mat_storage_mode
    function rocsparse_set_mat_storage_mode_(descr,storage_mode) bind(c, name="rocsparse_set_mat_storage_mode")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_set_mat_storage_mode_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_storage_mode_sorted)),value :: storage_mode
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a \p HYB matrix structure
  !>  
  !>    \details
  !>    \p rocsparse_create_hyb_mat creates a structure that holds the matrix in \p HYB
  !>    storage format. It should be destroyed at the end using rocsparse_destroy_hyb_mat().
  !>  
  !>    @param[inout]
  !>    hyb the pointer to the hybrid matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p hyb pointer is invalid.
  !>  
  interface rocsparse_create_hyb_mat
    function rocsparse_create_hyb_mat_(hyb) bind(c, name="rocsparse_create_hyb_mat")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_hyb_mat_
      type(c_ptr) :: hyb
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Copy a \p HYB matrix structure
  !>  
  !>    \details
  !>    \p rocsparse_copy_hyb_mat copies a matrix info structure. Both, source and destination
  !>    matrix info structure must be initialized prior to calling \p rocsparse_copy_hyb_mat.
  !>  
  !>    @param[out]
  !>    dest    the pointer to the destination matrix info structure.
  !>    @param[in]
  !>    src     the pointer to the source matrix info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p hyb pointer is invalid.
  !>  
  interface rocsparse_copy_hyb_mat
    function rocsparse_copy_hyb_mat_(dest,src) bind(c, name="rocsparse_copy_hyb_mat")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_copy_hyb_mat_
      type(c_ptr),value :: dest
      type(c_ptr),value :: src
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a \p HYB matrix structure
  !>  
  !>    \details
  !>    \p rocsparse_destroy_hyb_mat destroys a \p HYB structure.
  !>  
  !>    @param[in]
  !>    hyb the hybrid matrix structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p hyb pointer is invalid.
  !>    \retval rocsparse_status_internal_error an internal error occurred.
  !>  
  interface rocsparse_destroy_hyb_mat
    function rocsparse_destroy_hyb_mat_(hyb) bind(c, name="rocsparse_destroy_hyb_mat")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_hyb_mat_
      type(c_ptr),value :: hyb
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a matrix info structure
  !>  
  !>    \details
  !>    \p rocsparse_create_mat_info creates a structure that holds the matrix info data
  !>    that is gathered during the analysis routines available. It should be destroyed
  !>    at the end using rocsparse_destroy_mat_info().
  !>  
  !>    @param[inout]
  !>    info    the pointer to the info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p info pointer is invalid.
  !>  
  interface rocsparse_create_mat_info
    function rocsparse_create_mat_info_(myInfo) bind(c, name="rocsparse_create_mat_info")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_mat_info_
      type(c_ptr) :: myInfo
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Copy a matrix info structure
  !>    \details
  !>    \p rocsparse_copy_mat_info copies a matrix info structure. Both, source and destination
  !>    matrix info structure must be initialized prior to calling \p rocsparse_copy_mat_info.
  !>  
  !>    @param[out]
  !>    dest    the pointer to the destination matrix info structure.
  !>    @param[in]
  !>    src     the pointer to the source matrix info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p src or \p dest pointer is invalid.
  !>  
  interface rocsparse_copy_mat_info
    function rocsparse_copy_mat_info_(dest,src) bind(c, name="rocsparse_copy_mat_info")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_copy_mat_info_
      type(c_ptr),value :: dest
      type(c_ptr),value :: src
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a matrix info structure
  !>  
  !>    \details
  !>    \p rocsparse_destroy_mat_info destroys a matrix info structure.
  !>  
  !>    @param[in]
  !>    info    the info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p info pointer is invalid.
  !>    \retval rocsparse_status_internal_error an internal error occurred.
  !>  
  interface rocsparse_destroy_mat_info
    function rocsparse_destroy_mat_info_(myInfo) bind(c, name="rocsparse_destroy_mat_info")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_mat_info_
      type(c_ptr),value :: myInfo
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a color info structure
  !>  
  !>    \details
  !>    \p rocsparse_create_color_info creates a structure that holds the color info data
  !>    that is gathered during the analysis routines available. It should be destroyed
  !>    at the end using rocsparse_destroy_color_info().
  !>  
  !>    @param[inout]
  !>    info    the pointer to the info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p info pointer is invalid.
  !>  
  interface rocsparse_create_color_info
    function rocsparse_create_color_info_(myInfo) bind(c, name="rocsparse_create_color_info")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_color_info_
      type(c_ptr) :: myInfo
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Copy a color info structure
  !>    \details
  !>    \p rocsparse_copy_color_info copies a color info structure. Both, source and destination
  !>    color info structure must be initialized prior to calling \p rocsparse_copy_color_info.
  !>  
  !>    @param[out]
  !>    dest    the pointer to the destination color info structure.
  !>    @param[in]
  !>    src     the pointer to the source color info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p src or \p dest pointer is invalid.
  !>  
  interface rocsparse_copy_color_info
    function rocsparse_copy_color_info_(dest,src) bind(c, name="rocsparse_copy_color_info")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_copy_color_info_
      type(c_ptr),value :: dest
      type(c_ptr),value :: src
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a color info structure
  !>  
  !>    \details
  !>    \p rocsparse_destroy_color_info destroys a color info structure.
  !>  
  !>    @param[in]
  !>    info    the info structure.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p info pointer is invalid.
  !>    \retval rocsparse_status_internal_error an internal error occurred.
  !>  
  interface rocsparse_destroy_color_info
    function rocsparse_destroy_color_info_(myInfo) bind(c, name="rocsparse_destroy_color_info")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_color_info_
      type(c_ptr),value :: myInfo
    end function


  end interface
  !> @{
  interface rocsparse_create_spvec_descr
    function rocsparse_create_spvec_descr_(descr,mySize,nnz,indices,values,idx_type,idx_base,data_type) bind(c, name="rocsparse_create_spvec_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_spvec_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: mySize
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: indices
      type(c_ptr),value :: values
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  
  interface rocsparse_create__spvec_descr
    function rocsparse_create__spvec_descr_(descr,mySize,nnz,indices,values,idx_type,idx_base,data_type) bind(c, name="rocsparse_create__spvec_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__spvec_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: mySize
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: indices
      type(c_ptr),value :: values
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a sparse vector descriptor
  !>  
  !>    \details
  !>    \p rocsparse_destroy_spvec_descr destroys a sparse vector descriptor and releases all
  !>    resources used by the descriptor.
  !>  
  !>    @param[in]
  !>    descr   the matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr is invalid.
  !>  
  interface rocsparse_destroy_spvec_descr
    function rocsparse_destroy_spvec_descr_(descr) bind(c, name="rocsparse_destroy_spvec_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_spvec_descr_
      type(c_ptr),value :: descr
    end function


  end interface
  !> @{
  interface rocsparse_spvec_get
    function rocsparse_spvec_get_(descr,mySize,nnz,indices,values,idx_type,idx_base,data_type) bind(c, name="rocsparse_spvec_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spvec_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: mySize
      type(c_ptr),value :: nnz
      type(c_ptr) :: indices
      type(c_ptr) :: values
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__spvec_get
    function rocsparse__spvec_get_(descr,mySize,nnz,indices,values,idx_type,idx_base,data_type) bind(c, name="rocsparse__spvec_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__spvec_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: mySize
      type(c_ptr),value :: nnz
      type(c_ptr) :: indices
      type(c_ptr) :: values
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the index base stored in the sparse vector descriptor
  !>  
  !>    @param[in]
  !>    descr   the pointer to the sparse vector descriptor.
  !>    @param[out]
  !>    idx_base   \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_value if \p idx_base is invalid.
  !>  
  interface rocsparse_spvec_get_index_base
    function rocsparse_spvec_get_index_base_(descr,idx_base) bind(c, name="rocsparse_spvec_get_index_base")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spvec_get_index_base_
      type(c_ptr),value :: descr
      type(c_ptr),value :: idx_base
    end function


  end interface
  !> @{
  interface rocsparse_spvec_get_values
    function rocsparse_spvec_get_values_(descr,values) bind(c, name="rocsparse_spvec_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spvec_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  
  interface rocsparse__spvec_get_values
    function rocsparse__spvec_get_values_(descr,values) bind(c, name="rocsparse__spvec_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__spvec_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the values array in the sparse vector descriptor
  !>  
  !>    @param[inout]
  !>    descr   the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    values   non-zero values in the sparse vector (must be array of length \p nnz ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p values is invalid.
  !>  
  interface rocsparse_spvec_set_values
    function rocsparse_spvec_set_values_(descr,values) bind(c, name="rocsparse_spvec_set_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spvec_set_values_
      type(c_ptr),value :: descr
      type(c_ptr),value :: values
    end function


  end interface
  !> @{
  interface rocsparse_create_coo_descr
    function rocsparse_create_coo_descr_(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_create_coo_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_coo_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: coo_row_ind
      type(c_ptr),value :: coo_col_ind
      type(c_ptr),value :: coo_val
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  
  interface rocsparse_create__coo_descr
    function rocsparse_create__coo_descr_(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_create__coo_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__coo_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: coo_row_ind
      type(c_ptr),value :: coo_col_ind
      type(c_ptr),value :: coo_val
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_create__coo_descr_rank_0,&
      
rocsparse_create__coo_descr_rank_1
#endif

  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a sparse COO AoS matrix descriptor
  !>    \details
  !>    \p rocsparse_create_coo_aos_descr creates a sparse COO AoS matrix descriptor. It should be
  !>    destroyed at the end using \p rocsparse_destroy_spmat_descr.
  !>  
  !>    @param[out]
  !>    descr       the pointer to the sparse COO AoS matrix descriptor.
  !>    @param[in]
  !>    rows        number of rows in the COO AoS matrix.
  !>    @param[in]
  !>    cols        number of columns in the COO AoS matrix
  !>    @param[in]
  !>    nnz         number of non-zeros in the COO AoS matrix.
  !>    @param[in]
  !>    coo_ind     <row, column> indices of the COO AoS matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    coo_val     values of the COO AoS matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    idx_type    \ref rocsparse_indextype_i32 or \ref rocsparse_indextype_i64.
  !>    @param[in]
  !>    idx_base    \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one.
  !>    @param[in]
  !>    data_type   \ref rocsparse_datatype_f32_r, \ref rocsparse_datatype_f64_r,
  !>                \ref rocsparse_datatype_f32_c or \ref rocsparse_datatype_f64_c.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p coo_ind or \p coo_val is invalid.
  !>    \retval rocsparse_status_invalid_size if \p rows or \p cols or \p nnz is invalid.
  !>    \retval rocsparse_status_invalid_value if \p idx_type or \p idx_base or \p data_type is invalid.
  !>  
  interface rocsparse_create_coo_aos_descr
    function rocsparse_create_coo_aos_descr_(descr,rows,cols,nnz,coo_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_create_coo_aos_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_coo_aos_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: coo_ind
      type(c_ptr),value :: coo_val
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a sparse BSR matrix descriptor
  !>    \details
  !>    \p rocsparse_create_bsr_descr creates a sparse BSR matrix descriptor. It should be
  !>    destroyed at the end using \p rocsparse_destroy_spmat_descr.
  !>  
  !>    @param[out]
  !>    descr        the pointer to the sparse BSR matrix descriptor.
  !>    @param[in]
  !>    mb           number of rows in the BSR matrix.
  !>    @param[in]
  !>    nb           number of columns in the BSR matrix
  !>    @param[in]
  !>    nnzb         number of non-zeros in the BSR matrix.
  !>    @param[in]
  !>    block_dir    direction of the internal block storage.
  !>    @param[in]
  !>    block_dim    dimension of the blocks.
  !>    @param[in]
  !>    bsr_row_ptr  row offsets of the BSR matrix (must be array of length \p mb+1 ).
  !>    @param[in]
  !>    bsr_col_ind  column indices of the BSR matrix (must be array of length \p nnzb ).
  !>    @param[in]
  !>    bsr_val      values of the BSR matrix (must be array of length \p nnzb  \p block_dim  \p block_dim ).
  !>    @param[in]
  !>    row_ptr_type \ref rocsparse_indextype_i32 or \ref rocsparse_indextype_i64.
  !>    @param[in]
  !>    col_ind_type \ref rocsparse_indextype_i32 or \ref rocsparse_indextype_i64.
  !>    @param[in]
  !>    idx_base     \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one.
  !>    @param[in]
  !>    data_type    \ref rocsparse_datatype_f32_r, \ref rocsparse_datatype_f64_r,
  !>                 \ref rocsparse_datatype_f32_c or \ref rocsparse_datatype_f64_c.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p bsr_row_ptr or \p bsr_col_ind or \p bsr_val is invalid.
  !>    \retval rocsparse_status_invalid_size if \p mb or \p nb or \p nnzb \p block_dim is invalid.
  !>    \retval rocsparse_status_invalid_value if \p row_ptr_type or \p col_ind_type or \p idx_base or \p data_type or \p block_dir is invalid.
  !>  
  interface rocsparse_create_bsr_descr
    function rocsparse_create_bsr_descr_(descr,mb,nb,nnzb,block_dir,block_dim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse_create_bsr_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_bsr_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: mb
      integer(c_int64_t),value :: nb
      integer(c_int64_t),value :: nnzb
      integer(kind(rocsparse_direction_row)),value :: block_dir
      integer(c_int64_t),value :: block_dim
      type(c_ptr),value :: bsr_row_ptr
      type(c_ptr),value :: bsr_col_ind
      type(c_ptr),value :: bsr_val
      integer(kind(rocsparse_indextype_u16)),value :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)),value :: col_ind_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_create_bsr_descr_rank_0,&
      
rocsparse_create_bsr_descr_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_create_csr_descr
    function rocsparse_create_csr_descr_(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse_create_csr_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_csr_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: csr_row_ptr
      type(c_ptr),value :: csr_col_ind
      type(c_ptr),value :: csr_val
      integer(kind(rocsparse_indextype_u16)),value :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)),value :: col_ind_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  
  interface rocsparse_create__csr_descr
    function rocsparse_create__csr_descr_(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse_create__csr_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__csr_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: csr_row_ptr
      type(c_ptr),value :: csr_col_ind
      type(c_ptr),value :: csr_val
      integer(kind(rocsparse_indextype_u16)),value :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)),value :: col_ind_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_create__csr_descr_rank_0,&
      
rocsparse_create__csr_descr_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_create_csc_descr
    function rocsparse_create_csc_descr_(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type) bind(c, name="rocsparse_create_csc_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_csc_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: csc_col_ptr
      type(c_ptr),value :: csc_row_ind
      type(c_ptr),value :: csc_val
      integer(kind(rocsparse_indextype_u16)),value :: col_ptr_type
      integer(kind(rocsparse_indextype_u16)),value :: row_ind_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  
  interface rocsparse_create__csc_descr
    function rocsparse_create__csc_descr_(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type) bind(c, name="rocsparse_create__csc_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__csc_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: nnz
      type(c_ptr),value :: csc_col_ptr
      type(c_ptr),value :: csc_row_ind
      type(c_ptr),value :: csc_val
      integer(kind(rocsparse_indextype_u16)),value :: col_ptr_type
      integer(kind(rocsparse_indextype_u16)),value :: row_ind_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_create__csc_descr_rank_0,&
      
rocsparse_create__csc_descr_rank_1
#endif

  end interface
  !> ! \ingroup aux_module
  !>    \brief Create a sparse ELL matrix descriptor
  !>    \details
  !>    \p rocsparse_create_ell_descr creates a sparse ELL matrix descriptor. It should be
  !>    destroyed at the end using \p rocsparse_destroy_spmat_descr.
  !>  
  !>    @param[out]
  !>    descr       the pointer to the sparse ELL matrix descriptor.
  !>    @param[in]
  !>    rows        number of rows in the ELL matrix.
  !>    @param[in]
  !>    cols        number of columns in the ELL matrix
  !>    @param[in]
  !>    ell_col_ind column indices of the ELL matrix (must be array of length \p rowsell_width ).
  !>    @param[in]
  !>    ell_val     values of the ELL matrix (must be array of length \p rowsell_width ).
  !>    @param[in]
  !>    ell_width   width of the ELL matrix.
  !>    @param[in]
  !>    idx_type    \ref rocsparse_indextype_i32 or \ref rocsparse_indextype_i64.
  !>    @param[in]
  !>    idx_base    \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one.
  !>    @param[in]
  !>    data_type   \ref rocsparse_datatype_f32_r, \ref rocsparse_datatype_f64_r,
  !>                \ref rocsparse_datatype_f32_c or \ref rocsparse_datatype_f64_c.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p ell_col_ind or \p ell_val is invalid.
  !>    \retval rocsparse_status_invalid_size if \p rows or \p cols or \p ell_width is invalid.
  !>    \retval rocsparse_status_invalid_value if \p idx_type or \p idx_base or \p data_type is invalid.
  !>  
  interface rocsparse_create_ell_descr
    function rocsparse_create_ell_descr_(descr,rows,cols,ell_col_ind,ell_val,ell_width,idx_type,idx_base,data_type) bind(c, name="rocsparse_create_ell_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_ell_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      type(c_ptr),value :: ell_col_ind
      type(c_ptr),value :: ell_val
      integer(c_int64_t),value :: ell_width
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  !> @{
  interface rocsparse_create_bell_descr
    function rocsparse_create_bell_descr_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_create_bell_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_bell_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(kind(rocsparse_direction_row)),value :: ell_block_dir
      integer(c_int64_t),value :: ell_block_dim
      integer(c_int64_t),value :: ell_cols
      type(c_ptr),value :: ell_col_ind
      type(c_ptr),value :: ell_val
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  
  interface rocsparse_create__bell_descr
    function rocsparse_create__bell_descr_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_create__bell_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__bell_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(kind(rocsparse_direction_row)),value :: ell_block_dir
      integer(c_int64_t),value :: ell_block_dim
      integer(c_int64_t),value :: ell_cols
      type(c_ptr),value :: ell_col_ind
      type(c_ptr),value :: ell_val
      integer(kind(rocsparse_indextype_u16)),value :: idx_type
      integer(kind(rocsparse_index_base_zero)),value :: idx_base
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_create__bell_descr_rank_0,&
      
rocsparse_create__bell_descr_rank_1
#endif

  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a sparse matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_destroy_spmat_descr destroys a sparse matrix descriptor and releases all
  !>    resources used by the descriptor.
  !>  
  !>    @param[in]
  !>    descr   the matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr is invalid.
  !>  
  interface rocsparse_destroy_spmat_descr
    function rocsparse_destroy_spmat_descr_(descr) bind(c, name="rocsparse_destroy_spmat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_spmat_descr_
      type(c_ptr),value :: descr
    end function


  end interface
  !> @{
  interface rocsparse_coo_get
    function rocsparse_coo_get_(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_coo_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_coo_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: coo_row_ind
      type(c_ptr) :: coo_col_ind
      type(c_ptr) :: coo_val
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__coo_get
    function rocsparse__coo_get_(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse__coo_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: coo_row_ind
      type(c_ptr) :: coo_col_ind
      type(c_ptr) :: coo_val
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__coo_get_full_rank,&
      
rocsparse__coo_get_rank_0,&
      
rocsparse__coo_get_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_coo_aos_get
    function rocsparse_coo_aos_get_(descr,rows,cols,nnz,coo_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_coo_aos_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_coo_aos_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: coo_ind
      type(c_ptr) :: coo_val
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__coo_aos_get
    function rocsparse__coo_aos_get_(descr,rows,cols,nnz,coo_ind,coo_val,idx_type,idx_base,data_type) bind(c, name="rocsparse__coo_aos_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_aos_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: coo_ind
      type(c_ptr) :: coo_val
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__coo_aos_get_full_rank,&
      
rocsparse__coo_aos_get_rank_0,&
      
rocsparse__coo_aos_get_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_csr_get
    function rocsparse_csr_get_(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse_csr_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csr_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: csr_row_ptr
      type(c_ptr) :: csr_col_ind
      type(c_ptr) :: csr_val
      type(c_ptr),value :: row_ptr_type
      type(c_ptr),value :: col_ind_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__csr_get
    function rocsparse__csr_get_(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse__csr_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csr_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: csr_row_ptr
      type(c_ptr) :: csr_col_ind
      type(c_ptr) :: csr_val
      type(c_ptr),value :: row_ptr_type
      type(c_ptr),value :: col_ind_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__csr_get_full_rank,&
      
rocsparse__csr_get_rank_0,&
      
rocsparse__csr_get_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_csc_get
    function rocsparse_csc_get_(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type) bind(c, name="rocsparse_csc_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csc_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: csc_col_ptr
      type(c_ptr) :: csc_row_ind
      type(c_ptr) :: csc_val
      type(c_ptr),value :: col_ptr_type
      type(c_ptr),value :: row_ind_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_csc_get_full_rank,&
      
rocsparse_csc_get_rank_0,&
      
rocsparse_csc_get_rank_1
#endif

  end interface
  
  interface rocsparse__csc_get
    function rocsparse__csc_get_(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type) bind(c, name="rocsparse__csc_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csc_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
      type(c_ptr) :: csc_col_ptr
      type(c_ptr) :: csc_row_ind
      type(c_ptr) :: csc_val
      type(c_ptr),value :: col_ptr_type
      type(c_ptr),value :: row_ind_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__csc_get_full_rank,&
      
rocsparse__csc_get_rank_0,&
      
rocsparse__csc_get_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_ell_get
    function rocsparse_ell_get_(descr,rows,cols,ell_col_ind,ell_val,ell_width,idx_type,idx_base,data_type) bind(c, name="rocsparse_ell_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_ell_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr) :: ell_col_ind
      type(c_ptr) :: ell_val
      type(c_ptr),value :: ell_width
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__ell_get
    function rocsparse__ell_get_(descr,rows,cols,ell_col_ind,ell_val,ell_width,idx_type,idx_base,data_type) bind(c, name="rocsparse__ell_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__ell_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr) :: ell_col_ind
      type(c_ptr) :: ell_val
      type(c_ptr),value :: ell_width
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__ell_get_full_rank,&
      
rocsparse__ell_get_rank_0,&
      
rocsparse__ell_get_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_bell_get
    function rocsparse_bell_get_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type) bind(c, name="rocsparse_bell_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bell_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: ell_block_dir
      type(c_ptr),value :: ell_block_dim
      type(c_ptr),value :: ell_cols
      type(c_ptr) :: ell_col_ind
      type(c_ptr) :: ell_val
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__bell_get
    function rocsparse__bell_get_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type) bind(c, name="rocsparse__bell_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bell_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: ell_block_dir
      type(c_ptr),value :: ell_block_dim
      type(c_ptr),value :: ell_cols
      type(c_ptr) :: ell_col_ind
      type(c_ptr) :: ell_val
      type(c_ptr),value :: idx_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__bell_get_full_rank,&
      
rocsparse__bell_get_rank_0,&
      
rocsparse__bell_get_rank_1
#endif

  end interface
  !> @{
  interface rocsparse_bsr_get
    function rocsparse_bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse_bsr_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: brows
      type(c_ptr),value :: bcols
      type(c_ptr),value :: bnnz
      type(c_ptr),value :: bdir
      type(c_ptr),value :: bdim
      type(c_ptr) :: bsr_row_ptr
      type(c_ptr) :: bsr_col_ind
      type(c_ptr) :: bsr_val
      type(c_ptr),value :: row_ptr_type
      type(c_ptr),value :: col_ind_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_bsr_get_full_rank,&
      
rocsparse_bsr_get_rank_0,&
      
rocsparse_bsr_get_rank_1
#endif

  end interface
  
  interface rocsparse__bsr_get
    function rocsparse__bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type) bind(c, name="rocsparse__bsr_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bsr_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: brows
      type(c_ptr),value :: bcols
      type(c_ptr),value :: bnnz
      type(c_ptr),value :: bdir
      type(c_ptr),value :: bdim
      type(c_ptr) :: bsr_row_ptr
      type(c_ptr) :: bsr_col_ind
      type(c_ptr) :: bsr_val
      type(c_ptr),value :: row_ptr_type
      type(c_ptr),value :: col_ind_type
      type(c_ptr),value :: idx_base
      type(c_ptr),value :: data_type
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse__bsr_get_full_rank,&
      
rocsparse__bsr_get_rank_0,&
      
rocsparse__bsr_get_rank_1
#endif

  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the row indices, column indices and values array in the sparse COO matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr   the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    coo_row_ind row indices of the COO matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    coo_col_ind column indices of the COO matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    coo_val     values of the COO matrix (must be array of length \p nnz ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p coo_row_ind or \p coo_col_ind or \p coo_val is invalid.
  !>  
  interface rocsparse_coo_set_pointers
    function rocsparse_coo_set_pointers_(descr,coo_row_ind,coo_col_ind,coo_val) bind(c, name="rocsparse_coo_set_pointers")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_coo_set_pointers_
      type(c_ptr),value :: descr
      type(c_ptr),value :: coo_row_ind
      type(c_ptr),value :: coo_col_ind
      type(c_ptr),value :: coo_val
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the <row, column> indices and values array in the sparse COO AoS matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr   the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    coo_ind <row, column> indices of the COO matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    coo_val values of the COO matrix (must be array of length \p nnz ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p coo_ind or \p coo_val is invalid.
  !>  
  interface rocsparse_coo_aos_set_pointers
    function rocsparse_coo_aos_set_pointers_(descr,coo_ind,coo_val) bind(c, name="rocsparse_coo_aos_set_pointers")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_coo_aos_set_pointers_
      type(c_ptr),value :: descr
      type(c_ptr),value :: coo_ind
      type(c_ptr),value :: coo_val
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the row offsets, column indices and values array in the sparse CSR matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr   the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    csr_row_ptr  row offsets of the CSR matrix (must be array of length \p rows+1 ).
  !>    @param[in]
  !>    csr_col_ind  column indices of the CSR matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    csr_val      values of the CSR matrix (must be array of length \p nnz ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p coo_ind or \p coo_val is invalid.
  !>  
  interface rocsparse_csr_set_pointers
    function rocsparse_csr_set_pointers_(descr,csr_row_ptr,csr_col_ind,csr_val) bind(c, name="rocsparse_csr_set_pointers")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csr_set_pointers_
      type(c_ptr),value :: descr
      type(c_ptr),value :: csr_row_ptr
      type(c_ptr),value :: csr_col_ind
      type(c_ptr),value :: csr_val
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the column offsets, row indices and values array in the sparse CSC matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr       the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    csc_col_ptr column offsets of the CSC matrix (must be array of length \p cols+1 ).
  !>    @param[in]
  !>    csc_row_ind row indices of the CSC matrix (must be array of length \p nnz ).
  !>    @param[in]
  !>    csc_val     values of the CSC matrix (must be array of length \p nnz ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p csc_col_ptr or \p csc_row_ind or \p csc_val is invalid.
  !>  
  interface rocsparse_csc_set_pointers
    function rocsparse_csc_set_pointers_(descr,csc_col_ptr,csc_row_ind,csc_val) bind(c, name="rocsparse_csc_set_pointers")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csc_set_pointers_
      type(c_ptr),value :: descr
      type(c_ptr),value :: csc_col_ptr
      type(c_ptr),value :: csc_row_ind
      type(c_ptr),value :: csc_val
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the column indices and values array in the sparse ELL matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr       the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    ell_col_ind column indices of the ELL matrix (must be array of length \p rowsell_width ).
  !>    @param[in]
  !>    ell_val     values of the ELL matrix (must be array of length \p rowsell_width ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p ell_col_ind or \p ell_val is invalid.
  !>  
  interface rocsparse_ell_set_pointers
    function rocsparse_ell_set_pointers_(descr,ell_col_ind,ell_val) bind(c, name="rocsparse_ell_set_pointers")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_ell_set_pointers_
      type(c_ptr),value :: descr
      type(c_ptr),value :: ell_col_ind
      type(c_ptr),value :: ell_val
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the row offsets, column indices and values array in the sparse BSR matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr   the pointer to the sparse vector descriptor.
  !>    @param[in]
  !>    bsr_row_ptr  row offsets of the BSR matrix (must be array of length \p rows+1 ).
  !>    @param[in]
  !>    bsr_col_ind  column indices of the BSR matrix (must be array of length \p nnzb ).
  !>    @param[in]
  !>    bsr_val      values of the BSR matrix (must be array of length \p nnzbblock_dimblock_dim ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p bsr_row_ptr or \p bsr_col_ind or \p bsr_val is invalid.
  !>  
  interface rocsparse_bsr_set_pointers
    function rocsparse_bsr_set_pointers_(descr,bsr_row_ptr,bsr_col_ind,bsr_val) bind(c, name="rocsparse_bsr_set_pointers")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_set_pointers_
      type(c_ptr),value :: descr
      type(c_ptr),value :: bsr_row_ptr
      type(c_ptr),value :: bsr_col_ind
      type(c_ptr),value :: bsr_val
    end function

#ifdef USE_FPOINTER_INTERFACES
    module procedure rocsparse_bsr_set_pointers_rank_0,&
      
rocsparse_bsr_set_pointers_rank_1
#endif

  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the number of rows, columns and non-zeros from the sparse matrix descriptor
  !>  
  !>    @param[in]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[out]
  !>    rows        number of rows in the sparse matrix.
  !>    @param[out]
  !>    cols        number of columns in the sparse matrix.
  !>    @param[out]
  !>    nnz         number of non-zeros in sparse matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p rows or \p cols or \p nnz is invalid.
  !>  
  interface rocsparse_spmat_get_size
    function rocsparse_spmat_get_size_(descr,rows,cols,nnz) bind(c, name="rocsparse_spmat_get_size")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_get_size_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: nnz
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the sparse matrix format from the sparse matrix descriptor
  !>  
  !>    @param[in]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[out]
  !>    format      \ref rocsparse_format_coo or \ref rocsparse_format_coo_aos or
  !>                \ref rocsparse_format_csr or \ref rocsparse_format_csc or
  !>                \ref rocsparse_format_ell
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_value if \p format is invalid.
  !>  
  interface rocsparse_spmat_get_format
    function rocsparse_spmat_get_format_(descr,myFormat) bind(c, name="rocsparse_spmat_get_format")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_get_format_
      type(c_ptr),value :: descr
      type(c_ptr),value :: myFormat
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the sparse matrix index base from the sparse matrix descriptor
  !>  
  !>    @param[in]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[out]
  !>    idx_base    \ref rocsparse_index_base_zero or \ref rocsparse_index_base_one
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_value if \p idx_base is invalid.
  !>  
  interface rocsparse_spmat_get_index_base
    function rocsparse_spmat_get_index_base_(descr,idx_base) bind(c, name="rocsparse_spmat_get_index_base")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_get_index_base_
      type(c_ptr),value :: descr
      type(c_ptr),value :: idx_base
    end function


  end interface
  !> @{
  interface rocsparse_spmat_get_values
    function rocsparse_spmat_get_values_(descr,values) bind(c, name="rocsparse_spmat_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  
  interface rocsparse__spmat_get_values
    function rocsparse__spmat_get_values_(descr,values) bind(c, name="rocsparse__spmat_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__spmat_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the values array in the sparse matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr     the pointer to the sparse matrix descriptor.
  !>    @param[in]
  !>    values    values array of the sparse matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p values is invalid.
  !>  
  interface rocsparse_spmat_set_values
    function rocsparse_spmat_set_values_(descr,values) bind(c, name="rocsparse_spmat_set_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_set_values_
      type(c_ptr),value :: descr
      type(c_ptr),value :: values
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the strided batch count from the sparse matrix descriptor
  !>  
  !>    @param[in]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[out]
  !>    batch_count batch_count of the sparse matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count is invalid.
  !>  
  interface rocsparse_spmat_get_strided_batch
    function rocsparse_spmat_get_strided_batch_(descr,batch_count) bind(c, name="rocsparse_spmat_get_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_get_strided_batch_
      type(c_ptr),value :: descr
      type(c_ptr),value :: batch_count
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the strided batch count in the sparse matrix descriptor
  !>  
  !>    @param[in]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[in]
  !>    batch_count batch_count of the sparse matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count is invalid.
  !>  
  interface rocsparse_spmat_set_strided_batch
    function rocsparse_spmat_set_strided_batch_(descr,batch_count) bind(c, name="rocsparse_spmat_set_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_set_strided_batch_
      type(c_ptr),value :: descr
      integer(c_int),value :: batch_count
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the batch count and batch stride in the sparse COO matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr        the pointer to the sparse COO matrix descriptor.
  !>    @param[in]
  !>    batch_count  batch_count of the sparse COO matrix.
  !>    @param[in]
  !>    batch_stride batch stride of the sparse COO matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count or \p batch_stride is invalid.
  !>  
  interface rocsparse_coo_set_strided_batch
    function rocsparse_coo_set_strided_batch_(descr,batch_count,batch_stride) bind(c, name="rocsparse_coo_set_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_coo_set_strided_batch_
      type(c_ptr),value :: descr
      integer(c_int),value :: batch_count
      integer(c_int64_t),value :: batch_stride
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the batch count, row offset batch stride and the column indices batch stride in the sparse CSR matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr                       the pointer to the sparse CSR matrix descriptor.
  !>    @param[in]
  !>    batch_count                 batch_count of the sparse CSR matrix.
  !>    @param[in]
  !>    offsets_batch_stride        row offset batch stride of the sparse CSR matrix.
  !>    @param[in]
  !>    columns_values_batch_stride column indices batch stride of the sparse CSR matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count or \p offsets_batch_stride or \p columns_values_batch_stride is invalid.
  !>  
  interface rocsparse_csr_set_strided_batch
    function rocsparse_csr_set_strided_batch_(descr,batch_count,offsets_batch_stride,columns_values_batch_stride) bind(c, name="rocsparse_csr_set_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csr_set_strided_batch_
      type(c_ptr),value :: descr
      integer(c_int),value :: batch_count
      integer(c_int64_t),value :: offsets_batch_stride
      integer(c_int64_t),value :: columns_values_batch_stride
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the batch count, column offset batch stride and the row indices batch stride in the sparse CSC matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr                       the pointer to the sparse CSC matrix descriptor.
  !>    @param[in]
  !>    batch_count                 batch_count of the sparse CSC matrix.
  !>    @param[in]
  !>    offsets_batch_stride        column offset batch stride of the sparse CSC matrix.
  !>    @param[in]
  !>    rows_values_batch_stride    row indices batch stride of the sparse CSC matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count or \p offsets_batch_stride or \p rows_values_batch_stride is invalid.
  !>  
  interface rocsparse_csc_set_strided_batch
    function rocsparse_csc_set_strided_batch_(descr,batch_count,offsets_batch_stride,rows_values_batch_stride) bind(c, name="rocsparse_csc_set_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csc_set_strided_batch_
      type(c_ptr),value :: descr
      integer(c_int),value :: batch_count
      integer(c_int64_t),value :: offsets_batch_stride
      integer(c_int64_t),value :: rows_values_batch_stride
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the requested attribute data from the sparse matrix descriptor
  !>  
  !>    @param[in]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[in]
  !>    attribute \ref rocsparse_spmat_fill_mode or \ref rocsparse_spmat_diag_type or
  !>              \ref rocsparse_spmat_matrix_type or \ref rocsparse_spmat_storage_mode
  !>    @param[out]
  !>    data      attribute data
  !>    @param[in]
  !>    data_size attribute data size.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p data is invalid.
  !>    \retval rocsparse_status_invalid_value if \p attribute is invalid.
  !>    \retval rocsparse_status_invalid_size if \p data_size is invalid.
  !>  
  interface rocsparse_spmat_get_attribute
    function rocsparse_spmat_get_attribute_(descr,attribute,myData,data_size) bind(c, name="rocsparse_spmat_get_attribute")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_get_attribute_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_spmat_fill_mode)),value :: attribute
      type(c_ptr),value :: myData
      integer(c_size_t),value :: data_size
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the requested attribute data in the sparse matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr       the pointer to the sparse matrix descriptor.
  !>    @param[in]
  !>    attribute \ref rocsparse_spmat_fill_mode or \ref rocsparse_spmat_diag_type or
  !>              \ref rocsparse_spmat_matrix_type or \ref rocsparse_spmat_storage_mode
  !>    @param[in]
  !>    data      attribute data
  !>    @param[in]
  !>    data_size attribute data size.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr or \p data is invalid.
  !>    \retval rocsparse_status_invalid_value if \p attribute is invalid.
  !>    \retval rocsparse_status_invalid_size if \p data_size is invalid.
  !>  
  interface rocsparse_spmat_set_attribute
    function rocsparse_spmat_set_attribute_(descr,attribute,myData,data_size) bind(c, name="rocsparse_spmat_set_attribute")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_spmat_set_attribute_
      type(c_ptr),value :: descr
      integer(kind(rocsparse_spmat_fill_mode)),value :: attribute
      type(c_ptr),value :: myData
      integer(c_size_t),value :: data_size
    end function


  end interface
  !> @{
  interface rocsparse_create_dnvec_descr
    function rocsparse_create_dnvec_descr_(descr,mySize,values,data_type) bind(c, name="rocsparse_create_dnvec_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_dnvec_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: mySize
      type(c_ptr),value :: values
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  
  interface rocsparse_create__dnvec_descr
    function rocsparse_create__dnvec_descr_(descr,mySize,values,data_type) bind(c, name="rocsparse_create__dnvec_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__dnvec_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: mySize
      type(c_ptr),value :: values
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a dense vector descriptor
  !>  
  !>    \details
  !>    \p rocsparse_destroy_dnvec_descr destroys a dense vector descriptor and releases all
  !>    resources used by the descriptor.
  !>  
  !>    @param[in]
  !>    descr   the matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr is invalid.
  !>  
  interface rocsparse_destroy_dnvec_descr
    function rocsparse_destroy_dnvec_descr_(descr) bind(c, name="rocsparse_destroy_dnvec_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_dnvec_descr_
      type(c_ptr),value :: descr
    end function


  end interface
  !> @{
  interface rocsparse_dnvec_get
    function rocsparse_dnvec_get_(descr,mySize,values,data_type) bind(c, name="rocsparse_dnvec_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnvec_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: mySize
      type(c_ptr) :: values
      type(c_ptr),value :: data_type
    end function


  end interface
  
  interface rocsparse__dnvec_get
    function rocsparse__dnvec_get_(descr,mySize,values,data_type) bind(c, name="rocsparse__dnvec_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__dnvec_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: mySize
      type(c_ptr) :: values
      type(c_ptr),value :: data_type
    end function


  end interface
  !> @{
  interface rocsparse_dnvec_get_values
    function rocsparse_dnvec_get_values_(descr,values) bind(c, name="rocsparse_dnvec_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnvec_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  
  interface rocsparse__dnvec_get_values
    function rocsparse__dnvec_get_values_(descr,values) bind(c, name="rocsparse__dnvec_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__dnvec_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the values array in a dense vector descriptor
  !>  
  !>    @param[inout]
  !>    descr   the matrix descriptor.
  !>    @param[in]
  !>    values   non-zero values in the dense vector (must be array of length \p size ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr or \p values is invalid.
  !>  
  interface rocsparse_dnvec_set_values
    function rocsparse_dnvec_set_values_(descr,values) bind(c, name="rocsparse_dnvec_set_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnvec_set_values_
      type(c_ptr),value :: descr
      type(c_ptr),value :: values
    end function


  end interface
  !> @{
  interface rocsparse_create_dnmat_descr
    function rocsparse_create_dnmat_descr_(descr,rows,cols,ld,values,data_type,order) bind(c, name="rocsparse_create_dnmat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_dnmat_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: ld
      type(c_ptr),value :: values
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
      integer(kind(rocsparse_order_row)),value :: order
    end function


  end interface
  
  interface rocsparse_create__dnmat_descr
    function rocsparse_create__dnmat_descr_(descr,rows,cols,ld,values,data_type,order) bind(c, name="rocsparse_create__dnmat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__dnmat_descr_
      type(c_ptr) :: descr
      integer(c_int64_t),value :: rows
      integer(c_int64_t),value :: cols
      integer(c_int64_t),value :: ld
      type(c_ptr),value :: values
      integer(kind(rocsparse_datatype_f32_r)),value :: data_type
      integer(kind(rocsparse_order_row)),value :: order
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Destroy a dense matrix descriptor
  !>  
  !>    \details
  !>    \p rocsparse_destroy_dnmat_descr destroys a dense matrix descriptor and releases all
  !>    resources used by the descriptor.
  !>  
  !>    @param[in]
  !>    descr   the matrix descriptor.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr is invalid.
  !>  
  interface rocsparse_destroy_dnmat_descr
    function rocsparse_destroy_dnmat_descr_(descr) bind(c, name="rocsparse_destroy_dnmat_descr")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_destroy_dnmat_descr_
      type(c_ptr),value :: descr
    end function


  end interface
  !> @{
  interface rocsparse_dnmat_get
    function rocsparse_dnmat_get_(descr,rows,cols,ld,values,data_type,order) bind(c, name="rocsparse_dnmat_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnmat_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: ld
      type(c_ptr) :: values
      type(c_ptr),value :: data_type
      type(c_ptr),value :: order
    end function


  end interface
  
  interface rocsparse__dnmat_get
    function rocsparse__dnmat_get_(descr,rows,cols,ld,values,data_type,order) bind(c, name="rocsparse__dnmat_get")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__dnmat_get_
      type(c_ptr),value :: descr
      type(c_ptr),value :: rows
      type(c_ptr),value :: cols
      type(c_ptr),value :: ld
      type(c_ptr) :: values
      type(c_ptr),value :: data_type
      type(c_ptr),value :: order
    end function


  end interface
  !> @{
  interface rocsparse_dnmat_get_values
    function rocsparse_dnmat_get_values_(descr,values) bind(c, name="rocsparse_dnmat_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnmat_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  
  interface rocsparse__dnmat_get_values
    function rocsparse__dnmat_get_values_(descr,values) bind(c, name="rocsparse__dnmat_get_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__dnmat_get_values_
      type(c_ptr),value :: descr
      type(c_ptr) :: values
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the values array in a dense matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr   the matrix descriptor.
  !>    @param[in]
  !>    values    non-zero values in the dense matrix (must be array of length
  !>              \p ldrows if \p order=rocsparse_order_column or \p ldcols if \p order=rocsparse_order_row ).
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer \p descr or \p values is invalid.
  !>  
  interface rocsparse_dnmat_set_values
    function rocsparse_dnmat_set_values_(descr,values) bind(c, name="rocsparse_dnmat_set_values")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnmat_set_values_
      type(c_ptr),value :: descr
      type(c_ptr),value :: values
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Get the batch count and batch stride from the dense matrix descriptor
  !>  
  !>    @param[in]
  !>    descr        the pointer to the dense matrix descriptor.
  !>    @param[out]
  !>    batch_count  the batch count in the dense matrix.
  !>    @param[out]
  !>    batch_stride the batch stride in the dense matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count or \p batch_stride is invalid.
  !>  
  interface rocsparse_dnmat_get_strided_batch
    function rocsparse_dnmat_get_strided_batch_(descr,batch_count,batch_stride) bind(c, name="rocsparse_dnmat_get_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnmat_get_strided_batch_
      type(c_ptr),value :: descr
      type(c_ptr),value :: batch_count
      type(c_ptr),value :: batch_stride
    end function


  end interface
  !> ! \ingroup aux_module
  !>    \brief Set the batch count and batch stride in the dense matrix descriptor
  !>  
  !>    @param[inout]
  !>    descr        the pointer to the dense matrix descriptor.
  !>    @param[in]
  !>    batch_count  the batch count in the dense matrix.
  !>    @param[in]
  !>    batch_stride the batch stride in the dense matrix.
  !>  
  !>    \retval rocsparse_status_success the operation completed successfully.
  !>    \retval rocsparse_status_invalid_pointer if \p descr is invalid.
  !>    \retval rocsparse_status_invalid_size if \p batch_count or \p batch_stride is invalid.
  !>  
  interface rocsparse_dnmat_set_strided_batch
    function rocsparse_dnmat_set_strided_batch_(descr,batch_count,batch_stride) bind(c, name="rocsparse_dnmat_set_strided_batch")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_dnmat_set_strided_batch_
      type(c_ptr),value :: descr
      integer(c_int),value :: batch_count
      integer(c_int64_t),value :: batch_stride
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Set the memory report filename.
  !>    
  !>      \details
  !>      \p rocsparse_memstat_report set the filename to use for the memory report.
  !>      This routine is optional, but it must be called before any hip memory operation.
  !>      Note that the default memory report filename is 'rocsparse_memstat.json'.
  !>      Also note that if any operation occurs before calling this routine, the default filename rocsparse_memstat.json
  !>      will be used but renamed after this call.
  !>      The content of the memory report summarizes memory operations from the use of the routines
  !>      \ref rocsparse_hip_malloc,
  !>      \ref rocsparse_hip_free,
  !>      \ref rocsparse_hip_host_malloc,
  !>      \ref rocsparse_hip_host_free,
  !>      \ref rocsparse_hip_host_managed,
  !>      \ref rocsparse_hip_free_managed.
  !>    
  !>      @param[in]
  !>      filename  the memory report filename.
  !>    
  !>      \retval rocsparse_status_success the operation succeeded.
  !>      \retval rocsparse_status_invalid_pointer \p handle filename is an invalid pointer.
  !>      \retval rocsparse_status_internal_error an internal error occurred.
  !>    
  interface rocsparse_memstat_report
    function rocsparse_memstat_report_(filename) bind(c, name="rocsparse_memstat_report")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_memstat_report_
      type(c_ptr),value :: filename
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipFree.
  !>    
  !>      @param[in]
  !>      mem  memory pointer
  !>      @param[in]
  !>      tag  tag to attach to the operation.
  !>    
  !>      \retval error from the related hip operation.
  !>    
  interface rocsparse_hip_free
    function rocsparse_hip_free_(mem,tag) bind(c, name="rocsparse_hip_free")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_free_
      type(c_ptr),value :: mem
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipMalloc.
  !>    
  !>      @param[in]
  !>      mem  pointer of memory pointer
  !>      @param[in]
  !>      nbytes  number of bytes
  !>      @param[in]
  !>      tag  tag to attach to the operation
  !>    
  !>      \retval error from the related hip operation
  !>    
  interface rocsparse_hip_malloc
    function rocsparse_hip_malloc_(mem,nbytes,tag) bind(c, name="rocsparse_hip_malloc")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_malloc_
      type(c_ptr) :: mem
      integer(c_size_t),value :: nbytes
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipFreeAsync.
  !>    
  !>      @param[in]
  !>      mem  memory pointer
  !>      @param[in]
  !>      stream  the stream to be used by the asynchronous operation
  !>      @param[in]
  !>      tag  tag to attach to the operation.
  !>    
  !>      \retval error from the related hip operation.
  !>    
  interface rocsparse_hip_free_async
    function rocsparse_hip_free_async_(mem,stream,tag) bind(c, name="rocsparse_hip_free_async")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_free_async_
      type(c_ptr),value :: mem
      type(c_ptr),value :: stream
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipMallocAsync.
  !>    
  !>      @param[in]
  !>      mem  pointer of memory pointer
  !>      @param[in]
  !>      nbytes  number of bytes
  !>      @param[in]
  !>      stream  the stream to be used by the asynchronous operation
  !>      @param[in]
  !>      tag  tag to attach to the operation
  !>    
  !>      \retval error from the related hip operation
  !>    
  interface rocsparse_hip_malloc_async
    function rocsparse_hip_malloc_async_(mem,nbytes,stream,tag) bind(c, name="rocsparse_hip_malloc_async")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_malloc_async_
      type(c_ptr) :: mem
      integer(c_size_t),value :: nbytes
      type(c_ptr),value :: stream
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipHostFree.
  !>    
  !>      @param[in]
  !>      mem  memory pointer
  !>      @param[in]
  !>      tag  tag to attach to the operation.
  !>    
  !>      \retval error from the related hip operation.
  !>    
  interface rocsparse_hip_host_free
    function rocsparse_hip_host_free_(mem,tag) bind(c, name="rocsparse_hip_host_free")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_host_free_
      type(c_ptr),value :: mem
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipHostMalloc.
  !>    
  !>      @param[in]
  !>      mem  pointer of memory pointer
  !>      @param[in]
  !>      nbytes  number of bytes
  !>      @param[in]
  !>      tag  tag to attach to the operation
  !>    
  !>      \retval error from the related hip operation
  !>    
  interface rocsparse_hip_host_malloc
    function rocsparse_hip_host_malloc_(mem,nbytes,tag) bind(c, name="rocsparse_hip_host_malloc")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_host_malloc_
      type(c_ptr) :: mem
      integer(c_size_t),value :: nbytes
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipFreeManaged.
  !>    
  !>      @param[in]
  !>      mem  memory pointer
  !>      @param[in]
  !>      tag  tag to attach to the operation.
  !>    
  !>      \retval error from the related hip operation.
  !>    
  interface rocsparse_hip_free_managed
    function rocsparse_hip_free_managed_(mem,tag) bind(c, name="rocsparse_hip_free_managed")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_free_managed_
      type(c_ptr),value :: mem
      type(c_ptr),value :: tag
    end function


  end interface
  !> ! \ingroup aux_module
  !>      \brief Wrap hipMallocManaged.
  !>    
  !>      @param[in]
  !>      mem  pointer of memory pointer
  !>      @param[in]
  !>      nbytes  number of bytes
  !>      @param[in]
  !>      tag  tag to attach to the operation
  !>    
  !>      \retval error from the related hip operation
  !>    
  interface rocsparse_hip_malloc_managed
    function rocsparse_hip_malloc_managed_(mem,nbytes,tag) bind(c, name="rocsparse_hip_malloc_managed")
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(hipSuccess)) :: rocsparse_hip_malloc_managed_
      type(c_ptr) :: mem
      integer(c_size_t),value :: nbytes
      type(c_ptr),value :: tag
    end function


  end interface

#ifdef USE_FPOINTER_INTERFACES
  contains
    function rocsparse_create__coo_descr_rank_0(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__coo_descr_rank_0
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(c_int64_t) :: nnz
      void,target :: coo_row_ind
      void,target :: coo_col_ind
      void,target :: coo_val
      integer(kind(rocsparse_indextype_u16)) :: idx_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__coo_descr_rank_0 = rocsparse_create__coo_descr_(descr,rows,cols,nnz,c_loc(coo_row_ind),c_loc(coo_col_ind),c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse_create__coo_descr_rank_1(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__coo_descr_rank_1
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(c_int64_t) :: nnz
      void,target,dimension(:) :: coo_row_ind
      void,target,dimension(:) :: coo_col_ind
      void,target,dimension(:) :: coo_val
      integer(kind(rocsparse_indextype_u16)) :: idx_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__coo_descr_rank_1 = rocsparse_create__coo_descr_(descr,rows,cols,nnz,c_loc(coo_row_ind),c_loc(coo_col_ind),c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse_create_bsr_descr_rank_0(descr,mb,nb,nnzb,block_dir,block_dim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_bsr_descr_rank_0
      type(c_ptr) :: descr
      integer(c_int64_t) :: mb
      integer(c_int64_t) :: nb
      integer(c_int64_t) :: nnzb
      integer(kind(rocsparse_direction_row)) :: block_dir
      integer(c_int64_t) :: block_dim
      void,target :: bsr_row_ptr
      void,target :: bsr_col_ind
      void,target :: bsr_val
      integer(kind(rocsparse_indextype_u16)) :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)) :: col_ind_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create_bsr_descr_rank_0 = rocsparse_create_bsr_descr_(descr,mb,nb,nnzb,block_dir,block_dim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_create_bsr_descr_rank_1(descr,mb,nb,nnzb,block_dir,block_dim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create_bsr_descr_rank_1
      type(c_ptr) :: descr
      integer(c_int64_t) :: mb
      integer(c_int64_t) :: nb
      integer(c_int64_t) :: nnzb
      integer(kind(rocsparse_direction_row)) :: block_dir
      integer(c_int64_t) :: block_dim
      void,target,dimension(:) :: bsr_row_ptr
      void,target,dimension(:) :: bsr_col_ind
      void,target,dimension(:) :: bsr_val
      integer(kind(rocsparse_indextype_u16)) :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)) :: col_ind_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create_bsr_descr_rank_1 = rocsparse_create_bsr_descr_(descr,mb,nb,nnzb,block_dir,block_dim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_create__csr_descr_rank_0(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__csr_descr_rank_0
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(c_int64_t) :: nnz
      void,target :: csr_row_ptr
      void,target :: csr_col_ind
      void,target :: csr_val
      integer(kind(rocsparse_indextype_u16)) :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)) :: col_ind_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__csr_descr_rank_0 = rocsparse_create__csr_descr_(descr,rows,cols,nnz,c_loc(csr_row_ptr),c_loc(csr_col_ind),c_loc(csr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_create__csr_descr_rank_1(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__csr_descr_rank_1
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(c_int64_t) :: nnz
      void,target,dimension(:) :: csr_row_ptr
      void,target,dimension(:) :: csr_col_ind
      void,target,dimension(:) :: csr_val
      integer(kind(rocsparse_indextype_u16)) :: row_ptr_type
      integer(kind(rocsparse_indextype_u16)) :: col_ind_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__csr_descr_rank_1 = rocsparse_create__csr_descr_(descr,rows,cols,nnz,c_loc(csr_row_ptr),c_loc(csr_col_ind),c_loc(csr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_create__csc_descr_rank_0(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__csc_descr_rank_0
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(c_int64_t) :: nnz
      void,target :: csc_col_ptr
      void,target :: csc_row_ind
      void,target :: csc_val
      integer(kind(rocsparse_indextype_u16)) :: col_ptr_type
      integer(kind(rocsparse_indextype_u16)) :: row_ind_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__csc_descr_rank_0 = rocsparse_create__csc_descr_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse_create__csc_descr_rank_1(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__csc_descr_rank_1
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(c_int64_t) :: nnz
      void,target,dimension(:) :: csc_col_ptr
      void,target,dimension(:) :: csc_row_ind
      void,target,dimension(:) :: csc_val
      integer(kind(rocsparse_indextype_u16)) :: col_ptr_type
      integer(kind(rocsparse_indextype_u16)) :: row_ind_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__csc_descr_rank_1 = rocsparse_create__csc_descr_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse_create__bell_descr_rank_0(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__bell_descr_rank_0
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(kind(rocsparse_direction_row)) :: ell_block_dir
      integer(c_int64_t) :: ell_block_dim
      integer(c_int64_t) :: ell_cols
      void,target :: ell_col_ind
      void,target :: ell_val
      integer(kind(rocsparse_indextype_u16)) :: idx_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__bell_descr_rank_0 = rocsparse_create__bell_descr_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,c_loc(ell_col_ind),c_loc(ell_val),idx_type,idx_base,data_type)
    end function

    function rocsparse_create__bell_descr_rank_1(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_create__bell_descr_rank_1
      type(c_ptr) :: descr
      integer(c_int64_t) :: rows
      integer(c_int64_t) :: cols
      integer(kind(rocsparse_direction_row)) :: ell_block_dir
      integer(c_int64_t) :: ell_block_dim
      integer(c_int64_t) :: ell_cols
      void,target,dimension(:) :: ell_col_ind
      void,target,dimension(:) :: ell_val
      integer(kind(rocsparse_indextype_u16)) :: idx_type
      integer(kind(rocsparse_index_base_zero)) :: idx_base
      integer(kind(rocsparse_datatype_f32_r)) :: data_type
      !
      rocsparse_create__bell_descr_rank_1 = rocsparse_create__bell_descr_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,c_loc(ell_col_ind),c_loc(ell_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__coo_get_full_rank(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:,:) :: coo_row_ind
      void,target,dimension(:,:) :: coo_col_ind
      void,target,dimension(:,:) :: coo_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__coo_get_full_rank = rocsparse__coo_get_(descr,rows,cols,nnz,c_loc(coo_row_ind),c_loc(coo_col_ind),c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__coo_get_rank_0(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target :: coo_row_ind
      void,target :: coo_col_ind
      void,target :: coo_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__coo_get_rank_0 = rocsparse__coo_get_(descr,rows,cols,nnz,c_loc(coo_row_ind),c_loc(coo_col_ind),c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__coo_get_rank_1(descr,rows,cols,nnz,coo_row_ind,coo_col_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:) :: coo_row_ind
      void,target,dimension(:) :: coo_col_ind
      void,target,dimension(:) :: coo_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__coo_get_rank_1 = rocsparse__coo_get_(descr,rows,cols,nnz,c_loc(coo_row_ind),c_loc(coo_col_ind),c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__coo_aos_get_full_rank(descr,rows,cols,nnz,coo_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_aos_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      type(c_ptr) :: coo_ind
      void,target,dimension(:,:) :: coo_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__coo_aos_get_full_rank = rocsparse__coo_aos_get_(descr,rows,cols,nnz,coo_ind,c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__coo_aos_get_rank_0(descr,rows,cols,nnz,coo_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_aos_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      type(c_ptr) :: coo_ind
      void,target :: coo_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__coo_aos_get_rank_0 = rocsparse__coo_aos_get_(descr,rows,cols,nnz,coo_ind,c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__coo_aos_get_rank_1(descr,rows,cols,nnz,coo_ind,coo_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__coo_aos_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      type(c_ptr) :: coo_ind
      void,target,dimension(:) :: coo_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__coo_aos_get_rank_1 = rocsparse__coo_aos_get_(descr,rows,cols,nnz,coo_ind,c_loc(coo_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__csr_get_full_rank(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csr_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:,:) :: csr_row_ptr
      void,target,dimension(:,:) :: csr_col_ind
      void,target,dimension(:,:) :: csr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__csr_get_full_rank = rocsparse__csr_get_(descr,rows,cols,nnz,c_loc(csr_row_ptr),c_loc(csr_col_ind),c_loc(csr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse__csr_get_rank_0(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csr_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target :: csr_row_ptr
      void,target :: csr_col_ind
      void,target :: csr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__csr_get_rank_0 = rocsparse__csr_get_(descr,rows,cols,nnz,c_loc(csr_row_ptr),c_loc(csr_col_ind),c_loc(csr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse__csr_get_rank_1(descr,rows,cols,nnz,csr_row_ptr,csr_col_ind,csr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csr_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:) :: csr_row_ptr
      void,target,dimension(:) :: csr_col_ind
      void,target,dimension(:) :: csr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__csr_get_rank_1 = rocsparse__csr_get_(descr,rows,cols,nnz,c_loc(csr_row_ptr),c_loc(csr_col_ind),c_loc(csr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_csc_get_full_rank(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csc_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:,:) :: csc_col_ptr
      void,target,dimension(:,:) :: csc_row_ind
      void,target,dimension(:,:) :: csc_val
      type(c_ptr) :: col_ptr_type
      type(c_ptr) :: row_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse_csc_get_full_rank = rocsparse_csc_get_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse_csc_get_rank_0(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csc_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target :: csc_col_ptr
      void,target :: csc_row_ind
      void,target :: csc_val
      type(c_ptr) :: col_ptr_type
      type(c_ptr) :: row_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse_csc_get_rank_0 = rocsparse_csc_get_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse_csc_get_rank_1(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_csc_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:) :: csc_col_ptr
      void,target,dimension(:) :: csc_row_ind
      void,target,dimension(:) :: csc_val
      type(c_ptr) :: col_ptr_type
      type(c_ptr) :: row_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse_csc_get_rank_1 = rocsparse_csc_get_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse__csc_get_full_rank(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csc_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:,:) :: csc_col_ptr
      void,target,dimension(:,:) :: csc_row_ind
      void,target,dimension(:,:) :: csc_val
      type(c_ptr) :: col_ptr_type
      type(c_ptr) :: row_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__csc_get_full_rank = rocsparse__csc_get_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse__csc_get_rank_0(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csc_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target :: csc_col_ptr
      void,target :: csc_row_ind
      void,target :: csc_val
      type(c_ptr) :: col_ptr_type
      type(c_ptr) :: row_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__csc_get_rank_0 = rocsparse__csc_get_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse__csc_get_rank_1(descr,rows,cols,nnz,csc_col_ptr,csc_row_ind,csc_val,col_ptr_type,row_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__csc_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: nnz
      void,target,dimension(:) :: csc_col_ptr
      void,target,dimension(:) :: csc_row_ind
      void,target,dimension(:) :: csc_val
      type(c_ptr) :: col_ptr_type
      type(c_ptr) :: row_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__csc_get_rank_1 = rocsparse__csc_get_(descr,rows,cols,nnz,c_loc(csc_col_ptr),c_loc(csc_row_ind),c_loc(csc_val),col_ptr_type,row_ind_type,idx_base,data_type)
    end function

    function rocsparse__ell_get_full_rank(descr,rows,cols,ell_col_ind,ell_val,ell_width,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__ell_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      void,target,dimension(:,:) :: ell_col_ind
      void,target,dimension(:,:) :: ell_val
      integer(c_int64_t),target,dimension(:) :: ell_width
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__ell_get_full_rank = rocsparse__ell_get_(descr,rows,cols,c_loc(ell_col_ind),c_loc(ell_val),c_loc(ell_width),idx_type,idx_base,data_type)
    end function

    function rocsparse__ell_get_rank_0(descr,rows,cols,ell_col_ind,ell_val,ell_width,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__ell_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      void,target :: ell_col_ind
      void,target :: ell_val
      integer(c_int64_t),target :: ell_width
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__ell_get_rank_0 = rocsparse__ell_get_(descr,rows,cols,c_loc(ell_col_ind),c_loc(ell_val),c_loc(ell_width),idx_type,idx_base,data_type)
    end function

    function rocsparse__ell_get_rank_1(descr,rows,cols,ell_col_ind,ell_val,ell_width,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__ell_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      void,target,dimension(:) :: ell_col_ind
      void,target,dimension(:) :: ell_val
      integer(c_int64_t),target,dimension(:) :: ell_width
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__ell_get_rank_1 = rocsparse__ell_get_(descr,rows,cols,c_loc(ell_col_ind),c_loc(ell_val),c_loc(ell_width),idx_type,idx_base,data_type)
    end function

    function rocsparse__bell_get_full_rank(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bell_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: ell_block_dir
      type(c_ptr) :: ell_block_dim
      type(c_ptr) :: ell_cols
      void,target,dimension(:,:) :: ell_col_ind
      void,target,dimension(:,:) :: ell_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__bell_get_full_rank = rocsparse__bell_get_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,c_loc(ell_col_ind),c_loc(ell_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__bell_get_rank_0(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bell_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: ell_block_dir
      type(c_ptr) :: ell_block_dim
      type(c_ptr) :: ell_cols
      void,target :: ell_col_ind
      void,target :: ell_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__bell_get_rank_0 = rocsparse__bell_get_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,c_loc(ell_col_ind),c_loc(ell_val),idx_type,idx_base,data_type)
    end function

    function rocsparse__bell_get_rank_1(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,ell_col_ind,ell_val,idx_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bell_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: rows
      type(c_ptr) :: cols
      type(c_ptr) :: ell_block_dir
      type(c_ptr) :: ell_block_dim
      type(c_ptr) :: ell_cols
      void,target,dimension(:) :: ell_col_ind
      void,target,dimension(:) :: ell_val
      type(c_ptr) :: idx_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__bell_get_rank_1 = rocsparse__bell_get_(descr,rows,cols,ell_block_dir,ell_block_dim,ell_cols,c_loc(ell_col_ind),c_loc(ell_val),idx_type,idx_base,data_type)
    end function

    function rocsparse_bsr_get_full_rank(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: brows
      type(c_ptr) :: bcols
      type(c_ptr) :: bnnz
      type(c_ptr) :: bdir
      type(c_ptr) :: bdim
      void,target,dimension(:,:) :: bsr_row_ptr
      void,target,dimension(:,:) :: bsr_col_ind
      void,target,dimension(:,:) :: bsr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse_bsr_get_full_rank = rocsparse_bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_bsr_get_rank_0(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: brows
      type(c_ptr) :: bcols
      type(c_ptr) :: bnnz
      type(c_ptr) :: bdir
      type(c_ptr) :: bdim
      void,target :: bsr_row_ptr
      void,target :: bsr_col_ind
      void,target :: bsr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse_bsr_get_rank_0 = rocsparse_bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_bsr_get_rank_1(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: brows
      type(c_ptr) :: bcols
      type(c_ptr) :: bnnz
      type(c_ptr) :: bdir
      type(c_ptr) :: bdim
      void,target,dimension(:) :: bsr_row_ptr
      void,target,dimension(:) :: bsr_col_ind
      void,target,dimension(:) :: bsr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse_bsr_get_rank_1 = rocsparse_bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse__bsr_get_full_rank(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bsr_get_full_rank
      type(c_ptr) :: descr
      type(c_ptr) :: brows
      type(c_ptr) :: bcols
      type(c_ptr) :: bnnz
      type(c_ptr) :: bdir
      type(c_ptr) :: bdim
      void,target,dimension(:,:) :: bsr_row_ptr
      void,target,dimension(:,:) :: bsr_col_ind
      void,target,dimension(:,:) :: bsr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__bsr_get_full_rank = rocsparse__bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse__bsr_get_rank_0(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bsr_get_rank_0
      type(c_ptr) :: descr
      type(c_ptr) :: brows
      type(c_ptr) :: bcols
      type(c_ptr) :: bnnz
      type(c_ptr) :: bdir
      type(c_ptr) :: bdim
      void,target :: bsr_row_ptr
      void,target :: bsr_col_ind
      void,target :: bsr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__bsr_get_rank_0 = rocsparse__bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse__bsr_get_rank_1(descr,brows,bcols,bnnz,bdir,bdim,bsr_row_ptr,bsr_col_ind,bsr_val,row_ptr_type,col_ind_type,idx_base,data_type)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse__bsr_get_rank_1
      type(c_ptr) :: descr
      type(c_ptr) :: brows
      type(c_ptr) :: bcols
      type(c_ptr) :: bnnz
      type(c_ptr) :: bdir
      type(c_ptr) :: bdim
      void,target,dimension(:) :: bsr_row_ptr
      void,target,dimension(:) :: bsr_col_ind
      void,target,dimension(:) :: bsr_val
      type(c_ptr) :: row_ptr_type
      type(c_ptr) :: col_ind_type
      type(c_ptr) :: idx_base
      type(c_ptr) :: data_type
      !
      rocsparse__bsr_get_rank_1 = rocsparse__bsr_get_(descr,brows,bcols,bnnz,bdir,bdim,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val),row_ptr_type,col_ind_type,idx_base,data_type)
    end function

    function rocsparse_bsr_set_pointers_rank_0(descr,bsr_row_ptr,bsr_col_ind,bsr_val)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_set_pointers_rank_0
      type(c_ptr) :: descr
      void,target :: bsr_row_ptr
      void,target :: bsr_col_ind
      void,target :: bsr_val
      !
      rocsparse_bsr_set_pointers_rank_0 = rocsparse_bsr_set_pointers_(descr,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val))
    end function

    function rocsparse_bsr_set_pointers_rank_1(descr,bsr_row_ptr,bsr_col_ind,bsr_val)
      use iso_c_binding
      use hipfort_rocsparse_enums
      implicit none
      integer(kind(rocsparse_status_success)) :: rocsparse_bsr_set_pointers_rank_1
      type(c_ptr) :: descr
      void,target,dimension(:) :: bsr_row_ptr
      void,target,dimension(:) :: bsr_col_ind
      void,target,dimension(:) :: bsr_val
      !
      rocsparse_bsr_set_pointers_rank_1 = rocsparse_bsr_set_pointers_(descr,c_loc(bsr_row_ptr),c_loc(bsr_col_ind),c_loc(bsr_val))
    end function

  
#endif
end module hipfort_rocsparse