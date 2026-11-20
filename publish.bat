@echo off
rem ------------------------------------------------------------------
rem  One-click publish: saves every change in this folder to GitHub.
rem  Pushing to GitHub automatically updates BOTH live sites:
rem    - GitHub Pages: https://poojajain-01.github.io/Portfolio-Pooja/
rem    - Vercel:       https://portfolio-pooja-gamma.vercel.app/
rem  Just double-click this file after you change anything.
rem ------------------------------------------------------------------
cd /d "%~dp0"
where git >nul 2>nul || set "PATH=%PATH%;C:\Program Files\Git\cmd"

echo.
echo  Publishing your portfolio...
echo.

rem get the latest version first, in case something was changed on GitHub directly
git pull --rebase --autostash -q
if errorlevel 1 (
  echo  Could not get the latest version from GitHub. Nothing was published.
  pause
  exit /b 1
)

git add -A
git diff --cached --quiet && (
  echo  No new changes to publish. Your sites are already up to date.
  echo.
  pause
  exit /b 0
)

echo  Files being published:
git diff --cached --name-status
echo.
set "msg="
set /p msg= Describe your change (or just press Enter):
if "%msg%"=="" set "msg=Update portfolio"

git commit -q -m "%msg%"
git push -q
if errorlevel 1 (
  echo.
  echo  Push failed. Check your internet connection or GitHub sign-in and try again.
  pause
  exit /b 1
)

echo.
echo  Done! Your changes are on GitHub.
echo  Both sites will update in about 1 minute:
echo    https://poojajain-01.github.io/Portfolio-Pooja/
echo    https://portfolio-pooja-gamma.vercel.app/
echo.
pause
