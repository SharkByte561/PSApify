 
[version]$Version = '1.0.2'
 
 

#Requires -Module ModuleBuilder

# Build parameters
$params = @{
    SourcePath                 = "X:\Vault\GithubRepos\_SharkByte561\PSAPify\Source\PSAPify.psd1"
    CopyPaths                  = @("X:\Vault\GithubRepos\_SharkByte561\PSAPify\README.md")
    Version                    = $Version
    UnversionedOutputDirectory = $true
}

# Build the module
Build-Module @params

# Run Pester tests if -RunTests is specified
if ($RunTests) {
    Write-Host 'Running Pester tests...'
    Invoke-Pester -Path "X:\Vault\GithubRepos\_SharkByte561\PSAPify\Tests" -Output Detailed
}
