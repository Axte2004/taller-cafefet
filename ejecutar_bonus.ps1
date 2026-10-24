$ErrorActionPreference='Stop'
$env:OLLAMA_HOST='http://127.0.0.1:11435'
$env:UV_CACHE_DIR=Join-Path $PSScriptRoot '.uv-cache'
$env:PYTHONIOENCODING='utf-8'
Push-Location (Join-Path $PSScriptRoot 'bonus')
try {
  Write-Output 'INICIO bonus JSON'
  uv run --no-sync reporte_json.py *> salida_json_terminal.md
  if($LASTEXITCODE -ne 0){throw 'Falló JSON'}
  Write-Output 'FIN JSON; INICIO evaluación 4b'
  uv run --no-sync evalua.py --modelo qwen3.5:4b *> salida_eval_4b_terminal.md
  if($LASTEXITCODE -ne 0){throw 'Falló evaluación 4b'}
  Write-Output 'FIN 4b; INICIO evaluación 0.8b'
  uv run --no-sync evalua.py --modelo qwen3.5:0.8b *> salida_eval_08b_terminal.md
  if($LASTEXITCODE -ne 0){throw 'Falló evaluación 0.8b'}
  Write-Output 'BONUS COMPLETO'
} finally {Pop-Location}
