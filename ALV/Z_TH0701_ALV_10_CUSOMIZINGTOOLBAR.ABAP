*&---------------------------------------------------------------------*
*&      Form  set_grid_layo_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->CS_LAYO    text
*----------------------------------------------------------------------*
*******************************************************************************************************************************
* Written By TaeHyeong                                                                                                                 
* Reporting Date: '18.11.21.                                                                                                              
* Subject: Delete Standard Application Toolbar and Customizing .           
*******************************************************************************************************************************
FORM set_grid_layo_100  CHANGING cs_layo TYPE lvc_s_layo.
*... ALV-Control: Allgemeine Anzeigeoptionen
*...
*... ALV-Control: Gridcustomizing
  cs_layo-no_colexpd  = space.
  cs_layo-no_hgridln  = space.
  cs_layo-no_vgridln  = space.
  cs_layo-no_rowmark  = space.
  cs_layo-no_headers  = space.
  cs_layo-no_merging  = space.
  cs_layo-grid_title  = space.

  cs_layo-no_toolbar  = 'X'.                "
*....
* ���Ŀ��� SET PF-STATUS �� Ȱ���Ͽ� �ְ� ���� Application Toolbar ��ư���� �־��ָ� ��.