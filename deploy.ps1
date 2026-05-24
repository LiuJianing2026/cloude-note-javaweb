$ErrorActionPreference = "Stop"

$PROJECT_DIR = "D:\JavaProjects\cloud-note-javaweb"
$TOMCAT_DIR = "D:\Developer\apache-tomcat-9.0.112"
$WAR_SOURCE = "$PROJECT_DIR\target\cloud-note.war"
$WAR_DEST = "$TOMCAT_DIR\webapps\cloud-note.war"
$APP_DIR = "$TOMCAT_DIR\webapps\cloud-note"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Deploying cloud-note to Tomcat" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1/7] Stopping Tomcat..." -ForegroundColor Yellow
& "$TOMCAT_DIR\bin\shutdown.bat"
Start-Sleep -Seconds 3
Write-Host "Tomcat stopped" -ForegroundColor Green
Write-Host ""

Write-Host "[2/7] Entering project directory..." -ForegroundColor Yellow
Set-Location $PROJECT_DIR
Write-Host "Current directory: $PROJECT_DIR" -ForegroundColor Green
Write-Host ""

Write-Host "[3/7] Running Maven clean package..." -ForegroundColor Yellow
& mvn clean package
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Maven build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit 1
}
Write-Host "Maven build successful" -ForegroundColor Green
Write-Host ""

Write-Host "[4/7] Checking war file exists..." -ForegroundColor Yellow
if (-not (Test-Path $WAR_SOURCE)) {
    Write-Host "ERROR: War file not found at $WAR_SOURCE" -ForegroundColor Red
    exit 1
}
Write-Host "War file found: $WAR_SOURCE" -ForegroundColor Green
Write-Host ""

Write-Host "[5/7] Removing old deployment..." -ForegroundColor Yellow
if (Test-Path $APP_DIR) {
    Remove-Item -Path $APP_DIR -Recurse -Force
    Write-Host "Removed old directory: $APP_DIR" -ForegroundColor Green
} else {
    Write-Host "Old directory not found, skipping" -ForegroundColor Gray
}
if (Test-Path $WAR_DEST) {
    Remove-Item -Path $WAR_DEST -Force
    Write-Host "Removed old war: $WAR_DEST" -ForegroundColor Green
} else {
    Write-Host "Old war not found, skipping" -ForegroundColor Gray
}
Write-Host ""

Write-Host "[6/7] Copying war file to Tomcat..." -ForegroundColor Yellow
Copy-Item -Path $WAR_SOURCE -Destination $WAR_DEST -Force
if (-not (Test-Path $WAR_DEST)) {
    Write-Host "ERROR: Failed to copy war file to $WAR_DEST" -ForegroundColor Red
    exit 1
}
Write-Host "Copied war file to: $WAR_DEST" -ForegroundColor Green
Write-Host ""

Write-Host "[7/7] Starting Tomcat..." -ForegroundColor Yellow
& "$TOMCAT_DIR\bin\startup.bat"
Start-Sleep -Seconds 5
Write-Host "Tomcat started" -ForegroundColor Green
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Deployment Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Home:     http://localhost:8080/cloud-note/" -ForegroundColor Cyan
Write-Host "Register: http://localhost:8080/cloud-note/register.jsp" -ForegroundColor Cyan