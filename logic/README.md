# MXC Shared Logic

[![style: flutter_lints](https://img.shields.io/badge/style-flutter__lints-4BC0F5)](https://pub.dev/packages/flutter_lints)

This is shared mxc logic package which contains common logic for mxc apps.

There's only logic that should be shared, the package doesn't contain things unique for each app. If you want to find something more specific, please refer to concrete app codebase.

The package is written in the spirit of [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) (popular idea in app design), and is divided into [data](./lib/src/data) and [domain](./lib/src/domain) layers.
