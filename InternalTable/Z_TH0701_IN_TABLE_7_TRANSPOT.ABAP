*&---------------------------------------------------------------------*
*& Report  Z_TH0701_IN_TABLE_7_TRANSPORT
*&
*&---------------------------------------------------------------------*
*& Scenario 1. READ ~ TRANSPORTING Syntax�� Ȱ���Ͽ�, Ư�� Į������ �����غ���.
*&            zthsoccer���̺��� �������� '�����', ������ 'ȣ���� ���� ����'���� �ϴ� ����ü�� ����غ���.
*&
*&---------------------------------------------------------------------*

REPORT  Z_TH0701_IN_TABLE_7_TRANSPORT.

DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab LIKE LINE OF it_tab.

select name salary
  FROM zthsoccer into CORRESPONDING FIELDS OF TABLE it_tab.

  wa_tab-name = '�����'.

  READ TABLE it_tab into wa_tab WITH KEY name = 'ȣ����' TRANSPORTING salary.

WRITE : / wa_tab-name, wa_tab-salary.