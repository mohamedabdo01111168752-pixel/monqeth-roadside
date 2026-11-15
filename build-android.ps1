$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    throw "Node.js is required to build the bundled CSS."
}

if (-not $env:JAVA_HOME) {
    $portableJdk = Join-Path $env:LOCALAPPDATA "MonqethBuildTools\jdk17"
    if (Test-Path (Join-Path $portableJdk "bin\java.exe")) {
        $env:JAVA_HOME = $portableJdk
    }
}

if (-not $env:ANDROID_HOME) {
    $installedSdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
    if (Test-Path $installedSdk) {
        $env:ANDROID_HOME = $installedSdk
    }
}

if (-not $env:ANDROID_HOME) {
    throw "Android SDK not found. Install Android Studio or set ANDROID_HOME."
}

if (-not (Test-Path ".\gradlew.bat")) {
    throw "Gradle wrapper is missing. Open this project in Android Studio or generate the wrapper with Gradle 8.7."
}

npm.cmd ci
if ($LASTEXITCODE -ne 0) { throw "Installing the CSS build dependency failed." }

npm.cmd run build:css
if ($LASTEXITCODE -ne 0) { throw "Building the CSS failed." }

& .\gradlew.bat --no-daemon assembleDebug
if ($LASTEXITCODE -ne 0) { throw "Android APK build failed." }

$apkPath = Join-Path $projectRoot "app\build\outputs\apk\debug\app-debug.apk"
if (-not (Test-Path $apkPath)) {
    throw "Gradle completed without producing the expected APK: $apkPath"
}

Write-Host "APK ready: $apkPath"
