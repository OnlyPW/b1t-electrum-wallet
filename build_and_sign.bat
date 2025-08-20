@echo off
echo Starting B1T Electrum build and sign process...
echo.

echo Step 1: Cleaning previous build...
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
echo.

echo Step 2: Building with PyInstaller...
pyinstaller pyinstaller_b1t.spec --clean
if %errorlevel% neq 0 (
    echo ERROR: PyInstaller build failed!
    pause
    exit /b 1
)
echo Build completed successfully!
echo.

echo Step 3: Signing executables...
powershell -ExecutionPolicy Bypass -File .\sign_exe.ps1
if %errorlevel% neq 0 (
    echo WARNING: Signing process completed with warnings/errors
) else (
    echo Signing completed successfully!
)
echo.

echo Build and sign process completed!
echo Executable files are located in the 'dist' directory.
pause