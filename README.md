# SwitchWin11ContextMenu

A single-file BAT script that toggles the Windows 11 right-click context menu between:

- **Classic menu** (Windows 10-style)
- **Modern menu** (default Windows 11 style)

The script uses the current user registry hive (`HKCU`), so it usually **does not require administrator privileges**.

## Features

- Single-file `.bat` script
- English menu and prompts
- Restore the classic menu with:
  - `reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve`
- Restore the modern Windows 11 menu with:
  - `reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f`
- Prompts to restart **Windows Explorer** immediately
- The restart prompt defaults to **Yes** when you press `Enter`

## Files

- `SwitchWin11ContextMenu.bat`: main script

## Usage

1. Download or copy `SwitchWin11ContextMenu.bat`.
2. Double-click the script.
3. Choose one of the options:
   - `1` = Restore classic context menu
   - `2` = Restore modern context menu
   - `3` = Exit
4. When prompted, choose whether to restart Windows Explorer now.
   - Press `Enter` for the default `Yes`
   - Type `N` for `No`

## Notes

- The change is written to the **current user** registry path, so it is user-specific.
- If you choose not to restart Explorer immediately, the change may not appear until Explorer is restarted, you sign out, or Windows is rebooted.
- `reg.exe delete ... /f` may report an error if the key does not exist yet. In that case, the system may already be using the modern Windows 11 menu.

## License

You can use and modify this script freely.
