# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-05-29

### Added
- Smart lazy-loading: Only activates when Antfu ESLint config is detected
- Automatic detection of `eslint.config.{js,mjs,cjs,ts,mts,cts}` files
- Checks for `@antfu/eslint-config` import before loading

### Changed
- Plugin now safe to install globally - only loads in Antfu projects

## [1.0.0] - 2026-05-29

### Added
- Initial release of antfu-eslint.nvim
- AstroNvim plugin for @antfu/eslint-config
- Auto-fix on save using ESLint's codeActionOnSave
- Support for all Antfu config file types
- Automatic mason-tool-installer integration for eslint-lsp
- Antfu's recommended rulesCustomizations for silencing stylistic warnings

[1.1.0]: https://github.com/MatyiFKBT/antfu-eslint.nvim/releases/tag/v1.1.0
[1.0.0]: https://github.com/MatyiFKBT/antfu-eslint.nvim/releases/tag/v1.0.0
