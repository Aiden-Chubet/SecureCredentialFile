#function to get credentials from a Saved file
Function Get-SavedCredential([string]$UserName,[string]$KeyPath)
{
    If(Test-Path "$($KeyPath)\$($Username).cred") {
        $SecureString = Get-Content "$($KeyPath)\$($Username).cred" | ConvertTo-SecureString
        $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $SecureString
    }
    Else {
        Throw "Unable to locate a credential for $($Username)"
    }
    Return $Credential
}
 
#Get encrypted password from the file
$Cred = Get-SavedCredential -UserName "noreply.servicedesk@domain.com" -KeyPath "C:\Scripts"
 
#Connect to Azure AD from saved credentials
Connect-AzureAD -Credential $Cred
