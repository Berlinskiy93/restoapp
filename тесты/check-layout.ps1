$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$html = Get-Content -Raw -Encoding UTF8 (Join-Path $projectRoot 'index.html')
$css = Get-Content -Raw -Encoding UTF8 (Join-Path $projectRoot 'style.css')

function Assert-Contains([string]$content, [string]$value, [string]$message) {
  if (-not $content.Contains($value)) {
    throw "FAIL: $message"
  }
  Write-Output "PASS: $message"
}

Assert-Contains $html '<meta charset="UTF-8">' 'UTF-8 metadata'
Assert-Contains $html '<address' 'semantic address element'
Assert-Contains $html 'aria-label=' 'ARIA label'
Assert-Contains $html 'aria-current="page"' 'current navigation item'
Assert-Contains $html 'normalize.css' 'normalize stylesheet'
Assert-Contains $css ':root' 'CSS custom properties'
Assert-Contains $css '1024px' 'tablet breakpoint'
Assert-Contains $css '600px' 'mobile breakpoint'
Assert-Contains $css 'a:focus-visible' 'keyboard focus state'

if ($css -match 'font-weight:\s*700') {
  throw 'FAIL: font-weight: 700 is still present'
}
Write-Output 'PASS: font-weight: 700 is absent'
Write-Output 'Layout checks completed successfully.'
