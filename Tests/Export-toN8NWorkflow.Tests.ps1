# Tests for Export-toN8NWorkflow

Describe 'Export-toN8NWorkflow' {
    It 'Should convert object array to JSON and call Invoke-RestMethod' {
        # Arrange
        $webhook = 'https://example.com/webhook'
        $data = @(
            @{ name = 'User 1'; email = 'user1@example.com' },
            @{ name = 'User 2'; email = 'user2@example.com' }
        )
        
        Mock Invoke-RestMethod { return 'OK' }

        # Act
        $result = Export-toN8NWorkflow -WebhookUrl $webhook -Json $data

        # Assert
        Assert-MockCalled Invoke-RestMethod -Exactly 1 -Scope It
    }

    It 'Should send raw JSON when -RawJson is used' {
        # Arrange
        $webhook = 'https://example.com/webhook'
        $json = '[{"name":"User 1","email":"user1@example.com"}]'
        
        Mock Invoke-RestMethod { return 'OK' }

        # Act
        $result = Export-toN8NWorkflow -WebhookUrl $webhook -Json $json -RawJson

        # Assert
        Assert-MockCalled Invoke-RestMethod -Exactly 1 -Scope It
    }
}
