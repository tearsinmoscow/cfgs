vim.g.clipboard="wl-copy"

vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then 
	local repo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system( {"git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath } )
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{"Failed: ", "ErrorMsg"},
			{out},
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
vim.api.nvim_command("set relativenumber")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

require("lazy").setup({
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"echasnovski/mini.pairs", opts = {}
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version="*",
		opts = {
			signature={ enabled = true, },
			keymap={
				preset="default",
				["<CR>"] = { "accept", "fallback" },
			},

			appearance={
				nerd_font_variant="mono"
			},
			completion={
				list = {
					selection= {
						preselect=true,
						auto_insert=false,
					},
				},
				documentation={
					auto_show=true,
				},
			},

			sources = {
				default={"lsp", "path", "snippets", "buffer"},
			},

			fuzzy = {
				implementation="prefer_rust_with_warning",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch="master",
		build=":TSUpdate",
		opts= {
			ensure_installed={"c", "cpp", "lua", "go", "rust", "python" },
			highlight = { enable = true },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", },
	},

})

-- lsp setup
vim.lsp.enable("clangd")
vim.lsp.enable('rust_analyzer')

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer", },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true, },
			imports = {
				granularity = {
					group = "module",
				},
				prefix="self",
			},
			checkOnSave = true,
		},
	},
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("clangd", {
	cmd= {"clangd", "--query-driver=/nix/store/*mingw*/bin/x86_64-w64-mingw32-g++,/nix/store/*gcc*/bin/g++"},
	capabilities = capabilities,
})


-- colorscheme
vim.cmd("colorscheme kanagawa")
