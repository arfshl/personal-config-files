[CmdletBinding()]
param (
    [Parameter(Position=0)]
    [string]$Mode = "-v",
    
    [Parameter(Position=1, Mandatory=$false)]
    [string]$Url
)

# Format flags
$VIDEO = "-S vcodec:h264,fps,res:360,acodec:aac,ext:mp4 -P D:/Downloads"
$AUDIO = "-x --audio-format mp3 -P D:/Downloads"

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
    Write-Host "  ytdla -v <URL>"
    Write-Host "  ytdla -a <URL>"
    exit 1
}

# Clean URL by removing anything after &
$CleanUrl = $Url -replace '&.*$', ''

# Execute yt-dlp
$processArgs = @($FORMAT.Split(" ") + $CleanUrl)
& yt-dlp $processArgs