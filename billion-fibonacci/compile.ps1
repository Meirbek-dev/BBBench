# Function to compile code for different languages
function Invoke-Compile {
    param (
        [string]$Directory,
        [string]$Command,
        [string]$Language
    )

    if (Test-Path -Path $Directory) {
        Write-Host "`nCompiling $Language..." -ForegroundColor Cyan

        try {
            # Redirect stderr to null and execute the command
            $output = & cmd /c "$Command 2>NUL"

            if ($LASTEXITCODE -ne 0) {
                Write-Host "Failed to compile ${Language} with command: ${Command}" -ForegroundColor Red
            }
            else {
                Write-Host "Successfully compiled ${Language}" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "Error executing compile command for ${Language}: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Directory '$Directory' not found. Skipping $Language compilation." -ForegroundColor Yellow
    }
}

# Set error action preference
$ErrorActionPreference = "Continue"

# Create compilation tasks
$compilationTasks = @(
    @{
        Directory = "jvm"
        Command   = "javac jvm/code.java"
        Language  = "Java"
    }
    # @{
    #     Directory = "c"
    #     Command   = "gcc -O3 c/code.c -o c/code"
    #     Language  = "C"
    # },
    # @{
    #     Directory = "cpp"
    #     Command   = "g++ -std=c++23 -march=native -O3 -Ofast -o cpp/code cpp/code.cpp"
    #     Language  = "C++"
    # },
    # @{
    #     Directory = "js"
    #     Command   = "bun build --bytecode --compile js/code.js --outfile js/bun"
    #     Language  = "JavaScript (Bun)"
    # },
    # @{
    #     Directory = "ts"
    #     Command   = "bun build --bytecode --compile ts/code.js --outfile ts/bun"
    #     Language  = "JavaScript (Bun)"
    # }
)

# Function to compile Go code (special handling)
function Invoke-GoCompile {
    if (Test-Path -Path "go") {
        Write-Host "`nCompiling Go..." -ForegroundColor Cyan
        try {
            $output = & cmd /c "go build -ldflags `"-s -w`" -o go/code.exe go/code.go 2>NUL"
            if ($LASTEXITCODE -ne 0) {
                Write-Host "Failed to compile Go" -ForegroundColor Red
            }
            else {
                Write-Host "Successfully compiled Go" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "Error executing Go compile command: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Directory 'go' not found. Skipping Go compilation." -ForegroundColor Yellow
    }
}

# Main execution
Write-Host "Starting compilation process..." -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Execute all compilation tasks
foreach ($task in $compilationTasks) {
    Invoke-Compile -Directory $task.Directory -Command $task.Command -Language $task.Language
}

# Execute Go compilation separately
Invoke-GoCompile

Write-Host "`nCompilation process completed" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
