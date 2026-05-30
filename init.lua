vim.g.clipboard="wl-copy"

vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

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
			},

			appearance={
				nerd_font_variant="mono"
			},
			completion={
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
			ensure_installed={"c", "cpp", "lua", "go" },
			highlight = { enable = true },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", },
	},

})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("clangd", {
	cmd= {"clangd", "--query-driver=/nix/store/*/bin*"},
	capabilities = capabilities,
})

vim.lsp.enable("clangd")

-- colorscheme
vim.cmd("colorscheme kanagawa")
