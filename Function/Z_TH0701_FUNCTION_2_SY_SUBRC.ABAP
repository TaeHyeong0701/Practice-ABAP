*&---------------------------------------------------------------------*
*& Report  Z_TH0701_FUNCTION_2_SY_SUBRC
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
* ABAP Dictionary�� ���ǵ� ���̺��� ��������, ���� ������, sy-subrc�� Ȱ���Ͽ�, ������� �����ϵ��� Ȱ���غ���.
* ������ ���� ���� ���� ��ȸ�� ��, SY-SUBRC���� 4�� ���� Ȯ���� �� �ִ�.
REPORT  Z_TH0701_FUNCTION_2_SY_SUBRC.

DATA : warning TYPE String.
types : BEGIN OF st_sflcrew,
  carrid type c length 3,
  FLDATE TYPE D,
  EMP_NUM TYPE n LENGTH 10,
  ROLE TYPE c LENGTH 25,
END OF st_sflcrew.

DATA : wo_sflcrew TYPE st_sflcrew.


SELECT carrid fldate emp_num role FROM sflcrew INTO wo_sflcrew
  WHERE CARRID = 'AB'.                                          " ---> AA�� �����Ͽ� ��ȸ�ϸ� ������. : ���� �����ϱ� ����.
ENDSELECT.
  IF SY-SUBRC = 0.
  ELSE.
      WRITE : / '�ش� �ϴ� �װ����� �����ʹ� �����ϴ�.'.
  ENDIF.

 SELECT CARRID fldate emp_num role FROM sflcrew INTO wo_sflcrew
   where FLDATE = 99999999.                                      " ---> 20090709�� �����Ͽ� ��ȸ�ϸ� ������. : ���� �����ϱ� ����.
 ENDSELECT.
     IF SY-SUBRC = 0.
     ELSE.
     WRITE : / '�ش����ڿ� �������� �ʾҽ��ϴ�.'.
 ENDIF.

* SY-SUBRC = 0 ---> �����Ͱ��� ���������� �Ҵ�Ǿ��� ���.
* SY-SUBRC = 4 ---> �����Ͱ��� �Ҵ���� �ʾ��� ���.