# Tests for Invoke-Apify

Describe 'Invoke-Apify' {
    It 'Should call all internal steps and return dataset items' {
        # Arrange
        $actorId = 'apify/hello-world'
        $input = @{ foo = 'bar' }
        $runResult = @{ data = @{ id = 'run123' } }
        $finalRun = @{ data = @{ defaultDatasetId = 'ds456' } }
        $items = @( @{ result = 'ok' } )

        Mock Invoke-ApifyRunActor { $runResult }
        Mock Wait-ApifyActorRunSucceeded { $finalRun }
        Mock Get-ApifyDatasetItems { $items }

        # Act
        $result = Invoke-Apify -Id $actorId -RunInput $input

        # Assert
        Assert-MockCalled Invoke-ApifyRunActor -Exactly 1 -Scope It
        Assert-MockCalled Wait-ApifyActorRunSucceeded -Exactly 1 -Scope It
        Assert-MockCalled Get-ApifyDatasetItems -Exactly 1 -Scope It
        $result | Should -Be $items
    }
}
