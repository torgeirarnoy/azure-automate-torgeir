[CmdletBinding()]
Param (
  $UrlKortstokk = "http://nav-deckofcards.herokuapp.com/shuffle"
)

# Definerer at scriptet skal stoppe hvis det er en feil
$ErrorActionPreference = 'Stop'

$response = Invoke-WebRequest -Uri $UrlKortstokk

# Konverterer kortstokken fra JSON
$cards = $response.Content | ConvertFrom-Json

# Setter sum parameteren til 0
$sum = 0

# Manipulerer knekt, dronning, konge og ess til definerte verdier
foreach ($card in $cards) {
    $sum += switch ($card.value) {
      'J' { 10 }
      'Q' { 10 }
      'K' { 10 }
      'A' { 11 }
      Default { $card.value }
    }
}

# Lager funksjon på hvordan man printer kortstokken
function kortstokkPrint {
  param (
    [Parameter()]
    [Object[]]
    $cards
  )
  # Skriver ut kortstokken
$kortstokk = @()
foreach ($card in $cards) {
    $kortstokk += ($card.suit[0] + $card.value)
  }
$kortstokk
}


# Printer til konsoll
Write-Host "Kortstokk: $(kortstokkPrint($cards))"
Write-Host "Poengsum: $sum"



$meg = $cards[0..1]
$cards = $cards[2..$cards.Length]

$magnus = $cards[0..1]
$cards = $cards[2..$cards.Length]

Write-Host "meg: $(kortstokkPrint($meg))"
Write-Host "magnus: $(kortstokkPrint($magnus))"
Write-Host "Kortstokk: $(kortstokkPrint($cards))"