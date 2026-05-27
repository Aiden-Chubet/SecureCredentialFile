#function to Save Credentials to a file
Function Save-Credential([string]$UserName, [string]$KeyPath)
{
    #Create directory for Key file
    If (!(Test-Path $KeyPath)) {        
        Try {
            New-Item -ItemType Directory -Path $KeyPath -ErrorAction STOP | Out-Null
        }
        Catch {
            Throw $_.Exception.Message
        }
    }
    #store password encrypted in file
    $Credential = Get-Credential -Message "Enter the Credentials:" -UserName $UserName
    $Credential.Password | ConvertFrom-SecureString | Out-File "$($KeyPath)\$($Credential.Username).cred" -Force
}
 
#Get credentials and create an encrypted password file
Save-Credential -UserName "svc_patching@domain.com" -KeyPath "C:\Scripts"
