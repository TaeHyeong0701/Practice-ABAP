*&---------------------------------------------------------------------*
*& Include ZPPR0011_08_TOP                                   Report ZPPR0011_08
*&
*&---------------------------------------------------------------------*

REPORT   ZPPR0011_08.
************************************************************************
* 1. MARA: MATNR�� ������ �ɼǽ����� ����ϱ� ����.
* 2. MAPL: PLNTY�� ������ �ɼǽ����� ����ϱ� ����.
************************************************************************
TABLES MARA.
TABLES MAPL.
TABLES icon.
*************************************************************************
* ����ü �� ���ͳ� ���̺� ����.
*************************************************************************
DATA : BEGIN OF gs_tab.
DATA : MATNR TYPE mara-matnr,
      werks TYPE mapl-werks,
      plnty TYPE mapl-plnty,
      plnnr TYPE mapl-plnnr,
      plnal TYPE mapl-plnal,
      c_light TYPE icon-id,
END OF gs_tab.
************************************************************************
*  ��Ƽ�� ����Ʈ �ο� ��.
************************************************************************
DATA: INDEX_ROWS TYPE LVC_T_ROW,
      index_id TYPE  LVC_T_ROID ,
INDEX LIKE LINE OF INDEX_ROWS.


DATA : it_tab LIKE TABLE OF gs_tab,
      wa_tab LIKE LINE OF it_tab.
************************************************************************
*  ALV�� ���Ǵ� ��ȣ�� / �� // ��  // ��.
************************************************************************
CONSTANTS: c_green TYPE icon-id VALUE '@08@',
c_yellow TYPE icon-id VALUE '@09@',
c_red TYPE icon-id VALUE '@0A@'.
************************************************************************
* ALV �⺻ ���ø�.
************************************************************************
DATA : container TYPE REF TO cl_gui_custom_container,            "�����̳� ����. ---> cl_gui_custom_container Ŭ���� ����.
       grid TYPE REF TO cl_gui_alv_grid,                         "�׸��� ����.  ---> cl_gui_alv_grid Ŭ���� ����.
       ok_code TYPE sy-ucomm.                                     "Ŭ�� ���� ����.
DATA: ls_layo TYPE lvc_s_layo,
     lt_fcat TYPE lvc_t_fcat.

************************************************************************
* BAPI �۷ι� ����. LIST_USAGE(1), LIST_STATUS(4), ��� ���ͳ� ���̺� �� workarea
************************************************************************
DATA:
      gv_group       TYPE bapi1012_tsk_c-task_list_group value 1,  "1
      gv_gr_counter  TYPE  bapi1012_tsk_c-group_counter value 4,   "4
      IT_RET TYPE TABLE OF BAPIRET2,
      wa_ret LIKE LINE OF it_ret.       "
*gv_test_run    TYPE bapiflag,

************************************************************************
* BAPI OP(Operation ����) �۷ι� ���ͳ� / WorkArea  PLANT(1200), Control key(PP01), Description(test material)
************************************************************************
data : IT_OP TYPE TABLE OF BAPI1012_OPR_C,
      wa_op LIKE LINE OF it_op.
*************************************************************************
** BAPI task �۷ι� ���ͳ� / WorkArea
*************************************************************************
DATA : it_task TYPE TABLE OF bapi1012_tsk_c,
      wa_task LIKE LINE OF it_task.
************************************************************************
* BAPI it_mat_task �۷ι� ���ͳ� / WorkArea ---> ���� material, plant, valid_from ����.
************************************************************************
data : IT_MAT_TASK_ALLO TYPE TABLE OF BAPI1012_MTK_C ,
       wa_mat_task_allo LIKE LINE OF it_mat_task_allo.
************************************************************************
* BAPI it_inspchar �۷ι� ���ͳ� / WorkArea ---> ������ Labor ?  Machine ?
************************************************************************
*DATA : it_inspchar TYPE TABLE OF bapi1012_cha_c,
*      wa_inspchar like LINE OF it_inspchar.
************************************************************************
* ��� ����� ���̺�.
************************************************************************
DATA : it_result TYPE TABLE OF ZPPT0011_08,
       wa_result LIKE LINE OF it_result.

DATA : ch_num TYPE i.
DATA : ch_true TYPE i.
************************************************************************
* selection-options
************************************************************************
SELECT-OPTIONS: S_MATNR FOR MARA-MATNR.
PARAMETERS : S_werks TYPE mapl-werks DEFAULT 1200.
*************************************************************************
* ALL, (Routing) check, NOT CHECK  ���� ��ư ���.
*************************************************************************
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS : radio1 RADIOBUTTON GROUP TH.
SELECTION-SCREEN COMMENT 3(10) text-001 FOR FIELD radio1.
PARAMETERS : radio2 RADIOBUTTON GROUP TH.
SELECTION-SCREEN COMMENT 16(10) text-002 FOR FIELD radio2.
PARAMETERS : radio3 RADIOBUTTON GROUP TH.
SELECTION-SCREEN COMMENT 29(10) text-003 FOR FIELD radio3.
SELECTION-SCREEN END OF LINE.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701