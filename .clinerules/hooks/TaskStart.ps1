param()

$inputJson = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($inputJson)) {
  [Console]::Out.WriteLine('{"cancel":false}')
  exit 0
}

try {
  $null = $inputJson | ConvertFrom-Json
} catch {
  [Console]::Out.WriteLine('{"cancel":false}')
  exit 0
}

$projectRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$skillPath = Join-Path $projectRoot ".cline\skills\using-doc-superpowers\SKILL.md"

if (-not (Test-Path $skillPath)) {
  [Console]::Out.WriteLine('{"cancel":false}')
  exit 0
}

$skillContent = Get-Content -Raw $skillPath
$context = @"
<EXTREMELY_IMPORTANT>
You are in document-superpowers mode.

Below is the full content of your 'using-doc-superpowers' skill - your bootstrap for controlled documentation workflows.

$skillContent
</EXTREMELY_IMPORTANT>
"@

$result = @{
  cancel = $false
  contextModification = $context
} | ConvertTo-Json -Depth 8 -Compress

[Console]::Out.WriteLine($result)
