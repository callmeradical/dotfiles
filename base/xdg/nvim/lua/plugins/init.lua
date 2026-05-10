-- minimal example plugin spec so Lazy has something to load
return {
	{
		"nvim-lua/plenary.nvim",
		"huggingface/llm.nvim",
		opts = {
			backend = "ollama",
			model = "codellama:7b-instruct",
			url = "http://127.0.0.1:11434",
			request_body = {
				options = {
					temperature = 0.2,
					top_p = 0.95,
					num_ctx = 4096,
				},
			},
			enable_suggestions_on_startup = true,
			enable_suggestions_on_files = "*",
		},
	},
}
