[CmdletBinding()]
Param (
  $UrlKortstokk = "http://nav-deckofcards.herokuapp.com/shuffle"
)

$ErrorActionPreference = 'Stop'

$response = Invoke-WebRequest -Uri $UrlKortstokk

$cards = $response.Content | ConvertFrom-Json

$kortstokk = @()
foreach ($card in $cards) {
    $kortstokk = $kortstokk + ($card.suit[0] + $card.value)
}

Write-Host "Kortstokk: $kortstokk"