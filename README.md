# Antfu ESLint Config for AstroNvim

**Requirements:**

- `eslint` v9.5.0+ must be installed in your project
- `@antfu/eslint-config` must be installed in your project
- `@stylistic/eslint-plugin` (if using stylistic options)
- `eslint.config.mjs` (or `.js`, `.ts`, etc.) in your project root that imports `@antfu/eslint-config`

This plugin provides ESLint integration using [@antfu/eslint-config](https://github.com/antfu/eslint-config) with auto-fix on save:

- **Smart lazy-loading**: Only activates when an Antfu ESLint config is detected in your project
- Installs `eslint-lsp` via Mason
- Configures ESLint for JavaScript, TypeScript, React, Vue, and 20+ file types
- Enables `codeActionOnSave` for automatic fixing on save
- Applies Antfu's recommended `rulesCustomizations` to silence stylistic warnings in IDE while still auto-fixing them

## Installation

### Using Lazy.nvim (AstroNvim)

Add to your `lua/community.lua` or `lua/plugins/antfu-eslint.lua`:

```lua
return {
  "MatyiFKBT/antfu-eslint.nvim",
}
```

### Manual Installation

Clone into your AstroNvim config:

```bash
cd ~/.config/nvim/lua
git clone https://github.com/MatyiFKBT/antfu-eslint.nvim antfu-eslint
```

Then import:

```lua
return {
  { import = "antfu-eslint" },
}
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

1. Searching for ESLint flat config files (`eslint.config.{js,mjs,cjs,ts,mts,cts}`)
2. Checking if the config imports `@antfu/eslint-config`
3. Only loading the ESLint LSP configuration if both conditions are met

This means you can safely install this plugin globally in your AstroNvim config, and it will only activate in projects that use Antfu's ESLint config!

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
