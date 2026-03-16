Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "      Instalador do Agent Global (agb) para OpenCode      " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan

$ScriptName = "agent-global.ps1" # Nome do seu script principal do Windows
$ScriptPath = Join-Path $PSScriptRoot $ScriptName

# Verifica se o script principal existe na pasta
if (-not (Test-Path $ScriptPath)) {
    Write-Host "`n❌ Erro: O arquivo '$ScriptName' não foi encontrado nesta pasta." -ForegroundColor Red
    exit
}

Write-Host "`n⏳ Configurando o comando 'agb' no seu PowerShell..." -ForegroundColor Yellow

# Verifica se o arquivo de perfil do PowerShell existe, se não, cria
if (-not (Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# Cria o bloco de código que será injetado no perfil
$AliasCode = "`n# Atalho para o Agent Global (OpenCode)`nfunction agb { & '$ScriptPath' @args }"

# Verifica se o comando já foi instalado antes para não duplicar
$ProfileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
if ($ProfileContent -match "function agb") {
    Write-Host "⚠️ O comando 'agb' já está configurado no seu perfil." -ForegroundColor DarkYellow
} else {
    Add-Content -Path $PROFILE -Value $AliasCode
    Write-Host "✅ Comando 'agb' adicionado ao seu perfil com sucesso!" -ForegroundColor Green
}

Write-Host "`n🎉 Instalação concluída!" -ForegroundColor Cyan
Write-Host "Para começar a usar, reinicie o seu PowerShell ou digite o comando abaixo:" -ForegroundColor White
Write-Host "  . `$PROFILE" -ForegroundColor Magenta
Write-Host "`nDepois, basta digitar 'agb' ou 'agb --help'." -ForegroundColor White
