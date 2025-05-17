<#
.SYNOPSIS
    Exports JSON data to an n8n workflow via HTTP POST.
.DESCRIPTION
    Sends JSON data (either as a raw string or as an object/array to be converted) to a specified n8n webhook URL. Useful for integrating PowerShell data with n8n workflows.
.PARAMETER WebhookUrl
    The n8n webhook URL to which the data will be posted.
.PARAMETER Json
    The data to send. If -RawJson is specified, this should be a JSON string. Otherwise, it can be any object or array.
.PARAMETER RawJson
    If specified, treats the -Json parameter as a raw JSON string and uploads it as-is. Otherwise, the object is converted to JSON.
.EXAMPLE
    # Send an array of objects (converted to JSON automatically)
    $data = @(
        @{ name = 'User 1'; email = 'user1@example.com' },
        @{ name = 'User 2'; email = 'user2@example.com' }
    )
    Export-toN8NWorkflow -WebhookUrl 'https://example.com/webhook' -Json $data
.EXAMPLE
    # Send a raw JSON string
    $json = '[{"name":"User 1","email":"user1@example.com"}]'
    Export-toN8NWorkflow -WebhookUrl 'https://example.com/webhook' -Json $json -RawJson
.NOTES
    The n8n workflow should expect an array or object in the request body.
#>
function Export-toN8NWorkflow {
    param(
        [Parameter(Mandatory = $true)]
        [string]$WebhookUrl,
        [Parameter(Mandatory = $true)]
        $Json,
        [switch]$RawJson
    )
    if ($RawJson) {
        $bodyJson = $Json
    }
    else {
        $bodyJson = $Json | ConvertTo-Json -Depth 10 -Compress
    }
    Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $bodyJson -ContentType "application/json"
}
