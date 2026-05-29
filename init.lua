-- Helper function to detect Antfu ESLint config
local function has_antfu_eslint_config()
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
    local file = vim.fn.findfile(config_file, ".;")
    if file ~= "" then
      -- Read the file and check if it imports/uses antfu
      local f = io.open(file, "r")
      if f then
        local content = f:read("*all")
        f:close()
        -- Check for antfu imports or usage
        if content:match("@antfu/eslint%-config") or content:match('from ["\']antfu["\']') then
          return true
        end
      end
    end
  end

  return false
end

---@type LazySpec
return {
  -- Install eslint-lsp via Mason
  {
    "AstroNvim/astrolsp",
    optional = true,
    -- Only load if Antfu ESLint config is detected
    cond = has_antfu_eslint_config,
    ---@type AstroLSPOpts
    opts = {
      config = {
        eslint = {
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
        },
      },
    },
  },
  -- Ensure eslint-lsp is installed via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    cond = has_antfu_eslint_config,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "eslint-lsp" })
    end,
  },
}
