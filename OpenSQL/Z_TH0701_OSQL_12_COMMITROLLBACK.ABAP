*&---------------------------------------------------------------------*
*& Report  Z_TH0701_COMMITROLLBACK
*&
*&---------------------------------------------------------------------*
*& Written By TaeHyeong
*& Reporting Date: `18.11.24.
*& Subject: Commitwork and Rollbackwork Study Add.
*&---------------------------------------------------------------------*
* Scenario 1. Add '���' soccer player Data
*          2. Rollbackwork.
*          3. print where name = '���'
*          4. Add 'Ȳ����' soccer player Data
*          5. Commitwork.
*          6. print where name = 'Ȳ����'
************************************************************************

REPORT  Z_TH0701_COMMITROLLBACK.


DATA : it_tab TYPE TABLE OF zthsoccer,
      wa_tab like LINE OF it_tab.

SELECT MAX( soccer_num )                                                 "---> soccer_num�� �����س���, ���� ��ȣ�� ���� �Է��ϱ� ���� ����.
  FROM ZTHSOCCER INTO wa_tab-soccer_num.

wa_tab-soccer_num = wa_tab-soccer_num + 1.                               "---> ���ϸ޵� ��� ���� �Է� ����.
wa_tab-team = '����Ǯ'.
wa_tab-name = '���ϸ޵� ���'.
wa_tab-height = 175.
wa_tab-weight = 71.
wa_tab-soccer_position = 'FW'.
wa_tab-nation = '����Ʈ'.
wa_tab-salary = 174.

MODIFY zthsoccer FROM wa_tab.                                            "---> DB���̺� ����
ROLLBACK WORK.                                                           "---> ROLLBACK �������� Ʈ������� �ǵ�����.

CLEAR wa_tab.                                                            "---> Garbage ó��.
SELECT name                                                              "---> ���ϸ޵� ��� ���� ����.
  FROM zthsoccer into CORRESPONDING FIELDS OF wa_tab
  where name = '���ϸ޵� ���'.
  ENDSELECT.                                                             
  IF SY-SUBRC = 0.                                                       "---> ���Ȯ�� : Ȯ�ΰ�� '���' ������ �����ʹ� "�ѹ�"���� ���� ������� �ʾҴ�.
WRITE : / 'Commit ���:',wa_tab-name.
  ELSE .
  WRITE: / 'Rollback ���: ���ϴ� ���� ����.'.         
  ENDIF.

CLEAR wa_tab.

SELECT MAX( soccer_num )                                                 "---> soccer_num�� �����س���, ���� ��ȣ�� ���� �Է��ϱ� ���� ����.
  FROM ZTHSOCCER INTO wa_tab-soccer_num.                                 

wa_tab-soccer_num = wa_tab-soccer_num + 1.                               "---> Ȳ����  ���� �Է� ����.
wa_tab-team = '���� ����ī'.
wa_tab-name = 'Ȳ����'.
wa_tab-height = 184.
wa_tab-weight = 73.
wa_tab-soccer_position = 'FW'.
wa_tab-nation = '���ѹα�'.
wa_tab-salary = 7.
MODIFY zthsoccer FROM wa_tab.                                              "---> DB���̺� ����
COMMIT WORK.                                                               "---> COMMIT �������� Ʈ������� Ŀ���Ѵ�.
CLEAR wa_tab.                                                              "---> Garbage ó��.
SELECT name                                                                "---> Ȳ����  ���� ����.
  FROM zthsoccer into CORRESPONDING FIELDS OF wa_tab
  where name = 'Ȳ����'.
  ENDSELECT.
    IF SY-SUBRC = 0.                                                       "---> ���Ȯ�� : Ȯ�ΰ�� 'Ȳ����' ������ �����ʹ� "Ŀ��"���� ���� ����Ϸ�Ǿ���.
WRITE : / 'Commit ���:',wa_tab-name.
  ELSE .
  WRITE: / 'Commit ���: ���ϴ� ���� ����.'.
  ENDIF.