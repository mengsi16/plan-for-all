param(
    [Parameter(Mandatory = $true)]
    [string]$DetailPlanPath,

    [string]$OutputDir = "docs/plan-for-all/plans/step_subplans"
)

if (-not (Test-Path -LiteralPath $DetailPlanPath)) {
    throw "Detail plan not found: $DetailPlanPath"
}

if (-not (Test-Path -LiteralPath $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$content = Get-Content -Raw -Encoding UTF8 -LiteralPath $DetailPlanPath
$pattern = '(?ms)^## Phase (\d+):.*?(?=^## Phase \d+:|\z)'
$matches = [regex]::Matches($content, $pattern)

if ($matches.Count -eq 0) {
    throw "No phase blocks found in detail plan: $DetailPlanPath"
}

foreach ($match in $matches) {
    $phase = $match.Groups[1].Value
    $block = $match.Value.TrimEnd()

    $titleLine = ($block -split "`r?`n", 2)[0]
    $title = ($titleLine -replace '^##\s*', '').Trim()

    $header = @"
# $title - Step Subplan

> Source: $DetailPlanPath
> Required Skill: Invoke plan-for-all:test-driven-development before executing the detailed steps below.
> Copy Rule: The phase content below is an exact literal copy from the detail plan. Do not summarize, compress, omit, or rewrite.

"@

    $outPath = Join-Path $OutputDir ("step_subplan_phase{0}.md" -f $phase)
    $outText = $header + $block + "`r`n"

    Set-Content -LiteralPath $outPath -Value $outText -Encoding utf8
    Write-Host "Wrote $outPath"
}

Write-Host "Generated $($matches.Count) full-copy subplans from $DetailPlanPath"
