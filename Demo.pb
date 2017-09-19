;EnableExplicit

IncludeFile "LockResize.pb"

Enumeration
  #Mainform
  #Test1
  #Test2
  #Test3
  #Test4
  #Test5
  #Test6
EndEnumeration


Define.l Event, WEvent, MEvent, GEvent, TEvent

Global WindowStyle.i=#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_ScreenCentered|#PB_Window_SizeGadget

Procedure Open_MainForm()
  OpenWindow(#Mainform, 0, 0, 500, 400, "Demo LockResizeGadget", WindowStyle)
  
  ;Fixe les dimenstions Minimum est maximum de la fenetre (#PB_Ignore dans cet exemple)
  WindowBounds(#Mainform, 300, 400, #PB_Ignore, #PB_Ignore)
    
  StringGadget(#Test1, 10, 10, 300, 20, "")
  ListIconGadget(#Test2, 10, 35, 300, 300,"Col1",100)
  ListViewGadget(#Test3, 320, 10, 100, 325)
  ComboBoxGadget(#Test4, 10, 350, 410, 22)
  ButtonGadget(#Test5, 430, 10, 50, 22, "Test")
  
  TextGadget(#Test6, 180, 380, 160, 22, "Lock with LockResizeGadget")
  
  SmartWindowRefresh(#Mainform, #True)
  
  LockGadget(#Mainform, #Test1, #True, #True, #True, #False)
  LockGadget(#Mainform, #Test2, #True, #True, #True, #True)
  LockGadget(#Mainform, #Test3, #False, #True, #True, #True)
  LockGadget(#Mainform, #Test4, #True, #False, #True, #True)
  LockGadget(#Mainform, #Test5, #False, #True, #True, #False)
  
  LockGadget(#Mainform, #Test6, #False, #False, #False, #True, #True)  
EndProcedure

UseLockGadget()
Open_MainForm()

Repeat : Until WaitWindowEvent(10) = #PB_Event_CloseWindow
; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP