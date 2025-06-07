return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		ft = "rust",
		init = function()
			local codelldb = vim.fn.expand("$MASON/packages/codelldb")
			local extension_path = codelldb .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			local cfg = require("rustaceanvim.config")

			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						vim.lsp.inlay_hint.enable(true)
					end,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
							inlayHints = {
								typeHints = {
									enable = true,
									hideAuto = true,
								},
								chainingHints = {
									enable = true,
								},
								parameterHints = {
									enable = true,
								},
								lifetimeElisionHints = {
									enable = true,
									useParameterNames = true,
								},
							},
						},
					},
				},
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
					configurations = {
						launch = {
							console = "integratedTerminal",
							args = function()
								local args_str = vim.fn.input("Enter program arguments: ")
								if args_str == "" then
									return {}
								end
								return vim.split(args_str, " ")
							end,
						},
					},
				},
			}
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
			require("cmp").setup.buffer({
				sources = { { name = "crates" } },
			})
		end,
	},
}
