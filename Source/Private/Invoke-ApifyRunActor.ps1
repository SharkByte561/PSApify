<#
.SYNOPSIS
    Starts an Apify actor run via the Apify API.
.DESCRIPTION
    Sends a POST request to the Apify API to start an actor run with the specified input.
.PARAMETER Url
    The URL to the Apify actor run endpoint.
.PARAMETER RunInput
    The input object (hashtable or PSObject) to pass to the actor.
.EXAMPLE
    $input = @{ foo = 'bar' }
    Invoke-ApifyRunActor -Url 'https://api.apify.com/v2/acts/apify~hello-world/runs' -RunInput $input
.NOTES
    Requires the environment variable 'ApifyToken' to be set with your Apify API token.
#>
function Invoke-ApifyRunActor {
    param(
        [string]$Url,
        [Parameter(Mandatory = $true)]
        [object]$RunInput # Accepts a hashtable or PSObject
    )

    $headers = @{
        "Content-Type"  = "application/json"
        "Authorization" = "Bearer $env:ApifyToken"
    }
    $body = $RunInput | ConvertTo-Json -Depth 10

    $response = Invoke-RestMethod -Method POST -Uri $Url -Headers $headers -Body $body
    return $response
}
