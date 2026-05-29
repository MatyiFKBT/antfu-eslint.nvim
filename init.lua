-- Helper function to detect Antfu ESLint config in a directory
local function has_antfu_eslint_config(dir)
  dir = dir or vim.fn.getcwd()
  
  -- Check for common ESLint flat config files
  local config_files = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  }

  for _, config_file in ipairs(config_files) do
    local file_path = dir .. "/" .. config_file
    local f = io.open(file_path, "r")
    if f then
      local content = f:read("*all")
      f:close()
      -- Check for antfu imports or usage
      if content:match("@antfu/eslint%-config") or content:match('from ["\']antfu["\']') then
        return true
      end
    end
  end

  return false
end

---@type LazySpec
return {
  -- Configure ESLint LSP when JS/TS files are opened
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = function(_, opts)
      -- Only configure ESLint if Antfu config exists
      if not has_antfu_eslint_config() then
        return opts
      end

      opts.config = opts.config or {}
      opts.config.eslint = {
        -- Enable ESLint for all supported file types
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
          "html",
          "markdown",
          "json",
          "jsonc",
          "yaml",
          "toml",
          "xml",
          "gql",
          "graphql",
          "astro",
          "svelte",
          "css",
          "less",
          "scss",
          "pcss",
          "postcss",
        },
        settings = {
          -- Enable code action on save (auto-fix)
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
          -- Enable formatting
          format = true,
          -- Silent the stylistic rules in IDE, but still auto fix them
          -- This is the recommended setup from Antfu's docs
          rulesCustomizations = {
            { rule = "style/*", severity = "off", fixable = true },
            { rule = "format/*", severity = "off", fixable = true },
            { rule = "*-indent", severity = "off", fixable = true },
            { rule = "*-spacing", severity = "off", fixable = true },
            { rule = "*-spaces", severity = "off", fixable = true },
            { rule = "*-order", severity = "off", fixable = true },
            { rule = "*-dangle", severity = "off", fixable = true },
            { rule = "*-newline", severity = "off", fixable = true },
            { rule = "*quotes", severity = "off", fixable = true },
            { rule = "*semi", severity = "off", fixable = true },
          },
        },
      }
      
      return opts
    end,
  },
  -- Ensure eslint-lsp is installed via Mason (always install, config is conditional)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "eslint-lsp" })
    end,
  },
}
