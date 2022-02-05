modes = setmetatable({
   ["n"] = "⨀",
   ["no"] = "⨀",
   ["v"] = "⨂",
   ["V"] = "⨂",
   [""] = "⨂",
   ["s"] = "⨂",
   ["S"] = "⨂",
   [""] = "⨂",
   ["i"] = "*",
   ["ic"] = "*",
   ["R"] = "⨀",
   ["Rv"] = "⨀",
   ["c"] = "*",
   ["cv"] = "*",
   ["ce"] = "*",
   ["r"] = "r",
   ["rm"] = "r",
   ["r?"] = "r",
   ["!"] = "!",
   ["t"] = "t",
   }, {
   __index = function()
      return "U" -- handle edge cases
   end,
})

function get_current_mode()
   local current_mode = vim.api.nvim_get_mode().mode
   return string.format(" %s ", modes[current_mode]):upper()
end

function get_git_status()
   local branch = vim.b.gitsigns_status_dict or { head = "" }
   local is_head_empty = branch.head ~= ""
   return is_head_empty and string.format(" (#%s) ", branch.head or "") or ""
end

function get_filename()
   local filename = vim.fn.expand "%:t"
   return filename == "" and "" or filename
end

function get_line_col()
   return "%l:%c"
end

function space()
   return " "
end

function status_line()
   return table.concat {
      "%#StatusLineAccent#",
      get_current_mode(),
      "%#StatusLine#",
      space(),
      get_filename(),
      get_git_status(),
      "%=",
      get_line_col(),
   }
end

local M = {}
function M.setup()
   vim.o.statusline = "%!luaeval('status_line()')"
end
return M
