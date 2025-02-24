[CmdletBinding()]
  
param (
  
    [Parameter(Position=0)]
  
    [string]$Mode = "-v",
  
    
  
    [Parameter(Position=1, Mandatory=$false)]
  
    [string]$Url
  
)
  

  
# Format flags
  
$VIDEO = "-S vcodec:h264,fps,res:360,acodec:aac,ext:mp4 -P D:\Download"
  
$AUDIO = "-x --audio-format mp3 -P D:\Download"
  

  
# Mode selection
  
if ($Mode -notin @("-v", "-a")) {
  
    $Url = $Mode
  
    $Mode = "-v"
  
}
  
$FORMAT = if ($Mode -eq "-v") { $VIDEO } else { $AUDIO }
  

  
# Download
  
if (-not $Url) {
  
    Write-Host "Usage: ytdla [-v {video} |-a {audio}] <URL>"
  
    Write-Host "Examples:"
  
    Write-Host "  .\ytdla -v <URL>"
  
    Write-Host "  .\ytdla -a <URL>"
  
    exit 1
  
}
  

  
$args = ($FORMAT + " " + $Url).Split(" ")
  
Start-Process -NoNewWindow -Wait -FilePath "yt-dlp" -ArgumentList $args
