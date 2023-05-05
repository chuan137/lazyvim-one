local function get_copilot()
  local copilot = require("copilot")
  if not copilot.is_available() then
    return nil
  end
  return copilot
end

return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- vim.g.copilot_tab_fallback = ""

      vim.keymap.set("i", "<C-H>", "copilot#Previous()", { silent = true, expr = true })
      vim.keymap.set("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
      vim.keymap.set({ "i", "n" }, "<C-x>", "<cmd>Copilot panel<cr>", { silent = true })
      vim.keymap.set("i", "<Right>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
      vim.keymap.set("i", "<S-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
    end,
  },
}
