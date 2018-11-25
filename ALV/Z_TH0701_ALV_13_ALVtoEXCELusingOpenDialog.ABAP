***********************************************************************
*Written By: TaeHyeong
*Reporting Date: `18.11.22
*Subject: Convert ALV to EXCEL and Assign path through Click Drill
*&---------------------------------------------------------------------*
*& Include ZSFR001_08_TOP                                    Report ZSFR001_08
*&
*&---------------------------------------------------------------------*
    DATA: file_name TYPE string.
    DATA: file_path TYPE string.
    DATA : result_filename TYPE string.
************************************************************************
*
*                            F01
*
*&---------------------------------------------------------------------*
*&      Form  excel
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM excel.
  CALL METHOD cl_gui_frontend_services=>file_save_dialog                "1. Excel Save Dialog Call
    CHANGING
      path = file_path                                                  "  ��. ��� ������ ��ȯ.(Obligatory)
      fullpath = result_filename                                        "  ��. ��ü ��θ� ��ȯ.(Obligatory)
       filename = file_name.                                            "  ��. ���� �� ��ȯ.(Obligatory)
  CALL METHOD cl_gui_frontend_services=>gui_download                    "2. Excel Download Function
    EXPORTING
      filename              = file_name                                 "   ��. ���ϸ� �Է�.
      write_field_separator = 'X'                                       "   ��. �������� ��Ʈ�� �����̾����� �ɼǵ� ��ô�.
*      FILETYPE = 'XLS'
    CHANGING
      data_tab              = it_tab.                                   "   ��. �����Ͱ� ��� ���ͳ����̺��� �������ش�.


ENDFORM.                    "excel