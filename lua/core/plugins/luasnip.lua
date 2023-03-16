local paths = {}
local user_snippets = _G.join_paths(get_config_dir(), "snippets")
paths[#paths + 1] = _G.join_paths(get_data_home(), "nvim", "site", "snippets", "friendly-snippets")
local stat = vim.loop.fs_stat(user_snippets)
if stat and stat.type == "directory" then
	paths[#paths + 1] = user_snippets
end

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = paths })
require("luasnip.loaders.from_snipmate").lazy_load()
