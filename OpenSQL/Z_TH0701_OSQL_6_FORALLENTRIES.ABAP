*&---------------------------------------------------------------------*
*& Report  Z_TH0701_OSQL_6_FORALLENTRIES
*&
*&---------------------------------------------------------------------*
*& �˰Ե� ��� 1. 2�� �̻��� ���̺��� �����ϴµ�, ������ �ʵ������ �������� ���� ������ FOR ALL ENTRIES ������ ��밡��.
*&          2. ���� SELECT ������ ������� �����Ƿ�, �����ս� ����.
*&          3. Syntax : ~ FORALL ENTRIES IN a���ͳ����̺�
*&                        �ʵ�1 = a���ͳ����̺�-�ʵ�2                          ----> a���ͳ� ���̺��� �ʵ尪�� ���ؼ� b select�� ���.
*&
*&---------------------------------------------------------------------*

REPORT  z_th0701_osql_6_forallentries.

DATA : BEGIN OF gs_tab.
        INCLUDE STRUCTURE zthsoccer.                                               "INCLUDE STRUCTURE ����, �ش� ����ü �ȿ�, ������ �����ϴ� ����ü ���¸� �߰��� �� �ִ�.
DATA : player_car TYPE zthsoccer_car-player_car,
     END OF gs_tab.

DATA : it_tab LIKE TABLE OF gs_tab,                                                "��ü�� �����ϴ� ���̹Ƿ�, LIKE���� ���.
       wa_tab LIKE LINE OF it_tab.

DATA : it_zthsoccer_car TYPE TABLE OF zthsoccer_car,
       wa_zthsoccer_car LIKE LINE OF it_zthsoccer_car.

SELECT *
  FROM zthsoccer INTO TABLE it_tab
  WHERE nation = '�Ƹ���Ƽ��'.

*---------------------------------------------------------------------------------- ������ �ִ� ���ͳ� ���̺���  it_tab���� ���ؼ� �ش��ϴ� ���鸸 �־��ش�.
SELECT *
  FROM zthsoccer_car INTO TABLE it_zthsoccer_car
  FOR ALL ENTRIES IN it_tab
  WHERE soccer_name = it_tab-name.

*---------------------------------------------------------------------------------- it_tab�� �������� ������, 2��° ���ͳ� ���̺��� ���� IT_TAB�� �־��ش�.
LOOP AT it_tab INTO wa_tab.
  READ TABLE it_zthsoccer_car INTO wa_zthsoccer_car WITH KEY soccer_name = wa_tab-name. " wa_tab�� name�ʵ尪�� ������ soccer_name �� �ִ� ���ڵ带 �����Ͽ�
                                                                                    " ����ü�� �־��ش�.

*  IF sy-subrc = 0 .  " ���� �ִٸ�.
    wa_tab-player_car = wa_zthsoccer_car-player_car.  "wa_tab�� player_car�� wa_zthsoccer�� player_car�� ���������ش�.
*  ENDIF.
  MODIFY it_tab FROM wa_tab.                      "it_tab ���ͳ� ���̺��� ��������ش�.
  CLEAR wa_tab.
 ENDLOOP.

*------------------------------------------------------------------------------------ �ϼ��� it_tab�� ������� Ȯ���غ���.
 LOOP AT it_tab INTO wa_tab.
   WRITE : / wa_tab-name, wa_tab-weight, wa_tab-player_car.
 ENDLOOP.