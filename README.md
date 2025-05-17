# PSAPify Module

## Video Demo Walkthrough

[Watch the walkthrough on YouTube](https://youtu.be/AxpSLIlOLLE)

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
$input = @{ foo = 'bar' }
Invoke-Apify -Id 'apify/hello-world' -RunInput $input
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
