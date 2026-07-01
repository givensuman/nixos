return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = true },
      },
      appearance = {
        kind_icons = {
          Minuet = " ",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 8,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_name = "Minuet"
              end
              return items
            end,
          },
        },
      },
    },
  },
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      provider = "openai_compatible",
      request_timeout = 2.5,
      throttle = 1500,
      debounce = 600,
      provider_options = {
        openai_compatible = {
          api_key = "OPENCODE_API_KEY",
          end_point = "https://opencode.ai/zen/go/v1/chat/completions",
          model = "deepseek-v4-flash",
          name = "Opencode",
          optional = {
            max_tokens = 56,
            top_p = 0.9,
            thinking = { type = "disabled" },
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = {
          "TelescopePrompt",
          "snacks_picker",
          "help",
          "qf",
          "lazy",
          "mason",
          "noice",
        },
        show_on_completion_menu = false,
        keymap = {
          accept = "<M-l>",
          accept_line = "<M-k>",
          accept_n_lines = "<M-j>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-h>",
        },
      },
    },
  },
}
