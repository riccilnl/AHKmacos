; Sets up macOS-like keybindings on Windows via AutoHotkey.
;
; Last updated on 2021-07-14.
#SingleInstance force    ; 确保脚本只运行一个实例
#NoEnv                   ; 避免检查空变量，提高兼容性
#Persistent              ; 保持脚本常驻内存
#InstallKeybdHook        ; 安装键盘钩子以捕获所有按键

Menu, Tray, Standard

; ========== 程序组定义 (用于分场景激活快捷键) ==========
; 定义终端程序组
GroupAdd, terminals, ahk_exe powershell.exe
GroupAdd, terminals, ahk_exe WindowsTerminal.exe
GroupAdd, terminals, ahk_exe Cmd.exe
GroupAdd, terminals, ahk_exe mstsc.exe ; Remote desktop. 
; 定义 POSIX/类Unix环境程序组，排除通用快捷键干扰
GroupAdd, posix, ahk_exe powershell.exe
GroupAdd, posix, ahk_exe WindowsTerminal.exe
GroupAdd, posix, ahk_exe Cmd.exe
GroupAdd, posix, ahk_exe gvim.exe
GroupAdd, posix, ahk_exe mstsc.exe ; Remote desktop. 
; 定义 VS Code 程序组
GroupAdd, vscode, ahk_exe VSCodium.exe
GroupAdd, vscode, ahk_exe Code.exe

; ========== 应急重载 (Emergency Clear) ==========
; 按 PrintScreen 重新加载脚本并释放所有按键
*PrintScreen::
Reload
Goto ReleaseModifiers
return

; ========== 修饰键对照表 (CHEATSHEET) ==========
; # Win    ! Alt    ^ Ctrl    + Shift 
;
; 这些修饰键在重映射后仍然有效。
; 按键重映射的顺序是无关紧要的。 

;$AppsKey::RCtrl  ; Surface Laptop.
$AppsKey::RWin  ; 将 Apps 键映射为 右 Win 键 (RWin) 
; Sculpt keyboard.

; ========== 程序启动器 (Program Launchers) ==========
$#e::Run explorer   ; Win+E 启动 文件资源管理器
$#n::Run notepad    ; Win+N 启动 记事本
$#t::Run wt         ; Win+T 启动 Windows Terminal

; ========== 中英切换 ==========
*CapsLock::SendInput ^{Space}   ; Ctrl 与 Space 同时按下

; ========== 窗口操作 (Window Manipulation) ==========
$!q::Send !{F4}     ; Alt+Q 模拟 Command+Q, 发送 Alt+F4 (关闭窗口)

; ========== 工作区移动 (Workspace Movement) ==========
$^Left::Send ^#{Left}   ; Ctrl+Left 切换到左侧虚拟桌面
$^Right::Send ^#{Right} ; Ctrl+Right 切换到右侧虚拟桌面

; ========== 截图功能 (Screenshots) ==========
; ;$!+3::Send {PrintScreen}
; ;$!+4::Send #+{S} ; 默认禁用，留作备用

; ========== 隐藏所有同程序实例 (Hide All) ==========
; 模拟 macOS 的 Command+H：最小化当前活动程序的所有窗口 
!h::
WinGetClass, class, A
SetTitleMatchMode, 2
WinGet, AllWindows, List
loop %AllWindows% {
    WinGetClass, WinClass, % "ahk_id " AllWindows%A_Index%
    if(InStr(WinClass,class)){
        WinMinimize, % "ahk_id " AllWindows%A_Index%
    }
}
return

; ========== 循环切换同程序窗口 (Cycle Windows) ==========
; 模拟 macOS 的 Command+Tab/Command+`：在同一应用的不同窗口间切换 
!`::
WinGet, ActiveProcess, ProcessName, A
WinGet, OpenWindowsAmount, Count, ahk_exe %ActiveProcess%
if (OpenWindowsAmount > 1) {
    WinGetTitle, FullTitle, A
    AppTitle := SubStr(FullTitle, InStr(FullTitle, " ", false, -1) + 1)

    SetTitleMatchMode, 2
    WinGet, WindowsWithSameTitleList, List, %AppTitle%

    if (WindowsWithSameTitleList > 1) {
        WinActivate, % "ahk_id " WindowsWithSameTitleList%WindowsWithSameTitleList%
    }
}
return


; ========== 锁定屏幕并关闭显示器 (Lock Screen) ==========
; 模拟 Command+Ctrl+Q 锁定屏幕 
$!^q::
    Sleep, 200
    DllCall("LockWorkStation")
    Sleep, 200
    SendMessage,0x112,0xF170,2,,Program Manager ; 关闭显示器
    return

; ==========================================================
; ========== 【非 POSIX 程序组】通用 macOS 快捷键 ==========
; ==========================================================
; 在非终端、非gVim等环境下生效
#IfWinNotActive ahk_group posix
    $!a::Send ^a ; Alt+A (Command+A) -> 全选 
    $!f::Send ^f ; Alt+F (Command+F) -> 查找 
    $!l::Send ^l ; Alt+L (Command+L) -> 定位到地址栏 
    $!r::Send {F5} ; Alt+R (Command+R) -> 刷新 (F5) 
    $!z::Send ^z ; Alt+Z (Command+Z) -> 撤销 
    $!+z::Send ^y ; Alt+Shift+Z (Command+Shift+Z) -> 重做 
    $^!Space::Send #; ; Ctrl+Alt+Space -> Emoji 选择器

    ; 文件操作 (File Manipulation) 
    $!o::Send ^o ; Alt+O (Command+O) -> 打开
    $!s::Send ^s ; Alt+S (Command+S) -> 保存

    ; 行编辑 (Line Edits) 
    $^k::SendInput +{End}{Delete} ; Ctrl+K -> 删除到行尾
    $^o::SendInput {Enter}{Up} ; Ctrl+O -> 在当前行上方插入新行
    $!/::Send ^/ ; Alt+/ (Command+/) -> 注释行

    ; 单词编辑 (Word Edits) 
    $#Backspace::Send ^{Backspace} ; Win+Backspace (Command+Backspace) -> 删除前一个单词
    $!Backspace::Send ^{Backspace} ; Alt+Backspace (Option+Backspace) -> 删除前一个单词

    ; 光标移动 (Cursor Movement) 
    $^a::Send {Home} ; Ctrl+A -> 行首
    $^e::Send {End} ; Ctrl+E -> 行尾
    $^p::SendInput {Up} ; Ctrl+P -> 上移一行
    $^n::SendInput {Down} ; Ctrl+N -> 下移一行
    $^b::SendInput {Left} ; Ctrl+B -> 左移一字符
    $^f::SendInput {Right} ; Ctrl+F -> 右移一字符
    $#b::SendInput ^{Left} ; Win+B (Option+Left) -> 左移一个单词
    $#f::SendInput ^{Right} ; Win+F (Option+Right) -> 右移一个单词

    ; macOS风格 行首/行尾 (Option+Left/Right)
    $!Left::Send {Home} ; Alt+Left -> 行首
    $!Right::Send {End} ; Alt+Right -> 行尾
    $!+Left::Send +{Home} ; Alt+Shift+Left -> 选中到行首
    $!+Right::Send +{End} ; Alt+Shift+Right -> 选中到行尾

    ; 格式化 (Formatting) 
    $!b::Send ^b ; Alt+B (Command+B) -> 粗体
    $!i::Send ^i ; Alt+I (Command+I) -> 斜体
    $!u::Send ^u ; Alt+U (Command+U) -> 下划线
    $!k::Send ^k ; Alt+K (Command+K) -> 插入链接 
#If ; 结束非 POSIX 程序组限定

; ==========================================================
; ========== 【VS Code 程序组】特定快捷键 ==========
; ==========================================================
#IfWinActive ahk_group vscode
    $!+p::Send ^+p ; Alt+Shift+P (Command+Shift+P) -> 命令面板/文件搜索 
    $!p::Send ^p ; Alt+P (Command+P) -> 文件搜索
    $!,::Send ^, ; Alt+, (Command+,) -> 设置 
#If ; 结束 VS Code 程序组限定

; ==========================================================
; ========== 【非 终端 程序组】通用剪贴板与 Tab 操作 ==========
; ==========================================================
#IfWinNotActive ahk_group terminals
    ; 剪贴板 (Clipboard) 
    $!c::Send ^c ; Alt+C (Command+C) -> 复制
    $!v::Send ^v ; Alt+V (Command+V) -> 粘贴
    $!+v::Send ^+v ; Alt+Shift+V (Command+Shift+V) -> 粘贴 (带 Shift)
    $!x::Send ^x ; Alt+X (Command+X) -> 剪切

    ; Tab 页操作 (Tabs) 
    $!w::Send ^w ; Alt+W (Command+W) -> 关闭 Tab
    $!n::Send ^n ; Alt+N (Command+N) -> 新建窗口
    $!+n::Send ^+n ; Alt+Shift+N (Command+Shift+N) -> 新建 (带 Shift)
    $!t::Send ^t ; Alt+T (Command+T) -> 新建 Tab
    $!+t::Send ^+t ; Alt+Shift+T (Command+Shift+T) -> 新建 Tab (带 Shift)
    $!+{::send ^{PgUp} ; Alt+Shift+[ -> 切换到上一个 Tab
    $!+}::send ^{PgDn} ; Alt+Shift+] -> 切换到下一个 Tab
    $!0::Send ^0 ; Alt+0 -> 切换到 Tab 0
    $!1::Send ^1 ; Alt+1 -> 切换到 Tab 1
    $!2::Send ^2 ; Alt+2 -> 切换到 Tab 2
    $!3::Send ^3 ; Alt+3 -> 切换到 Tab 3
    $!4::Send ^4 ; Alt+4 -> 切换到 Tab 4
    $!5::Send ^5
    $!6::Send ^6
    $!7::Send ^7
    $!8::Send ^8
    $!9::Send ^9

    $^d::SendInput {Delete} ; Ctrl+D -> 删除光标后字符 
    $!,::Send ^, ; Alt+, (Command+,) -> 设置 
#If ; 结束非 终端 程序组限定

; ==========================================================
; ========== 【终端 程序组】特定剪贴板与 Tab 操作 ==========
; ==========================================================
#IfWinActive ahk_group terminals
    ; 剪贴板 (Clipboard) 
    ; 在 Windows Terminal 等程序中，剪贴板操作需要 Ctrl+Shift
    $!c::Send ^+c ; Alt+C (Command+C) -> 终端复制 (Ctrl+Shift+C)
    $!v::Send ^+v ; Alt+V (Command+V) -> 终端粘贴 (Ctrl+Shift+V)

    ; Tab 页操作 (Tabs) 
    $!w::Send ^+w ; Alt+W (Command+W) -> 关闭 Tab
    $!n::Send ^+n ; Alt+N (Command+N) -> 新建 Tab
    $!t::Send ^+t ; Alt+T (Command+T) -> 新建 Tab
    $!+{::send ^+{Tab} ; Alt+Shift+[ -> 切换到上一个 Tab (Ctrl+Shift+Tab)
    $!+}::send ^{Tab} ; Alt+Shift+] -> 切换到下一个 Tab (Ctrl+Tab)
    ; 序号 Tab 切换 (适配 Windows Terminal 默认快捷键)
    $!0::Send ^!0
    $!1::Send ^!1
    $!2::Send ^!2
    $!3::Send ^!3
    $!4::Send ^!4
    $!5::Send ^!5
    $!6::Send ^!6
    $!7::Send ^!7
    $!8::Send ^!8
    $!9::Send ^!9
    $!+0::Send ^+0
    $!+1::Send ^+1
    $!+2::Send ^+2
    $!+3::Send ^+3
    $!+4::Send ^+4
$!+5::Send ^+5
    $!+6::Send ^+6
    $!+7::Send ^+7
    $!+8::Send ^+8
    $!+9::Send ^+9

    $!,::Send ^, ; Alt+, (Command+,) -> 设置 
#If ; 结束终端 程序组限定



; ========== 释放所有修饰键 (Release Modifiers) ==========
; 用于应急重载后，确保所有按键都已松开
ReleaseModifiers:
Send {RCtrl up}
Send {LCtrl up}
Send {RAlt up}
Send {LAlt up}
Send {RWin up}
Send {LWin up}
Send {RShift up}
Send {LShift up}
return