# Oplin Notebook

[![build_windows](https://github.com/springeye/oplin/actions/workflows/build_windows.yaml/badge.svg)](https://github.com/henjue/notebook/actions/workflows/build_windows.yaml)
[![build_linux](https://github.com/springeye/oplin/actions/workflows/build_linux.yaml/badge.svg)](https://github.com/henjue/notebook/actions/workflows/build_linux.yaml)
[![build_macos](https://github.com/springeye/oplin/actions/workflows/build_macos.yaml/badge.svg)](https://github.com/henjue/notebook/actions/workflows/build_macos.yaml)

[Joplin](https://joplinapp.org/) is a very good software. with a learning attitude, I use flutter to
develop similar software, named 'oplin' A new Flutter project.

## Getting Started

1. flutter 3.0 or higher
2. enable desktop support [https://flutter.dev/desktop](https://flutter.dev/desktop)

## Run before

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### test objectbox preinstall

```
#Run on linux,cygwin,mssys,git-bash
bash <(curl -s https://raw.githubusercontent.com/objectbox/objectbox-dart/main/install.sh)
```

### release

[https://github.com/leanflutter/flutter_distributor]()

```
flutter_distributor release --name dev
```