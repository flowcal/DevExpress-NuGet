Param(
  [string]$source
)

if(!$source){
throw "source must be set to the nuget server url"
}

$ErrorActionPreference = "Stop"

Clear

Get-ChildItem ".\nupkg" -Filter *.nupkg | Foreach-Object{
    Write-Host $_.Name

    & "..\nuget.exe" push $_.FullName -Source $source -NonInteractive -DisableBuffering

    if ($LASTEXITCODE -ne 0)
    {
        Write-Error "Error generating nupkg for '$($_.Name)'"
        break
    }
}
