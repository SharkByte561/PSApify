<#
.SYNOPSIS
    Waits for an Apify actor run to reach the SUCCEEDED state.
.DESCRIPTION
    Polls the Apify API for the status of a given actor run until it succeeds, fails, or times out.
.PARAMETER RunId
    The run ID returned from Invoke-ApifyRunActor.
.PARAMETER PollIntervalSec
    How often to poll the actor run status, in seconds. Default is 10.
.PARAMETER TimeoutSec
    Maximum time to wait for the actor run to finish, in seconds. Default is 600.
.EXAMPLE
    Wait-ApifyActorRunSucceeded -RunId 'abc123' -PollIntervalSec 5 -TimeoutSec 300
.NOTES
    Throws if the run fails, is aborted, or times out. Requires 'ApifyToken' environment variable.
#>
function Wait-ApifyActorRunSucceeded {
    param(
        [string]$RunId, # The run ID from Invoke-ApifyRunActor
        [int]$PollIntervalSec = 10, # How often to poll (seconds)
        [int]$TimeoutSec = 600      # Max time to wait (seconds)
    )

    $url = "https://api.apify.com/v2/actor-runs/$RunId"
    $headers = @{
        "Authorization" = "Bearer $env:ApifyToken"
    }

    $elapsed = 0
    while ($true) {
        $response = Invoke-RestMethod -Method GET -Uri $url -Headers $headers
        $status = $response.data.status
        Write-Host "Current status: $status"
        if ($status -eq "SUCCEEDED") {
            return $response
        }
        elseif ($status -eq "FAILED" -or $status -eq "ABORTED" -or $status -eq "TIMED-OUT") {
            throw "Actor run ended with status: $status"
        }
        Start-Sleep -Seconds $PollIntervalSec
        $elapsed += $PollIntervalSec
        if ($elapsed -ge $TimeoutSec) {
            throw "Timeout waiting for actor run to succeed."
        }
    }
}
