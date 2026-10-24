$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'funcion_ejecutar.ps1')
$p2=[IO.File]::ReadAllText((Join-Path $root 'reto3/prompt2_criterios.txt'),$utf8)+"`n"+[IO.File]::ReadAllText((Join-Path $root 'reto3/ajuste_paso2.txt'),$utf8)
[IO.File]::WriteAllText((Join-Path $root 'reto3/prompt2_criterios_corregido.txt'),$p2,$utf8)
Ejecutar 'qwen-demo' 'reto3/prompt2_criterios_corregido.txt' 'reto3/salida2_criterios_corregida.md'
$p3=[IO.File]::ReadAllText((Join-Path $root 'reto3/plantilla3.txt'),$utf8).Replace('{CRITERIOS}',[IO.File]::ReadAllText((Join-Path $root 'reto3/salida2_criterios_corregida.md'),$utf8).Trim())+"`n"+[IO.File]::ReadAllText((Join-Path $root 'reto3/ajuste_paso3.txt'),$utf8)
[IO.File]::WriteAllText((Join-Path $root 'reto3/prompt3_pruebas_corregido.txt'),$p3,$utf8)
Ejecutar 'qwen-demo' 'reto3/prompt3_pruebas_corregido.txt' 'reto3/salida3_pruebas_corregida.md'
$env:UV_CACHE_DIR=Join-Path $root '.uv-cache'
Push-Location (Join-Path $root 'bonus')
try {
  Write-Output 'INICIO bonus JSON'
  uv run --no-sync reporte_json.py *> salida_json_terminal.md
  if($LASTEXITCODE -ne 0){throw 'Falló reporte_json.py'}
  Write-Output 'FIN bonus JSON; INICIO evaluación 4b'
  uv run --no-sync evalua.py --modelo qwen3.5:4b *> salida_eval_4b_terminal.md
  if($LASTEXITCODE -ne 0){throw 'Falló evalua.py 4b'}
  Write-Output 'FIN evaluación 4b; INICIO evaluación 0.8b'
  uv run --no-sync evalua.py --modelo qwen3.5:0.8b *> salida_eval_08b_terminal.md
  if($LASTEXITCODE -ne 0){throw 'Falló evalua.py 0.8b'}
  Write-Output 'BONUS COMPLETO'
} finally { Pop-Location }
