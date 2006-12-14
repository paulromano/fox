module m_sax_types

  use m_common_entities, only: entity_list

  implicit none

  ! Context

  integer, parameter :: CTXT_NULL = -1
  integer, parameter :: CTXT_INIT = 0
  integer, parameter :: CTXT_BEFORE_DTD = 1
  integer, parameter :: CTXT_IN_DTD = 2
  integer, parameter :: CTXT_BEFORE_CONTENT = 3
  integer, parameter :: CTXT_IN_CONTENT = 4
  integer, parameter :: CTXT_AFTER_CONTENT = 5

  ! State

  integer, parameter :: ST_NULL = -1
  integer, parameter :: ST_MISC = 0
  integer, parameter :: ST_BANG_TAG = 1 
  integer, parameter :: ST_START_PI = 2
  integer, parameter :: ST_START_COMMENT = 3
  integer, parameter :: ST_START_TAG = 4 
  integer, parameter :: ST_START_CDATA_1 = 5
  integer, parameter :: ST_START_CDATA_2 = 6
  integer, parameter :: ST_IN_TAG = 7
  integer, parameter :: ST_ATT_NAME = 8
  integer, parameter :: ST_ATT_EQUALS = 9
  integer, parameter :: ST_CHAR_IN_CONTENT = 10
  integer, parameter :: ST_CLOSING_TAG = 11
  integer, parameter :: ST_PI_NAME = 12
  integer, parameter :: ST_PI_END = 13
  integer, parameter :: ST_COMMENT_CONTENTS = 14
  integer, parameter :: ST_COMMENT_END = 15
  integer, parameter :: ST_PI_CONTENTS = 16
  integer, parameter :: ST_CDATA_CONTENTS = 17
  
  type dtd_parser_t
    character(len=1), dimension(:), pointer :: dtd
    character(len=1), dimension(:), pointer :: token
    character(len=1), dimension(:), pointer :: docTypeName
    character(len=1), dimension(:), pointer :: PublicId
    character(len=1), dimension(:), pointer :: SystemId
    character(len=1), dimension(:), pointer :: entityName
    character(len=1), dimension(:), pointer :: entityContent
    character(len=1), dimension(:), pointer :: entityPublicId
    character(len=1), dimension(:), pointer :: entitySystemId
    character(len=1), dimension(:), pointer :: NdataValue
    type(entity_list) :: pe_list
    type(entity_list) :: entity_list
    integer :: dtd_state
    logical :: external_found
    logical :: parameter_entity
    logical :: internal_subset
  end type dtd_parser_t

  type sax_error_t
    character, dimension(:), pointer :: msg
  end type sax_error_t

  type sax_parser_t
    logical :: discard_whitespace = .false.
    logical :: long_token = .false.
    integer :: context 
    integer :: state
    integer :: parse_stack = 0
    logical :: well_formed = .false.
    type(dtd_parser_t) :: dtd_parser
    character, dimension(:), pointer :: token => null()
    type(sax_error_t), dimension(:), pointer :: error_stack => null()
    integer :: xml_version
    character, dimension(:), pointer :: encoding
    logical :: standalone
    character, dimension(:), pointer :: initialNameChars
    character, dimension(:), pointer :: NameChars
  end type sax_parser_t


end module m_sax_types
