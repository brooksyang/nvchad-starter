-- ABOUTME: Markdown 预览插件配置
-- ABOUTME: 使用 markdown-preview.nvim 实时预览 Markdown 文件

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npm install",
}
