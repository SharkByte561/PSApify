<#
.SYNOPSIS
    Retrieves items from an Apify dataset.
.DESCRIPTION
    Fetches the items from the specified Apify dataset using the dataset ID.
.PARAMETER DefaultDatasetId
    The dataset ID returned from a completed actor run.
.EXAMPLE
    Get-ApifyDatasetItems -DefaultDatasetId 'xyz789'
.NOTES
    Requires the environment variable 'ApifyToken' to be set with your Apify API token.
#>
function Get-ApifyDatasetItems {
    param(
        [string]$DefaultDatasetId # The dataset ID returned from the previous step
    )

    $url = "https://api.apify.com/v2/datasets/$DefaultDatasetId/items"
    $headers = @{
        "Authorization" = "Bearer $env:ApifyToken"
    }

    $response = Invoke-RestMethod -Method GET -Uri $url -Headers $headers
    return $response
}
