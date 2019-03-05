*&---------------------------------------------------------------------*
*& Report  ZPPR0011_08
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE ZPPR0011_08_TOP                         .    " global Data

 INCLUDE ZPPR0011_08_O01                         .  " PBO-Modules
 INCLUDE ZPPR0011_08_I01                         .  " PAI-Modules
 INCLUDE ZPPR0011_08_F01                         .  " FORM-Routines

 START-OF-SELECTION.
  PERFORM select_data.
  IF radio2 = 'X'.
    PERFORM select_check.
  ELSEIF radio3 = 'X'.
    PERFORM select_not.
  ENDIF.
  call screen 100.

*GUI Texts
*----------------------------------------------------------
* TH --> Routing ���� ��Ȳ

*Text elements
*----------------------------------------------------------
* 001 ALL
* 002 Check
* 003 Not Check


*Selection texts
*----------------------------------------------------------
* S_MATNR         �����ȣ
* S_WERKS         �÷�Ʈ


*Messages
*----------------------------------------------------------
*
* Message class: Hard coded
*   ���� �����Ͻ��� �ʾҽ��ϴ�.

----------------------------------------------------------------------------------
Extracted by Direct Download Enterprise version 1.3.1 - E.G.Mellodew. 1998-2005 UK. Sap Release 701