return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- Load the palette (example: macchiato)
		local palette = require("catppuccin.palettes").get_palette("mocha")

		-- Setup catppuccin with options
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			integrations = {
				treesitter = true,
				native_lsp = {
					enabled = true,
				},
			},
		})

		-- Apply colorscheme
		vim.cmd.colorscheme("catppuccin")
	end,
}
