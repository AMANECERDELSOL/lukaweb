@echo off
title LUKA NATURAL ELEGANCE - Servidor Local
color 0A
echo.
echo  ============================================
echo   LUKA NATURAL ELEGANCE - Iniciando Servidor Local
echo  ============================================
echo.

:: Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo  [ERROR] Node.js no esta instalado.
    echo  Descarga Node.js desde https://nodejs.org
    pause
    exit /b 1
)

echo  [OK] Node.js encontrado
echo.

:: Install backend dependencies if needed
if not exist "backend\node_modules" (
    echo  Instalando dependencias del backend...
    cd backend
    call npm install
    cd ..
    echo.
)

:: Install frontend dependencies if needed
if not exist "frontend\node_modules" (
    echo  Instalando dependencias del frontend...
    cd frontend
    call npm install
    cd ..
    echo.
)

:: Seed database if it doesn't exist
if not exist "backend\data\store.db" (
    echo  Inicializando base de datos...
    cd backend
    call npx tsx src/seed.ts
    cd ..
    echo.
)

echo  Iniciando servidores...
echo.
echo  Backend:  http://localhost:3001
echo  Frontend: http://localhost:5173
echo  Admin:    http://localhost:5173/admin
echo.
echo  Presiona Ctrl+C para detener los servidores
echo  ============================================
echo.

:: Start backend in background
start "BELLEZA LUXE - Backend" /min cmd /c "cd backend && npx tsx src/server.ts"

:: Wait a moment for the backend to start
timeout /t 3 /nobreak >nul

:: Start frontend
cd frontend
call npm run dev
