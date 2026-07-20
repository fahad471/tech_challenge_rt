# Runtime Plugin Challenge

Cross-platform C++20 project demonstrating runtime-loaded shared-library plugins, built with CMake and Conan 2.

## Requirements

- CMake 3.21+
- Conan 2
- Python 3
- Ninja
- Linux: GCC 11+ or Clang 14+
- Windows: Visual Studio 2022 with MSVC

Install Conan:

```bash
python -m pip install "conan>=2,<3"
```

## Clone

```bash
git clone https://github.com/fahad471/tech_challenge_rt.git
cd tech_challenge_rt
```

## Build and Test

### Linux with GCC

```bash
conan profile detect --force

conan install . \
  --build=missing \
  -s build_type=Release \
  -s compiler.cppstd=20

cmake --preset conan-release
cmake --build --preset conan-release
ctest --preset conan-release --output-on-failure
```

### Linux with Clang

```bash
CC=clang CXX=clang++ conan profile detect --force

CC=clang CXX=clang++ conan install . \
  --build=missing \
  -s build_type=Release \
  -s compiler.cppstd=20

CC=clang CXX=clang++ cmake --preset conan-release
cmake --build --preset conan-release
ctest --preset conan-release --output-on-failure
```

### Windows with MSVC

Run the following commands from a Visual Studio 2022 Developer PowerShell:

```powershell
conan profile detect --force

conan install . `
  --build=missing `
  -s build_type=Release `
  -s compiler.cppstd=20

cmake --preset conan-release
cmake --build --preset conan-release
ctest --preset conan-release --output-on-failure
```

## Run

The executable discovers and loads the available plugins at runtime.

### Linux

```bash
./build/Release/bin/challenge
```

### Windows

```powershell
.\build\Release\bin\challenge.exe
```

## Code Quality

The project uses `clang-format` and `clang-tidy` through pre-commit.

Install pre-commit:

```bash
python -m pip install pre-commit
```

Run all checks:

```bash
pre-commit run --all-files
```

The lint setup is intended to run on Linux or WSL.

## AddressSanitizer

AddressSanitizer is supported on Linux with GCC or Clang.

First install the dependencies normally:

```bash
conan profile detect --force

conan install . \
  --build=missing \
  -s build_type=Release \
  -s compiler.cppstd=20
```

Configure and build with AddressSanitizer enabled:

```bash
cmake --preset conan-release -DENABLE_SANITIZERS=ON
cmake --build --preset conan-release
```

Run the tests:

```bash
ASAN_OPTIONS=detect_leaks=1:halt_on_error=1 \
  ctest --preset conan-release --output-on-failure
```

## Install

The install step creates a self-contained directory containing the executable, runtime plugins, and required shared dependencies.

### Linux

```bash
cmake --install build/Release --prefix package
```

Run the installed executable:

```bash
./package/bin/challenge
```

### Windows

```powershell
cmake --install build --config Release --prefix package
```

Run the installed executable:

```powershell
.\package\bin\challenge.exe
```

## Conan Package

The project includes a Conan 2 recipe and a `test_package` consumer project.

Create, build, package, and test the Conan package:

### Linux

```bash
conan create . \
  --build=missing \
  -s build_type=Release \
  -s compiler.cppstd=20
```

### Windows

```powershell
conan create . `
  --build=missing `
  -s build_type=Release `
  -s compiler.cppstd=20
```

Test an existing package explicitly:

### Linux

```bash
conan test \
  test_package \
  challenge_project/1.0.0 \
  -s build_type=Release \
  -s compiler.cppstd=20
```

### Windows

```powershell
conan test `
  test_package `
  challenge_project/1.0.0 `
  -s build_type=Release `
  -s compiler.cppstd=20
```

## Conan Cache Archives

The CI pipeline creates platform-specific Conan cache archives and attaches them to versioned GitHub releases.

Restore the Linux Conan package archive:

```bash
conan cache restore challenge-conan-package.tar.gz
```

Restore the Windows Conan package archive:

```powershell
conan cache restore challenge-conan-package-windows.tar.gz
```

Verify that the restored package exists:

```bash
conan list "challenge_project/1.0.0:*"
```

## Continuous Integration

GitHub Actions runs the following checks:

- Build and test with GCC on Linux
- Build and test with Clang on Linux
- Build and test with MSVC on Windows
- Run `clang-format` and `clang-tidy`
- Run AddressSanitizer tests on Linux
- Create self-contained install archives
- Create and test Conan packages on Linux and Windows
- Publish archives when a tag matching `v*.*.*` is pushed

Example release tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```
