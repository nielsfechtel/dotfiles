-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General", { clear = true })

-- Disable auto-comment on new line
autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable Automatic New Line Comment",
})

-- Auto-save
autocmd({ "FocusLost", "BufLeave", "BufWinLeave" }, {
  -- for format on save
  nested = true,
  callback = function()
    -- Don't autosave when editing config-files, otherwise there's constant config-reload-messages
    -- expand('%:p') gives full file path; find checks if the string is inside
    if string.find(vim.fn.expand("%:p"), [[.config/nvim]]) then
      return
    end
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! w")
    end
  end,
  group = general,
  desc = "Auto Save",
})

-- Update file on change
autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
  group = general,
  desc = "Update file when there are changes",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- from https://github.com/kezhenxu94/dotfiles/blob/092d9d796a56944fbb958a01a5f5fa4d88fa6ad0/config/nvim/lua/config/autocmds.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "dap-*",
    "git",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})
