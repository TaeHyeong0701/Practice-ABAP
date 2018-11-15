*&---------------------------------------------------------------------*
*& Include Z_TH0701_COLOR_ROW2_TOP                           Report Z_TH0701_COLOR_ROW2
*&
*&---------------------------------------------------------------------*

REPORT   Z_TH0701_COLOR_ROW2.
DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE pa0001.
DATA: stext TYPE stext,
      ddtext TYPE dd07t-ddtext,
      linecolor(4) TYPE C,                
      icon(4) type c,                     " 1. ������ Ÿ�� ����.
      END OF gs_tab,
      gt_tab LIKE TABLE OF gs_tab.

*&---------------------------------------------------------------------*
*&  Include           Z_TH0701_COLOR_ROW2_F01
*&---------------------------------------------------------------------*
  LOOP AT it_tab INTO wa_tab.
    CASE wa_tab-ddtext.
      when 'Female'.                 "2. ����(���� �ʵ尡 'Female')�� ����, �������� LS(�� ���� ȭ��ǥ)���� �ٲ��ش�.
        wa_tab-linecolor = 'C610'.   
        wa_tab-icon = '@LS@'.
       when 'Male'.                  "2. ����(���� �ʵ尡 'Male')�� ����, ������ LR(�Ʒ� ���� ȭ��ǥ)���� �ٲ��ش�.
         wa_tab-linecolor = 'C110'.  
                 wa_tab-icon = '@LR@'.
        ENDCASE.
        MODIFY it_tab FROM wa_tab.
        ENDLOOP.

*&---------------------------------------------------------------------*
*&      Form  set_grid_fcat
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CT_FCAT    text
*----------------------------------------------------------------------*
   ls_fcat-fieldname = 'ICON'.
  ls_fcat-OUTPUTlen    = 4.
  ls_fcat-col_pos   = 3.
  ls_fcat-scrtext_s = '�ɺ�'.
  ls_fcat-icon = 'X'.             "icon field���� �ƴ��� ������ �Ǵ����ִ� �Ӽ�.

*  ls_fcat-emphasize = 'X'.
  APPEND ls_fcat TO ct_fcat.
  CLEAR ls_fcat.