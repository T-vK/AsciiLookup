﻿#SingleInstance, force

Gui, Add, Text, , Ascii
Gui, Add, Edit, vAscii gCtrlEvent

Gui, Add, Text, , Dec
Gui, Add, Edit, vDec gCtrlEvent

Gui, Add, Text, , Hex
Gui, Add, Edit, vHex gCtrlEvent

Gui, Show,, AsciiLookup

GuiClose(hwnd:=0) {
    ExitApp
}

CtrlEvent(CtrlHwnd:=0, GuiEvent:="", EventInfo:="", ErrLvl:="") {
    GuiControlGet, controlName, Name, %CtrlHwnd%
    If IsGuiControlFocused(controlName) {
        If (controlName = "Ascii") {
            GuiControlGet, Ascii
            char := SubStr(Ascii, 1, 1)
            GuiControl,, Ascii, % char
            dec := Asc(char)
            GuiControl,, Dec, % dec
            GuiControl,, Hex, % DecToHex(dec)
        } Else If (controlName = "Dec") {
            GuiControlGet, Dec
            GuiControl,, Ascii, % Chr(Dec)
            GuiControl,, Hex, % DecToHex(Dec)
        } Else If (controlName = "Hex") {
            GuiControlGet, Hex
            dec := HexToDec(Hex)
            GuiControl,, Ascii, % Chr(dec)
            GuiControl,, Dec, % dec
        }
    }
}
IsGuiControlFocused(controlName) {
    GuiControlGet, focused, FocusV
    Return focused = controlName
}

HexToDec(str){
    static _0:=0,_1:=1,_2:=2,_3:=3,_4:=4,_5:=5,_6:=6,_7:=7,_8:=8,_9:=9,_a:=10,_b:=11,_c:=12,_d:=13,_e:=14,_f:=15
    str:=ltrim(str,"0x `t`n`r"),   len := StrLen(str),  ret:=0
    Loop,Parse,str
      ret += _%A_LoopField%*(16**(len-A_Index))
    return ret
}
DecToHex(p_num) {
    A_FormatInteger_bkp:=A_FormatInteger
    SetFormat, Integer, H
    p_num+=0
    SetFormat, Integer, %A_FormatInteger_bkp%
    return p_num
}