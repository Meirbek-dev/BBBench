# Get the number of script arguments and all arguments as a string
$scriptArgs = $args -join " "

# Function to run benchmark
function Invoke-Benchmark {
    param (
        [string]$Language,
        [string]$Executable,
        [string]$Command,
        [string]$Arguments
    )

    Write-Host "`n"
    # Check if the executable exists or if it's a runtime command
    $isRuntimeCmd = $Command -match '^(node|python|php|java|bun|deno)\b'
    if ((Test-Path -Path $Executable) -or $isRuntimeCmd) {
        if ($scriptArgs -ne "check") {
            # Format command for display
            $cmdDisplay = "$Command $Arguments"
            if ($cmdDisplay.Length -gt 80) {
                $cmdDisplay = $cmdDisplay.Substring(0, 60) + " ..."
            }

            Write-Host "Benchmarking $Language" -ForegroundColor Cyan
            try {
                # Using hyperfine for benchmarking
                hyperfine -i --output=pipe --runs 1 --warmup 1 -n $cmdDisplay -- "$Command $Arguments"
            }
            catch {
                Write-Host "Error running benchmark for $Language : $_" -ForegroundColor Red
            }
        }
    }
    else {
        Write-Host "No executable or script found for $Language. Skipping." -ForegroundColor Yellow
    }
}

# Run benchmarks for each language/runtime
$benchmarks = @(
    # @{
    #     Language = "Bun (Compiled)"
    #     Executable = ".\js\bun.exe"
    #     Command = ".\js\bun.exe"
    #     Arguments = $input
    # }
    # @{
    #     Language = "Bun"
    #     Executable = ".\js\code.js"
    #     Command = "bun"
    #     Arguments = ".\js\code.js $input"
    # }
    # @{
    #     Language = "C"
    #     Executable = ".\c\code.exe"
    #     Command = ".\c\code.exe"
    #     Arguments = $input
    # }
    # @{
    #     Language = "CPP"
    #     Executable = ".\cpp\code.exe"
    #     Command = ".\cpp\code.exe"
    #     Arguments = $input
    # }
    # @{
    #     Language = "Deno"
    #     Executable = ".\js\code.js"
    #     Command = "deno run"
    #     Arguments = ".\js\code.js $input"
    # }
    # @{
    #     Language = "Deno (jitless)"
    #     Executable = ".\js\code.js"
    #     Command = "deno run --v8-flags=--jitless"
    #     Arguments = ".\js\code.js $input"
    # }
    @{
        Language = "Go"
        Executable = ".\go\code.exe"
        Command = ".\go\code.exe"
        Arguments = $input
    }
    @{
        Language = "Java"
        Executable = ".\jvm\code.class"
        Command = "java"
        Arguments = "jvm.code $input"
    }
    # @{
    #     Language = "Node"
    #     Executable = ".\js\code.js"
    #     Command = "node"
    #     Arguments = ".\js\code.js $input"
    # }
    # @{
    #     Language = "Node (jitless)"
    #     Executable = ".\js\code.js"
    #     Command = "node --jitless"
    #     Arguments = ".\js\code.js $input"
    # }
    # @{
    #     Language = "PHP"
    #     Executable = ".\php\code.php"
    #     Command = "php"
    #     Arguments = ".\php\code.php $input"
    # }
    # @{
    #     Language = "PHP JIT"
    #     Executable = ".\php\code.php"
    #     Command = "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M"
    #     Arguments = ".\php\code.php $input"
    # }
    # @{
    #     Language = "Python"
    #     Executable = ".\py\code.py"
    #     Command = "python"
    #     Arguments = ".\py\code.py $input"
    # }
)

# Execute all benchmarks
foreach ($benchmark in $benchmarks) {
    Invoke-Benchmark `
        -Language $benchmark.Language `
        -Executable $benchmark.Executable `
        -Command $benchmark.Command `
        -Arguments $benchmark.Arguments
}
