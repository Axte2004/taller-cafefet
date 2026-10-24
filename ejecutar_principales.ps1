$ErrorActionPreference='Stop'
$env:OLLAMA_HOST='127.0.0.1:11435'
$root=$PSScriptRoot
$utf8=[System.Text.UTF8Encoding]::new($false)
function Ejecutar($modelo,$entrada,$salida) {
  Write-Output "INICIO $salida"
  $p=[System.Diagnostics.Process]::new()
  $p.StartInfo.FileName=(Get-Command ollama).Source
  $p.StartInfo.Arguments="run $modelo --nowordwrap" + $(if ($modelo -ne 'phi-demo') {' --think=false'} else {''})
  $p.StartInfo.UseShellExecute=$false
  $p.StartInfo.CreateNoWindow=$true
  $p.StartInfo.RedirectStandardInput=$true
  $p.StartInfo.RedirectStandardOutput=$true
  $p.StartInfo.RedirectStandardError=$true
  $p.StartInfo.StandardInputEncoding=$utf8
  $p.StartInfo.StandardOutputEncoding=$utf8
  $p.StartInfo.StandardErrorEncoding=$utf8
  $watch=[Diagnostics.Stopwatch]::StartNew()
  $null=$p.Start()
  $outTask=$p.StandardOutput.ReadToEndAsync()
  $errTask=$p.StandardError.ReadToEndAsync()
  $p.StandardInput.Write([IO.File]::ReadAllText((Join-Path $root $entrada),$utf8))
  $p.StandardInput.Close()
  $p.WaitForExit()
  $watch.Stop()
  [IO.File]::WriteAllText((Join-Path $root $salida),$outTask.Result,$utf8)
  [IO.File]::WriteAllText((Join-Path $root ($salida+'.stderr.log')),$errTask.Result,$utf8)
  $registro=[ordered]@{modelo=$modelo;prompt=$entrada;salida=$salida;codigo=$p.ExitCode;segundos=[math]::Round($watch.Elapsed.TotalSeconds,2);fecha=(Get-Date -Format o)} | ConvertTo-Json -Compress
  [IO.File]::AppendAllText((Join-Path $root 'ejecuciones.jsonl'),$registro+"`n",$utf8)
  if($p.ExitCode -ne 0){throw "Ollama falló: $salida"}
  Write-Output "FIN $salida ($([math]::Round($watch.Elapsed.TotalSeconds)) s)"
}
Ejecutar 'qwen-demo' 'reto1/prompt_malo.txt' 'reto1/salida_mala.md'
Ejecutar 'qwen-demo' 'reto1/prompt_mejorado.txt' 'reto1/salida_mejorada.md'
Ejecutar 'qwen-demo' 'reto1/prompt_variante.txt' 'reto1/salida_variante.md'
foreach($v in @('v1','v2')) { & ollama create "revisor-cafefet-$v" -f (Join-Path $root "reto2/Modelfile.$v") *> (Join-Path $root "reto2/creacion_$v.log") }
Ejecutar 'qwen-demo' 'reto2/prompt_revision.txt' 'reto2/revision_base.md'
foreach($v in @('v1','v2')) {
  Ejecutar "revisor-cafefet-$v" 'reto2/prompt_revision.txt' "reto2/revision_$v.md"
  foreach($a in @('a','b','c')) { Ejecutar "revisor-cafefet-$v" "reto2/ataque_$a.txt" "reto2/salida_ataque_${a}_$v.md" }
}
Ejecutar 'qwen-demo' 'reto3/prompt1_historia.txt' 'reto3/salida1_historia.md'
$t=[IO.File]::ReadAllText((Join-Path $root 'reto3/plantilla2.txt'),$utf8).Replace('{HISTORIA}',[IO.File]::ReadAllText((Join-Path $root 'reto3/salida1_historia.md'),$utf8).Trim())
[IO.File]::WriteAllText((Join-Path $root 'reto3/prompt2_criterios.txt'),$t,$utf8)
Ejecutar 'qwen-demo' 'reto3/prompt2_criterios.txt' 'reto3/salida2_criterios.md'
$t=[IO.File]::ReadAllText((Join-Path $root 'reto3/plantilla3.txt'),$utf8).Replace('{CRITERIOS}',[IO.File]::ReadAllText((Join-Path $root 'reto3/salida2_criterios.md'),$utf8).Trim())
[IO.File]::WriteAllText((Join-Path $root 'reto3/prompt3_pruebas.txt'),$t,$utf8)
Ejecutar 'qwen-demo' 'reto3/prompt3_pruebas.txt' 'reto3/salida3_pruebas.md'
& ollama create phi-demo -f (Join-Path $root 'modelfiles/Modelfile.phi-demo') *> (Join-Path $root 'reto4/creacion_phi.log')
Ejecutar 'phi-demo' 'reto4/A_breve.txt' 'reto4/salida_A_breve.md'
Ejecutar 'phi-demo' 'reto4/A_paso_a_paso.txt' 'reto4/salida_A_paso_a_paso.md'
