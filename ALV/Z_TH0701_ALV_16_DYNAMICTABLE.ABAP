*&---------------------------------------------------------------------*
*& Report  Z_TH0701_DNTABLE
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong Kim
*& Reporting Date: `18.11.27
*& Subject: Dynamic Table Function
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_DNTABLE.
*---------------------------------------< ALV��� ����.
DATA : OK_CODE TYPE SY-UCOMM,
      container TYPE REF TO cl_gui_custom_container,
      grid TYPE REF TO cl_gui_alv_grid.

*---------------------------------------< Data Declaration 1: ���ͳ� ���̺��� �����ϱ� ���� ����.
DATA : d_wa_tab TYPE REF TO data,
      d_it_tab TYPE REF TO data,

*----------------------------------------< Data Declaration 2: Nametab internal table, workarea ---> nametab�� ������ �޾��ֱ� ���� internaltable�� workarea
      it_nametab LIKE TABLE OF dntab,
      wa_nametab LIKE LINE OF it_nametab,

*----------------------------------------< Data Declaration 3: �ʵ�īŻ�α� ---> �������̺��� ����(�ʵ��, ���� �ʵ��, nametab ��� ���̺�)
      lt_fcat TYPE TABLE OF lvc_s_fcat,
      ls_fcat LIKE LINE  OF lt_fcat.
*----------------------------------------< Data Declaration 4: �������̺� �ʵ�ɺ� internaltable ---> �������̺��� ������ �Ҵ��ϱ� ����  internaltable�� workare�� �ʵ�ɺ�
FIELD-SYMBOLS: <d_it_tab> TYPE table,
               <d_wa_tab> TYPE ANY.
*----------------------------------------< 1. �Ķ���� �Է� ���
PARAMETERS tbname TYPE CHAR30.             

*----------------------------------------< 2. �������̺��� ��Ī�� �ʵ����  �˾Ƴ��ڴ�!
 CALL FUNCTION 'NAMETAB_GET'
    EXPORTING
      langu          = sy-langu                 " ���� ������� ���� �����Ѵ�.
      tabname        = tbname                   " �Է��� �Ķ���Ͱ����� ���̺����� �ְڴ�.
    TABLES
      nametab        = it_nametab               " ���ϴ� ���̺��� ��ȯ�Ѵ�.
    EXCEPTIONS
      no_texts_found = 1.
SORT it_nametab BY position.
*----------------------------------------< 3. NAMETAB�� ����� ������ �ʵ��, ���� �ʵ��, ���� ���̺� ������ �ʵ�īŻ�α׿� �Ѱ��ش�.
 LOOP AT it_nametab into wa_nametab.
       IF sy-subrc = 0.
   ls_fcat-fieldname =  wa_nametab-fieldname.       " �ʵ������ �Ѱ��ش�.
 	 ls_fcat-ref_table =  tbname.                     " ���� ���̺����� �Ѱ��ش�.
 	 ls_fcat-ref_field =  wa_nametab-fieldname.       " ���� �ʵ���� �Ҵ��Ѵ�.
 	 APPEND  ls_fcat  TO lt_fcat.
   ENDIF.
 ENDLOOP.
*----------------------------------------< 4. ���̳��� ���̺��� ����� ����.
CALL METHOD cl_alv_table_create=>create_dynamic_table
  EXPORTING
    it_fieldcatalog = lt_fcat
  IMPORTING
    ep_table        = d_it_tab.

ASSIGN d_it_tab->* to <d_it_tab>.

*CREATE DATA d_wa_tab LIKE LINE OF <d_it_tab>.
*ASSIGN d_wa_tab->* TO <d_wa_tab>.
*----------------------------------------< 5. ���̳��� ���̺��� ���� �Ҵ�����ش�.
select * from (tbname) into CORRESPONDING FIELDS OF TABLE <d_it_tab> UP TO 50 ROWS.

*----------------------------------------< 6. ��ũ���� �θ� ���� ALV�� ȣ���Ѵ�.
CALL SCREEN 100.

*...
*&---------------------------------------------------------------------*
*&      Module  INIT_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

*----------------------------------------< 7. ���� ���̺��� �������̺��� �ʵ�īŻ�α׸� �����Ѵ�.
  CALL METHOD grid->set_table_for_first_display
  CHANGING
    it_outtab = <d_it_tab>                                             
    it_fieldcatalog = lt_fcat.