# PSAPify Module

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/PSAPify)](https://www.powershellgallery.com/packages/PSAPify)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSAPify)](https://www.powershellgallery.com/packages/PSAPify)
[![GitHub license](https://img.shields.io/github/license/microsoft/PSAPify)](https://github.com/microsoft/PSAPify/blob/main/LICENSE)
<!-- [![Build Status](https://img.shields.io/github/workflow/status/microsoft/PSAPify/main)](https://github.com/microsoft/PSAPify/actions) -->

## Video Demo Walkthrough

[Watch the walkthrough on YouTube](https://youtu.be/AxpSLIlOLLE)

<a href="https://youtu.be/AxpSLIlOLLE"><img src="https://img.youtube.com/vi/AxpSLIlOLLE/0.jpg" width="400">

## Description

PSAPify is a PowerShell module for interacting with the Apify platform and integrating with n8n workflows. It provides functions to run Apify actors, retrieve their results, and export data to n8n via webhooks.

## Installation

```powershell
Install-Module -Name PSAPify
```

## Usage

```powershell
Import-Module PSAPify
```

### Run an Apify Actor and Get Results

```powershell
$input = @"
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
"@
Invoke-Apify -Id 'BHzefUZlZRKWxkTck' -RunInput $input
```

### Export Data to n8n Workflow (Object/Array)

```powershell
$data = @(
    @{ name = 'User 1'; email = 'user1@example.com' },
    @{ name = 'User 2'; email = 'user2@example.com' }
)
Export-toN8NWorkflow -WebhookUrl 'https://example.com/webhook' -Json $data
```

### Export Data to n8n Workflow (Raw JSON)

```powershell
$json = '[{"name":"User 1","email":"user1@example.com"}]'
Export-toN8NWorkflow -WebhookUrl 'https://example.com/webhook' -Json $json -RawJson
```

## Notes

- The environment variable `ApifyToken` must be set with your Apify API token for Apify-related functions.
- The n8n workflow should expect an array or object in the request body for webhook integration.
