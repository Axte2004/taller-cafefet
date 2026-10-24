$ErrorActionPreference='Stop'
. (Join-Path $PSScriptRoot 'funcion_ejecutar.ps1')
$p=[IO.File]::ReadAllText((Join-Path $root 'reto3/prompt2_criterios.txt'),$utf8)+"`n"+[IO.File]::ReadAllText((Join-Path $root 'reto3/ajuste_final.txt'),$utf8)
[IO.File]::WriteAllText((Join-Path $root 'reto3/prompt2_criterios_final.txt'),$p,$utf8)
Ejecutar 'qwen-demo' 'reto3/prompt2_criterios_final.txt' 'reto3/salida2_criterios_final.md'
$p=[IO.File]::ReadAllText((Join-Path $root 'reto3/plantilla3.txt'),$utf8).Replace('{CRITERIOS}',[IO.File]::ReadAllText((Join-Path $root 'reto3/salida2_criterios_final.md'),$utf8).Trim())+"`n"+[IO.File]::ReadAllText((Join-Path $root 'reto3/ajuste_paso3.txt'),$utf8)+"`nNo afirmes que se confirma una selección parcial ni que se sustituyen productos. C3 solo impide confirmar el pedido tal como solicitado. No inventes una hora de inicio del plazo."
[IO.File]::WriteAllText((Join-Path $root 'reto3/prompt3_pruebas_final.txt'),$p,$utf8)
Ejecutar 'qwen-demo' 'reto3/prompt3_pruebas_final.txt' 'reto3/salida3_pruebas_final.md'
