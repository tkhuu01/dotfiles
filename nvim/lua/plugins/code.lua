vim.diagnostic.config({
  virtual_text = true,      -- Show inline diagnostics as virtual text
  signs = true,             -- Show diagnostics in the sign column (optional)
  underline = true,         -- Underline text with errors/warnings (optional)
  update_in_insert = false, -- Avoid updating diagnostics while typing
  severity_sort = true,     -- Sort by severity (optional)
})
