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
