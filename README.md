# 🍎 macOS-Like 键盘绑定 for Windows (AutoHotkey)

[cite_start]这是一个为 AutoHotkey (AHK) 设计的脚本，旨在为 Windows 用户提供接近 macOS 的键盘快捷键体验，大幅提高跨系统操作的连贯性和效率。脚本于 2021-07-14 最后更新 [cite: 7]。

## ⚙️ 安装与运行

1.  [cite_start]**安装 AutoHotkey：** 确保您的系统已安装 AutoHotkey (v1.1 或更高版本) [cite: 8]。
2.  **运行脚本：** 将此 `.ahk` 文件保存，双击运行即可。

## ⚠️ 应急与特殊设定

| 功能类别 | 按键组合 | 说明 |
| :--- | :--- | :--- |
| **应急重载** | `PrintScreen` (`*PrintScreen`) | [cite_start]**重新加载脚本并释放所有修饰键**，用于解决按键冲突或卡顿问题 [cite: 8]。|
| **修饰键对照** | `# Win`、`! Alt`、`^ Ctrl`、`+ Shift` | [cite_start]这是脚本内部识别的修饰键对照表 [cite: 11]。|
| **硬件重映射** | `AppsKey` (`$AppsKey`) | [cite_start]将 **Apps 键** 映射为 **右 Win 键 (RWin)** [cite: 13]。|
| **中英切换** | `Caps Lock` (`*CapsLock`) | [cite_start]发送 `Ctrl + Space`，用于**切换输入法** [cite: 30]。|

---

## 🚀 核心功能分类

本脚本通过程序组进行场景隔离，确保快捷键在不同应用中的行为符合预期。

### 1. 系统与窗口管理 (全局)

| macOS 风格快捷键 | 实际按键组合 | 实现功能 | Windows 原生发送 |
| :--- | :--- | :--- | :--- |
| **Command + Q** | `Alt + Q` (`$!q`) | **关闭当前窗口** | [cite_start]`Alt + F4` [cite: 14] |
| **Command + H** | `Alt + H` (`!h`) | [cite_start]**最小化**当前程序的所有窗口 [cite: 15] | - |
| **Command + \`** | `Alt + \`` (`!\``) | [cite_start]**循环切换**同一应用程序的窗口 [cite: 16] | - |
| **Command + Ctrl + Q** | `Alt + Ctrl + Q` (`$!^q`) | [cite_start]**锁定屏幕并关闭显示器** [cite: 17] | - |
| **桌面切换** | `Ctrl + Left/Right` (`$^Left`/`$^Right`) | [cite_start]切换到**左/右侧虚拟桌面** [cite: 14] | `Ctrl + Win + Left/Right` |
| **程序启动** | `Win + E/N/T` (`$#e`/$`#n`/$`#t`) | [cite_start]启动 **Explorer** / **Notepad** / **Windows Terminal** [cite: 14] | - |

### 2. 通用编辑与导航 (`#IfWinNotActive ahk_group posix`)

[cite_start]适用于浏览器、文本编辑器等大多数非终端、非 POSIX 程序 [cite: 18]。

| macOS 风格快捷键 | 实际按键组合 | 实现功能 | Windows 原生发送 |
| :--- | :--- | :--- | :--- |
| **Command + C/V/X** | `Alt + C/V/X` (`$!c`/$`!v`/$`!x`) | [cite_start]**复制/粘贴/剪切** (在**非终端**程序组生效) [cite: 20] | `Ctrl + C/V/X` |
| **Command + Z/Shift+Z**| `Alt + Z/Shift+Z` (`$!z`/`$!+z`) | **撤销/重做** | [cite_start]`Ctrl + Z/Y` [cite: 19] |
| **Command + A/F/S/O** | `Alt + A/F/S/O` | **全选/查找/保存/打开** | [cite_start]`Ctrl + A/F/S/O` [cite: 18, 20] |
| **Option + ←/→** | `Alt + Left/Right` | **移动到行首/行尾** | [cite_start]`Home/End` [cite: 23] |
| **Ctrl + A/E** | `Ctrl + A/E` | **移动到行首/行尾** (macOS 控制键) | [cite_start]`Home/End` [cite: 23] |
| **删除单词** | `Win/Alt + Backspace` | **删除前一个单词** | [cite_start]`Ctrl + Backspace` [cite: 22] |
| **删除至行尾** | `Ctrl + K` (`$^k`) | **删除到行尾** | [cite_start]`Shift + End + Delete` [cite: 21] |

### 3. 终端专用操作 (`#IfWinActive ahk_group terminals`)

[cite_start]针对 `powershell.exe`, `WindowsTerminal.exe`, `Cmd.exe` 等终端环境 [cite: 29]。

| macOS 风格快捷键 | 实际按键组合 | 实现功能 | Windows 原生发送 |
| :--- | :--- | :--- | :--- |
| **Command + C/V** | `Alt + C/V` (`$!c`/$`!v`) | **终端复制/粘贴** | [cite_start]`Ctrl + Shift + C/V` [cite: 29] |
| **Command + W/T/N** | `Alt + W/T/N` | **关闭 Tab/新建 Tab/新建窗口** | [cite_start]`Ctrl + Shift + W/T/N` [cite: 30] |
| **Command + { / }** | `Alt + Shift + [ / ]` | **切换上/下一个 Tab** | [cite_start]`Ctrl + Shift + Tab / Ctrl + Tab` [cite: 30] |

### 4. VS Code 专用操作 (`#IfWinActive ahk_group vscode`)

[cite_start]针对 `VSCodium.exe` 和 `Code.exe` 进行了优化 [cite: 25]。

| macOS 风格快捷键 | 实际按键组合 | 实现功能 | Windows 原生发送 |
| :--- | :--- | :--- | :--- |
| **Command + P/Shift+P**| `Alt + P/Shift+P` (`$!p`/$`!+p`) | **文件搜索/命令面板** | [cite_start]`Ctrl + P/Shift+P` [cite: 25] |
| **Command + ,** | `Alt + ,` (`$!,`) | **打开设置** | [cite_start]`Ctrl + ,` [cite: 25] |