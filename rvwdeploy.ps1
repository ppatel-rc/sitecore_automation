function buildVS
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path,

        [parameter(Mandatory=$false)]
        [bool] $nuget = $true,
        
        [parameter(Mandatory=$false)]
        [bool] $clean = $true
    )
    process
    {
        $msBuildExe = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\msbuild.exe'

        if ($nuget) {
            Write-Host "Restoring NuGet packages" -foregroundcolor green
            nuget restore "$($path)"
        }

        if ($clean) {
            Write-Host "Cleaning $($path)" -foregroundcolor green
            & "$($msBuildExe)" "$($path)" /t:Clean /m
        }

        Write-Host "Building $($path)" -foregroundcolor green
        & "$($msBuildExe)" "$($path)" /t:Build /m
    }
}




cd C:\Github\
cd Sitecore-Foundation\
git fetch
git checkout develop
cd ../Sitecore-Feature\
git fetch
git checkout develop
cd ../AlexionSitecoreSites
git fetch
git checkout develop
cd C:\GitHub\Sitecore-Foundation\
buildVS Foundtion.sln
cd C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Project.SolirisGMGPro
buildVS Alexion.Project.SolirisGMGPro.sln
cd C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro
buildVS Alexion.Sitecore.Project.SolirisGMGPro.sln 
Copy-Item -Path "C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro\App_Config\Include\Alexion.Sitecore.Config.Patches" -Destination "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\App_Config\Include\" -Recurse -Force
Copy-Item -Path "C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro\App_Config\Include\SolirisGMGPro.Project.Website" -Destination "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\App_Config\Include\" -Recurse -Force
cd C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\App_Config\Include\SolirisGMGPro.Project.Website
Rename-Item -Path "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\App_Config\Include\SolirisGMGPro.Project.Website\SolirisGMGPro.Project.WebsiteDEV.config" -NewName "SolirisGMGPro.Project.WebsiteDEV.disabled"
Rename-Item -Path "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\App_Config\Include\SolirisGMGPro.Project.Website\SolirisGMGPro.Project.WebsiteUAT.config.disabled" -NewName "SolirisGMGPro.Project.WebsiteUAT.config"
Rename-Item -Path "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\App_Config\Include\SolirisGMGPro.Project.Website\SolirisGMGPro.Project.WebsiteSettingsPROD.config.disabled" -NewName "SolirisGMGPro.Project.WebsiteSettingsPROD.config"
Remove-Item *.disabled
Copy-Item -Path "C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro\bin\*" -Destination "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\bin\" -Recurse -Force
Copy-Item -Path "C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro\Scripts" -Destination "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\" -Recurse -Force
Copy-Item -Path "C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro\Styles" -Destination "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local" -Recurse -Force
Copy-Item -Path "C:\GitHub\AlexionSitecoreSites\SolirisGMG\code\Alexion.Sitecore.Project.SolirisGMGPro\Views\SolirisGMGPro" -Destination "C:\inetpub\wwwroot\Sitecore-Dev-9.3sc.dev.local\Views" -Recurse -Force
iisreset /restart