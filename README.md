# Antfu ESLint Config for AstroNvim

**Requirements:**

- `eslint` v9.5.0+ installed in your project
- `@antfu/eslint-config` installed in your project
- `@stylistic/eslint-plugin` (if using stylistic options)
- `eslint.config.mjs` (or `.js`, `.ts`, etc.) in your project root that imports `@antfu/eslint-config`
- `eslint-lsp` installed via Mason (see installation)

This plugin provides ESLint integration using [@antfu/eslint-config](https://github.com/antfu/eslint-config) with auto-fix on save:

- **Smart detection**: Only activates when an Antfu ESLint config is detected in your project
- Configures ESLint for JavaScript, TypeScript, React, Vue, and 20+ file types
- Enables `codeActionOnSave` for automatic fixing on save
- Applies Antfu's recommended `rulesCustomizations` to silence stylistic warnings in IDE while still auto-fixing them

## Installation

### 1. Install the plugin

Add to your `lua/community.lua` or `lua/plugins/antfu-eslint.lua`:

```lua
return {
  "MatyiFKBT/antfu-eslint.nvim",
}
```

### 2. Install eslint-lsp

Add to your Mason config (`lua/plugins/mason.lua`):

```lua
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = {
      "eslint-lsp", -- Required for antfu-eslint.nvim
      -- ... your other tools
    },
  },
}
```

Then restart Neovim and run:
```vim
:MasonToolsInstall
```

Or install manually:
```vim
:MasonInstall eslint-lsp
```

## Example Project Setup

Install dependencies in your project:

```bash
bun add -D eslint @antfu/eslint-config @stylistic/eslint-plugin
```

Create `eslint.config.mjs` in your project root:

```js
import antfu from '@antfu/eslint-config'

export default antfu({
  react: true, // or vue: true, svelte: true, etc.
  stylistic: {
    semi: true,
    quotes: 'double',
  },
})
```

## How It Works

The plugin automatically detects if you're using Antfu's ESLint config by:

1. Checking for ESLint flat config files (`eslint.config.{js,mjs,cjs,ts,mts,cts}`) in your project root
2. Reading the config file to verify it imports `@antfu/eslint-config`
3. Only applying ESLint LSP configuration if both conditions are met

**Benefits:**
- Safe to install globally in your AstroNvim config
- Won't interfere with non-Antfu projects
- Zero configuration needed once `eslint-lsp` is installed

## Configuration

Customize by overriding in your own `astrolsp.lua`:

```lua
return {
  "AstroNvim/astrolsp",
  opts = {
    config = {
      eslint = {
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = "problems", -- Only fix errors, not warnings
          },
        },
      },
    },
  },
}
```
