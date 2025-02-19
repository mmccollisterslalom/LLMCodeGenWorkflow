# Windows Setup Script
# Save this as setup-windows.ps1

Write-Output "Installing dependencies..."

# Install Chocolatey if not found
if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Chocolatey not found, installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco install python mise -y

# Install Python packages
pip install repomix llm

# Install LLM-Ollama support
llm install llm-ollama

# Install Mistral model
Write-Output "Downloading Mistral model..."
ollama pull mistral

# Confirm mise tasks setup
Write-Output "Setting up mise tasks..."
mise run LLM:clean_bundles -ErrorAction SilentlyContinue

Write-Output "Setup complete! Run mise tasks using 'mise run <task>'"
