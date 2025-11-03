🍎 macOS-Like 键盘绑定 for Windows (AutoHotkey)
这是一个为 AutoHotkey (AHK) 设计的脚本，旨在为 Windows 用户提供接近 macOS 的键盘快捷键体验，大幅提高跨系统操作的连贯性和效率。

✨ 核心理念
本脚本的核心在于将 Windows 键盘的 Alt (Option) 和 Win (Windows) 键作为主要的 macOS Command 键来使用，并为常见的系统、编辑和终端操作提供了精细化的场景定制。

⚙️ 安装与运行
安装 AutoHotkey： 确保您的系统已安装 AutoHotkey (v1.1 或更高版本)。

运行脚本： 将此 .ahk 文件保存，双击运行即可。

🔑 按键对照表 (Command 模拟)
macOS 按键	Windows (物理键)	脚本中的修饰符	说明
Command	Alt ( ! )	!	主要用于通用操作（复制、粘贴、窗口管理）
Command	Win ( # )	#	用于系统启动器和桌面切换
Option	Alt ( ! )	!	在编辑操作中模拟 Option
Control	Ctrl ( ^ )	^	用于桌面和光标移动

🚀 主要功能一览
1. 系统与窗口管理 (全局)
macOS 风格快捷键	实际按键组合	实现功能	Windows 原生发送
Command + Q	Alt + Q ($!q)	关闭当前窗口	Alt + F4
Command + H	Alt + H (!h)	最小化当前程序的所有窗口	-
Command + `	Alt + \`` (!``)	循环切换同一程序的窗口	-
Command + Ctrl + Q	Alt + Ctrl + Q ($!^q)	锁定屏幕并关闭显示器	-
Command + Left/Right	Ctrl + Left/Right ($^Left/$^Right)	切换虚拟桌面	Ctrl + Win + Left/Right
启动器	Win + E/N/T ($#e/$`#n`/$#t)	启动 Explorer / Notepad / Terminal	-
输入法	Caps Lock (*CapsLock)	切换中英文输入法	Ctrl + Space

2. 通用编辑操作 (#IfWinNotActive ahk_group posix)
适用于浏览器、Word、Excel 等大多数非终端应用。

macOS 风格快捷键	实际按键组合	实现功能	Windows 原生发送
Command + C/V/X	Alt + C/V/X ($!c/‘!v‘/!x)	复制/粘贴/剪切	Ctrl + C/V/X
Command + Z/Shift+Z	Alt + Z/Shift+Z ($!z/$!+z)	撤销/重做	Ctrl + Z/Y
Command + A/S/O	Alt + A/S/O ($!a/‘!s‘/!o)	全选/保存/打开	Ctrl + A/S/O
Command + W/T	Alt + W/T ($!w/$!t)	关闭标签页/新建标签页	Ctrl + W/T
Option + ←/→	Alt + Left/Right ($!Left/$!Right)	移动到行首/行尾	Home/End
Ctrl + A/E	Ctrl + A/E ($^a/$^e)	移动到行首/行尾	Home/End
Win + Backspace	Win + Backspace ($#Backspace)	删除前一个单词	Ctrl + Backspace

3. 终端专用操作 (#IfWinActive ahk_group terminals)
针对 powershell.exe, WindowsTerminal.exe, Cmd.exe 等程序进行了优化。

macOS 风格快捷键	实际按键组合	实现功能	Windows 原生发送
Command + C/V	Alt + C/V ($!c/$!v)	终端复制/粘贴	Ctrl + Shift + C/V
Command + W/T	Alt + W/T ($!w/$!t)	关闭 Tab/新建 Tab	Ctrl + Shift + W/N/T
Command + { / }	Alt + Shift + [ / ] ($!+{/$!+})	切换上/下一个 Tab	Ctrl + Shift + Tab / Ctrl + Tab

4. VS Code 专用操作 (#IfWinActive ahk_group vscode)
针对 Code.exe 和 VSCodium.exe 进行了优化。

macOS 风格快捷键	实际按键组合	实现功能	Windows 原生发送
Command + P	Alt + P ($!p)	文件搜索	Ctrl + P
Command + Shift + P	Alt + Shift + P ($!+p)	命令面板	Ctrl + Shift + P
Command + ,	Alt + , ($!,)	打开设置	Ctrl + ,

🚨 遇到问题 (Emergency)
如果快捷键卡住或发生冲突，可以按下应急热键：

*PrintScreen：重新加载脚本并释放所有修饰键，解决按键卡顿问题。