return {
  -- go.nvim 插件
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- 禁用默认按键映射（可选）
        lsp_keymaps = false,
        -- 其他配置选项
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,
        dap_debug = true,
      })
      
      -- 自动导入和格式化（使用 goimports-reviser）
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          local file = vim.fn.expand("%:p")
          -- goimports-reviser 自动从 go.mod 读取 module name 作为 local prefix
          -- 分组顺序：标准库 -> 外部包 -> 内部包
          vim.fn.system("goimports-reviser -rm-unused -set-alias -use-cache " .. vim.fn.shellescape(file))
          vim.cmd("edit")
        end,
        group = format_sync_grp,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", "gomod"},
    build = ':lua require("go.install").update_all_sync()',
  },

  -- 确保 Treesitter 安装了 Go 解析器
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },
}
