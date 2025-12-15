-- ABOUTME: nvim-tree 配置覆盖
-- ABOUTME: 自定义文件树显示选项

return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    filters = {
      git_ignored = false,
    },
  },
}
