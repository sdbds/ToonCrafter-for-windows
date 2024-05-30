Set-Location $PSScriptRoot

$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1

if (!(Test-Path -Path "venv")) {
    Write-Output  "Creating venv for python..."
    python -m venv venv
}
.\venv\Scripts\activate

Write-Output "install deps..."
pip install -U -r requirements-windows.txt

Write-Output "check models..."

if (!(Test-Path -Path "checkpoints")) {
    mkdir "checkpoints"
}

Set-Location .\checkpoints

if (!(Test-Path -Path "tooncrafter_512_interp_v1")) {
    Write-Output  "Downloading tooncrafter_512_interp_v1 model..."
    huggingface-cli download --resume-download Doubiiu/ToonCrafter --local-dir tooncrafter_512_interp_v1 --local-dir-use-symlinks False
}

Write-Output "Install completed"
Read-Host | Out-Null ;
