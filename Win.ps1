$ExecutionContext.SessionState.LanguageMode = "FullLanguage"


# Step 1: Change Registry Key
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Arrow" -Value "C:\Users\LENOVO\Downloads\windows-11-pink-theme\Win.cur"
# Step 2: Define the Windows API call in PowerShell
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class CursorHelper {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SystemParametersInfo(
        int uiAction, int uiParam, IntPtr pvParam, int fWinIni);
}
"@
# Step 3: Call SystemParametersInfo to apply the new cursor
# Constants
$SPI_SETCURSORS = 0x0057
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02
# Invoke
[CursorHelper]::SystemParametersInfo($SPI_SETCURSORS, 0, [IntPtr]::Zero, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

exit
