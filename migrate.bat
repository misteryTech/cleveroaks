@echo off
REM Shows which migrations (revisions) are pending, applies them, then lists the result.
REM Usage: migrate.bat            -> preview pending migrations, then apply them
REM        migrate.bat --plan     -> preview only, apply nothing
REM Set DB_PASSWORD (and DB_USER / DB_HOST / DB_PORT / DB_NAME if not default) before running:
REM   set DB_PASSWORD=your-password

cd /d "%~dp0"

set PY=venv\Scripts\python.exe
if not exist "%PY%" (
    echo === Creating virtual environment in venv ===
    python -m venv venv || goto :error
)

echo === Installing requirements ===
"%PY%" -m pip install -q -r requirements.txt || goto :error

echo.
echo === Model changes not yet in a migration file ===
"%PY%" manage.py makemigrations --dry-run || goto :error

echo.
echo === Migrations that will be applied ===
"%PY%" manage.py migrate --plan || goto :error

if /i "%~1"=="--plan" goto :done

echo.
echo === Applying migrations ===
"%PY%" manage.py migrate || goto :error

echo.
echo === Migration status ([X] = applied) ===
"%PY%" manage.py showmigrations || goto :error

:done
exit /b 0

:error
echo.
echo Failed. Check the error above (database password/port are read from DB_* env vars).
exit /b 1
