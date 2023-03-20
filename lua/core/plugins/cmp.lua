local icons = require("core.icons")
local cmp = require("cmp")
local luasnip = require("luasnip")
require("cmp_nvim_ultisnips").setup{}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function jumpable(dir)
    local win_get_cursor = vim.api.nvim_win_get_cursor
    local get_current_buf = vim.api.nvim_get_current_buf

    ---sets the current buffer's luasnip to the one nearest the cursor
    ---@return boolean true if a node is found, false otherwise
    local function seek_luasnip_cursor_node()
        -- TODO(kylo252): upstream this
        -- for outdated versions of luasnip
        if not luasnip.session.current_nodes then
            return false
        end

        local node = luasnip.session.current_nodes[get_current_buf()]
        if not node then
            return false
        end

        local snippet = node.parent.snippet
        local exit_node = snippet.insert_nodes[0]

        local pos = win_get_cursor(0)
        pos[1] = pos[1] - 1

        -- exit early if we're past the exit node
        if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        node = snippet.inner_first:jump_into(1, true)
        while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
                or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- Past unmarked exit node, exit early
            if n_next == nil or n_next == snippet.next then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end

            if candidate then
                luasnip.session.current_nodes[get_current_buf()] = node
                return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
            if not ok then
                snippet:remove_from_jumplist()
                luasnip.session.current_nodes[get_current_buf()] = nil

                return false
            end
        end

        -- No candidate, but have an exit node
        if exit_node then
            -- to jump to the exit node, seek to snippet
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
        end

        -- No exit node, exit from snippet
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil
        return false
    end

    if dir == -1 then
        return luasnip.in_snippet() and luasnip.jumpable(-1)
    else
        return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
    end
end

local sourcenames = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
    copilot = "(Copilot)",
    treesitter = "(TreeSitter)",
}

local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
}

local confirmopts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
}

cmp.setup({
    active = true,
    --[[ enabled = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
            return false
        end
        return true
    end, ]]
    enabled = true,
    confirm_opts = confirmopts,
    completion = {
        enabled = true,
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
    },
    experimental = {
        ghost_text = false,
        native_menu = false,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        max_width = 0,
        kind_icons = icons.kind,
        source_names = sourcenames,
        duplicates = duplicates,
        duplicates_default = 0,
        format = function(entry, vim_item)
            local max_width = 0
            if max_width ~= 0 and #vim_item.abbr > max_width then
                vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            vim_item.kind = icons.kind[vim_item.kind]

            if entry.source.name == "copilot" then
                vim_item.kind = icons.git.Octoface
                vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            if entry.source.name == "cmp_tabnine" then
                vim_item.kind = icons.misc.Robot
                vim_item.kind_hl_group = "CmpItemKindTabnine"
            end

            if entry.source.name == "crates" then
                vim_item.kind = icons.misc.Package
                vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            if entry.source.name == "lab.quick_data" then
                vim_item.kind = icons.misc.CircuitBoard
                vim_item.kind_hl_group = "CmpItemKindConstant"
            end

            if entry.source.name == "emoji" then
                vim_item.kind = icons.misc.Smiley
                vim_item.kind_hl_group = "CmpItemKindEmoji"
            end
            vim_item.menu = sourcenames[entry.source.name]
            vim_item.dup = duplicates[entry.source.name] or 0
            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            luasnip.lsp_expand(args.body)
            -- require("snippy").expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        {
            name = "copilot",
            -- keyword_length = 0,
            max_item_count = 3,
            trigger_characters = {
                {
                    ".",
                    ":",
                    "(",
                    "'",
                    "'",
                    "[",
                    ",",
                    "#",
                    "*",
                    "@",
                    "|",
                    "=",
                    "-",
                    "{",
                    "/",
                    "\\",
                    "+",
                    "?",
                    " ",
                    -- '\t',
                    -- '\n',
                },
            },
        },
        --[[ {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
                local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return false
                end
                if kind == "Text" then
                    return false
                end
                return true
            end,
        }, ]]

        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = 'snippy' },
        { name = "ultisnips" },
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "calc" },
        { name = "emoji" },
        { name = "treesitter" },
        { name = "crates" },
        { name = "tmux" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif jumpable(1) then
                luasnip.jump(1)
            elseif has_words_before() then
                -- cmp.complete()
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local confirm_opts = vim.deepcopy(confirmopts) -- avoid mutating the original opts below
                local is_insert_mode = function()
                    return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
                end
                if is_insert_mode() then -- prevent overwriting brackets
                    confirm_opts.behavior = cmp.ConfirmBehavior.Insert
                end
                if cmp.confirm(confirm_opts) then
                    return -- success, exit early
                end
            end
            fallback() -- if not exited early, always fallback
        end),
    }),
    cmdline = {
        enable = false,
        options = {
            {
                type = ":",
                sources = {
                    { name = "path" },
                },
            },
            {
                type = { "/", "?" },
                sources = {
                    { name = "buffer" },
                },
            },
        },
    },
})
