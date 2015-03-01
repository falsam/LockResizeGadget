;LockResizeGadget.pbi Version 1.30
;
;Version lib
;Create : 07 Aout 2012
;Update : 18 Janvier 2015
;
;OS : Window, Linux (En principe), OSx (En principe)
;PB 4.51, --> 5.31
;
;
;Contributors
; Falsam
;
; Licence : Use As You Like
;


;
; Initialisation
ProcedureDLL UseLockGadget()
  Structure Gadget
    Window.i      
  
    Gadget.i  
  
    DeltaLeft.i   
    DeltaTop.i         
    DeltaRight.i       
    DeltaBottom.i  
  
    Width.i
    Height.i      
  
    LockLeft.b    
    LockTop.b     
    LockRight.b   
    LockBottom.b  
    
    HorizontalCenter.b
    VerticalCenter.b
  EndStructure      

  Global NewList LockGadgets.Gadget()
EndProcedure

; 
;Fixe (#True) ou pas (#False) les bords d'un gadget sur une fenêtre.
;Centre (#True) ou pas (#False) un gadget horizontalement et/ou verticalement.
Procedure LockGadget_All(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom, HorizontalCenter, VerticalCenter)

  AddElement(LockGadgets())
  
  With LockGadgets()
  
    \Gadget = Gadget
    \Window = window
    
    \LockLeft = Lockleft
    \LockTop = Locktop
    \LockRight = Lockright
    \LockBottom = LockBottom
    \HorizontalCenter = HorizontalCenter
    \VerticalCenter = VerticalCenter
    
    \DeltaLeft = GadgetX(Gadget)
    \DeltaTop = GadgetY(Gadget)     
    \DeltaRight = WindowWidth(Window) - GadgetX(Gadget) - GadgetWidth(Gadget)
    \DeltaBottom = WindowHeight(Window) - GadgetY(Gadget) - GadgetHeight(Gadget)
    
    \Width = GadgetWidth(Gadget)
    \Height = GadgetHeight(Gadget)
  EndWith
  ProcedureReturn #True
EndProcedure

ProcedureDLL LockGadget(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom)
  HorizontalCenter = #False
  VerticalCenter   = #False
  
  ProcedureReturn LockGadget_All(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom, HorizontalCenter, VerticalCenter)
EndProcedure

ProcedureDLL LockGadget2(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom, HorizontalCenter)  
  ProcedureReturn LockGadget_All(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom, HorizontalCenter, VerticalCenter)
EndProcedure

ProcedureDLL LockGadget3(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom, HorizontalCenter, VerticalCenter)  
  ProcedureReturn LockGadget_All(Window, Gadget, LockLeft, LockTop, LockRight, LockBottom, HorizontalCenter, VerticalCenter)
EndProcedure

;
; Unlock un ou tous(Gadget.l=#True) les gadget d'une fenetre
ProcedureDLL UnLockGadget(Window.l, Gadget.l=#True)
  ForEach LockGadgets()
    If LockGadgets()\Window = Window
      If LockGadgets()\Gadget = Gadget Or Gadget=#True
        DeleteElement(LockGadgets())
      EndIf
    EndIf
  Next
EndProcedure


;
; Redimensionne les gadgets mémorisés dans la liste.
ProcedureDLL ResizeGadgets(Window.i)
  Protected Gadget.i, X.i, Y.i, W.i, H.i
      
    ForEach LockGadgets()
      
      If LockGadgets()\Window = Window
        
        With LockGadgets()
          
          Gadget = \Gadget
          X = WindowWidth(window) - \DeltaRight - \Width
          Y = WindowHeight(window) - \DeltaBottom - \Height
          W = #PB_Ignore
          H = #PB_Ignore 
          
          If \LockRight = #False
            X = #PB_Ignore
          EndIf
          
          If \LockBottom = #False
            Y = #PB_Ignore
          EndIf
          
          If \LockLeft = #True   
            X = \DeltaLeft
          EndIf
              
          If \LockTop = #True
            Y = \DeltaTop
          EndIf        
                  
          If \LockRight = #True
            W = WindowWidth(Window) - X - \DeltaRight
          EndIf
          
          If \LockBottom = #True
            H = WindowHeight(Window) - Y - \DeltaBottom
          EndIf
          
          If \HorizontalCenter = #True
            X = (WindowWidth(Window) - \Width)/2
          EndIf
          
          If \VerticalCenter = #True
            Y = (WindowHeight(Window) - \Height)/2
          EndIf
                    
          ResizeGadget(Gadget, X, Y, W, H)
        EndWith
        
      EndIf
    Next
    
EndProcedure

; 
; Détruit la Liste et libère toutes les ressources associées
ProcedureDLL FreeLockGadget()
  ResetList(LockGadgets())  
EndProcedure
