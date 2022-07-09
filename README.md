# Oplin Notebook

[![build_windows](https://github.com/springeye/oplin/actions/workflows/build_windows.yaml/badge.svg)](https://github.com/henjue/notebook/actions/workflows/build_windows.yaml)
[![build_linux](https://github.com/springeye/oplin/actions/workflows/build_linux.yaml/badge.svg)](https://github.com/henjue/notebook/actions/workflows/build_linux.yaml)
[![build_macos](https://github.com/springeye/oplin/actions/workflows/build_macos.yaml/badge.svg)](https://github.com/henjue/notebook/actions/workflows/build_macos.yaml)

A simple, private notebook with data stored on WebDAV

## Getting Started

1. flutter 3.0.4 or higher (recommend use [fvm](https://fvm.app/docs/getting_started/installation))
2. enable desktop support [https://flutter.dev/desktop](https://flutter.dev/desktop)

## Run before

```bash
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

### release

use [flutter_distributor](https://github.com/leanflutter/flutter_distributor)

```
fvm flutter pub run flutter_distributor:main release --name prod
```