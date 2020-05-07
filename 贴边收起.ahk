#Persistent
#SingleInstance,force

;边缘的距离范围
Thresholds = 15

;每1000ms检测一次
SetTimer, WatchWindows, 1000
WatchWindows:
    ;获取鼠标下的窗口ID
    MouseGetPos, , , currId, control
    ;获取目标窗口位置和大小
    WinGetPos, x1,y1, Width1, Height1, ahk_id %active_id_0%
    WinGetPos, x2,y2, Width2, Height2, ahk_id %active_id_1%
    WinGetPos, x3,y3, Width3, Height3, ahk_id %active_id_2%
    ;判断是否靠边
    If(x1<Thresholds){
        ;判断鼠标是否移动到窗口上
        if(active_id_0 == currId){
            ;如果靠边，而且鼠标移到窗口上，窗口弹出
            WinMove, ahk_id %active_id_0%, , 0,
        }else{
            ;如果靠边，而且鼠标不在窗口上，窗口收起
            WinMove, ahk_id %active_id_0%, , -Width1+10,
        }
    }
    If(y2<Thresholds){
        if(active_id_1 == currId){
            ;向下弹出
            WinMove, ahk_id %active_id_1%, , ,0
        }else{
            ;向上收起
            WinMove, ahk_id %active_id_1%, , ,-Height2+10
        }
    }
    If((A_ScreenWidth-x3-Width3)<Thresholds){
        if(active_id_2 == currId){
            ;向右弹出
            WinMove, ahk_id %active_id_2%, , A_ScreenWidth-Width3,
        }else{
            ;向左收起
            WinMove, ahk_id %active_id_2%, , A_ScreenWidth-10,
        }
    }
	
Return

Numpad4::
    ;获取鼠标下的窗口ID
    MouseGetPos, , , active_id_0, control
    ;获取窗口标题
    WinGetTitle, title, ahk_id %active_id_0%
    ToolTip, 窗口“%title%”左侧停靠收起
    SetTimer, RemoveToolTip, -2000
    return
Numpad8::
    MouseGetPos, , , active_id_1, control
    WinGetTitle, title, ahk_id %active_id_1%
    ToolTip, 窗口“%title%”左侧停靠收起
    SetTimer, RemoveToolTip, -2000

    return
Numpad6::
    MouseGetPos, , , active_id_2, control
    WinGetTitle, title, ahk_id %active_id_2%
    ToolTip, 窗口“%title%”左侧停靠收起
    SetTimer, RemoveToolTip, -2000
    return
Numpad5::
    ;获取窗口ID
    MouseGetPos, , , active_id, control
    ;获取窗口标题
    WinGetTitle, title, ahk_id %active_id%
    ;改变窗口置顶状态
    WinSet, AlwaysOnTop, Toggle,ahk_id %active_id%
    ;获得窗口置顶状态
    WinGet, ExStyle, ExStyle, ahk_id %active_id%
    ; 0x8 is WS_EX_TOPMOST.
    if (ExStyle & 0x8){
        ToolTip, 窗口“%title%”已置顶
        SetTimer, RemoveToolTip, -2000
    }else{
        ToolTip, 窗口“%title%”已取消置顶
        SetTimer, RemoveToolTip, -2000
    }
    return
RemoveToolTip:
    ToolTip
return
