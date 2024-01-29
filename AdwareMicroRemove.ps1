###==================================================
### Remove all the adware on Windows 10
###==================================================
### Date   : 03 December 2019
### Author : Chukwuemeka Evulukwu
### 
### Script Details:
### --------------
###  This script removes unwanted Apps that come with Windows. If you  do not want
###       to remove certain Apps comment out the corresponding lines below. 
###        
###           
###      
### 
###===========================================

#Elevates previlege to do the reomoval 
function Elevate-Privileges {
    param($Privilege)
    $Definition = @"
    using System;
    using System.Runtime.InteropServices;
    public class AdjPriv {
        [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
            internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall, ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr rele);
        [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
            internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr phtok);
        [DllImport("advapi32.dll", SetLastError = true)]
            internal static extern bool LookupPrivilegeValue(string host, string name, ref long pluid);
        [StructLayout(LayoutKind.Sequential, Pack = 1)]
            internal struct TokPriv1Luid {
                public int Count;
                public long Luid;
                public int Attr;
            }
        internal const int SE_PRIVILEGE_ENABLED = 0x00000002;
        internal const int TOKEN_QUERY = 0x00000008;
        internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;
        public static bool EnablePrivilege(long processHandle, string privilege) {
            bool retVal;
            TokPriv1Luid tp;
            IntPtr hproc = new IntPtr(processHandle);
            IntPtr htok = IntPtr.Zero;
            retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
            tp.Count = 1;
            tp.Luid = 0;
            tp.Attr = SE_PRIVILEGE_ENABLED;
            retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
            retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
            return retVal;
        }
    }
"@
    $ProcessHandle = (Get-Process -id $pid).Handle
    $type = Add-Type $definition -PassThru
    $type[0]::EnablePrivilege($processHandle, $Privilege)
}

echo "Elevating priviledges for this process"
do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)

#list of array apps to start removing the "#" is for apps i decided not to remove 
echo "Uninstalling default apps"
$apps = @(
    # default Windows 10 apps
    #"Microsoft.3DBuilder"
    #"Microsoft.Appconnector"
    #"Microsoft.BingFinance"
    #"Microsoft.BingNews"
    #"Microsoft.BingSports"
    #"Microsoft.BingWeather"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    #"Microsoft.Office.OneNote"
    #"Microsoft.People"
    #"Microsoft.SkypeApp"
    #"Microsoft.Windows.Photos"
    #"Microsoft.WindowsAlarms"
    #"Microsoft.WindowsCalculator"
    #"Microsoft.WindowsCamera"
    #"Microsoft.WindowsMaps"
    #"Microsoft.WindowsPhone"
    #"Microsoft.WindowsSoundRecorder"
    #"Microsoft.WindowsStore"
    "Microsoft.XboxApp"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    #"microsoft.windowscommunicationsapps"
    "Microsoft.MinecraftUWP"
    #"Windows.ContactSupport"
    #"Microsoft.WindowsFeedback"

    # Threshold 2 apps
    #"Microsoft.CommsPhone"
    #"Microsoft.ConnectivityStore"
    #"Microsoft.Messaging"
    #"Microsoft.Office.Sway"

    # non-Microsoft
    "9E2F88E3.Twitter"
    #"Flipboard.Flipboard"
    "ShazamEntertainmentLtd.Shazam"
    "king.com.CandyCrushSaga"
    "ClearChannelRadioDigital.iHeartRadio"

    # apps which cannot be removed using Remove-AppxPackage
    #"Microsoft.BioEnrollment"
    #"Microsoft.MicrosoftEdge"
    #"Microsoft.Windows.Cortana"
    #"Microsoft.WindowsFeedback"
    #"Microsoft.XboxGameCallableUI"
    #"Microsoft.XboxIdentityProvider"
    #"Windows.ContactSupport"
)
#finally the command that excute the removal
foreach ($app in $apps) {   
    Get-AppxPackage  -Alluser -name $app | Remove-AppxPackage 

     Get-AppXProvisionedPackage -Online |
        where DisplayName -EQ $app |
        Remove-AppxProvisionedPackage -Online

}