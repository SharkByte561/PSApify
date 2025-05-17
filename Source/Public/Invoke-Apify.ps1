<#
.SYNOPSIS
    Runs an Apify actor and retrieves its output dataset items.
.DESCRIPTION
    Starts an Apify actor run, waits for it to complete, and fetches the resulting dataset items. Handles polling and timeout.
.PARAMETER Id
    The Apify actor ID to run (e.g., 'apify/hello-world').
.PARAMETER RunInput
    The input object (hashtable or PSObject) to pass to the actor.
.PARAMETER PollIntervalSec
    How often to poll the actor run status, in seconds. Default is 10.
.PARAMETER TimeoutSec
    Maximum time to wait for the actor run to finish, in seconds. Default is 600.
.EXAMPLE
$RunInput = @"
{
    "location": "United States",
    "proxy": {
        "useApifyProxy": true,
        "apifyProxyGroups": [
            "RESIDENTIAL"
        ]
    },
    "publishedAt": "r2592000",
    "rows": 5,
    "title": "SEO"
}
"@ | ConvertFrom-Json

Invoke-Apify -Id 'BHzefUZlZRKWxkTck' -RunInput $input
.NOTES
    Requires the environment variable 'ApifyToken' to be set with your Apify API token.
#>
function Invoke-Apify {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Id, # Apify actor ID
        [Parameter(Mandatory = $true)]
        [object]$RunInput, # Accepts a hashtable or PSObject
        [int]$PollIntervalSec = 10,
        [int]$TimeoutSec = 600
    )

    $url = "https://api.apify.com/v2/acts/$Id/runs"

    # Step 1: Start the actor run
    $runResult = Invoke-ApifyRunActor -Url $url -RunInput $RunInput
    $runId = $runResult.data.id

    # Step 2: Wait for the actor run to succeed
    $finalRun = Wait-ApifyActorRunSucceeded -RunId $runId -PollIntervalSec $PollIntervalSec -TimeoutSec $TimeoutSec
    $datasetId = $finalRun.data.defaultDatasetId

    # Step 3: Get the dataset items
    $items = Get-ApifyDatasetItems -DefaultDatasetId $datasetId

    return $items
}