# AI Assistant Setup Guide

AI coding assistance in Neovim via [GWDG SAIA](https://docs.hpc.gwdg.de/services/ai-services/saia/index.html)
using locally-hosted open-weight models. No data leaves GWDG infrastructure.

## Quick Start

```bash
# 1. Set API key
echo 'export SAIA_API_KEY="your-key-here"' >> ~/.bashrc && source ~/.bashrc

# 2. Install plugin
cp ai-assistant.lua ~/.config/nvim/lua/plugins/ai-assistant.lua

# 3. Sync plugins (in neovim)
:Lazy sync
```

---

## Keymap Reference

All AI keymaps use the `<Space>a` prefix.

### Global keymaps (work from any buffer)

| Keymap          | Mode   | Action                                      |
|-----------------|--------|---------------------------------------------|
| `<Space>aa`     | n, v   | Toggle AI chat (vertical split, right side) |
| `<Space>ai`     | n, v   | Inline assistant (edits code in place)      |
| `<Space>ap`     | n, v   | Action palette (telescope picker)           |
| `<Space>ar`     | n      | New chat with reasoning model               |
| `<Space>al`     | n      | New chat with large model                   |
| `ga`            | v      | Add visual selection to chat as context     |

### Chat buffer keymaps (only inside the chat window)

Press `?` in the chat buffer to see the full list. Key ones:

| Keymap          | Mode   | Action                                      |
|-----------------|--------|---------------------------------------------|
| `<CR>`          | n      | Send message                                |
| `<C-s>`         | n, i   | Send message                                |
| `<C-c>`         | n, i   | Close chat                                  |
| `q`             | n      | Stop current generation                     |
| `<Space>am`     | n      | Switch adapter or model                     |
| `?`             | n      | Show all chat keymaps                       |
| `gd`            | n      | Open debug window (view/edit message history) |

### Command-line shortcut

Type `:cc` followed by a prompt to use the inline assistant directly:

```
:cc add OpenMP parallelization to the outer loop
:'<,'>cc explain this code
:'<,'>cc /explain
```

---

## Three Adapters

| Adapter        | Default Model                      | Context | Best for                          |
|----------------|------------------------------------|---------|------------------------------------|
| `gwdg_coder`   | `qwen3-coder-30b-a3b-instruct`    | 256k    | Daily C++ coding, boilerplate, tests |
| `gwdg_reason`  | `qwen3-235b-a22b`                 | 222k    | Deep reasoning, equation review    |
| `gwdg_large`   | `mistral-large-3-675b-instruct`   | 256k    | Complex multi-file refactoring     |

`gwdg_coder` is the default for all interactions. Switch to others via
`<Space>ar` / `<Space>al`, or change adapter mid-chat with `<Space>am`.

Each adapter also has alternative models you can select from the model picker.

---

## How Tokens and Limits Work

### What are tokens?

Tokens are the units that LLMs process. Roughly 1 token ≈ 4 characters in
English. A 100-line C++ file is typically 1,500–3,000 tokens. Each model
has a context window (the total tokens it can handle in a single request):

| Model                              | Context Window |
|------------------------------------|----------------|
| `qwen3-coder-30b-a3b-instruct`    | 256k tokens    |
| `qwen3-235b-a22b`                 | 222k tokens    |
| `mistral-large-3-675b-instruct`   | 256k tokens    |

The context window includes everything: your system prompt, the entire
conversation history, any code you've shared via `ga` or `#buffer`,
and the model's response.

### GWDG rate limits

GWDG limits are **per-request**, not per-token:

| Window   | Limit           |
|----------|-----------------|
| Per minute | 1,000 requests |
| Per hour   | 10,000 requests |
| Per day    | 50,000 requests |

Each message you send in a chat counts as one request. Each inline
assistant invocation counts as one request. These limits are generous
for interactive use.

### What happens when I close and reopen a chat?

**Toggle** (`<Space>aa`): The chat buffer is hidden but preserved. Reopening
restores the full conversation. Token usage continues from where you left
off — the full history is sent with each new message.

**New chat** (`:CodeCompanionChat`): Creates a fresh chat with zero history.
Token usage starts from scratch.

**Inline assistant** (`<Space>ai`): Each invocation is an independent
request. It sends only the current buffer context and your prompt — no
conversation history. Tokens are not accumulated between calls.

### Token count display

Token usage is shown in the chat buffer header after each response. This
helps you track how much of the context window you've consumed. When you
approach the limit, start a new chat to reset.

---

## Chat Panel Appearance

The chat panel has a slightly darkened background compared to your code
buffers, making it visually distinct. This is achieved by a custom
highlight group (`CodeCompanionChatBg`) that adapts to your tokyonight
colorscheme.

If you want to adjust the dimming, find this line in `ai-assistant.lua`:

```lua
local dark_bg = darken(bg, 0.85)
```

Lower values (e.g. `0.75`) make the background darker. Higher values
(e.g. `0.95`) make it closer to your normal background.

---

## Typical Workflows

### Explain generated code

1. Open a generated C++ file
2. Select the function with `V` and `j`/`k`
3. Press `ga` to add it to the chat
4. Type: "Walk me through this contraction sequence. Which terms
   correspond to the T2*T2 nonlinear contributions?"

### Fix a compilation error

1. Navigate to the diagnostic with `en`
2. Press `<Space>ap` to open the action palette
3. Select "Explain LSP Diagnostics" — it auto-includes the error

### Refactor code inline

1. Select the code region with `V`
2. Press `<Space>ai`
3. Type: "Add OpenMP parallelization to the outer loop over occupied
   pairs. Use collapse(2) for the ij loop."
4. Review the changes in your buffer — undo with `u` if needed

### Design a method specification schema

1. Press `<Space>ar` to open a chat with the reasoning model
2. Describe your method and iterate on the design

### Compare approaches

1. Open chat with `<Space>aa`
2. Paste relevant code with `ga` from different files
3. Ask: "Compare the memory access patterns of these two implementations.
   Which is more cache-friendly for the PNO pair iteration?"

---

## Troubleshooting

**No response from model**

```bash
# Test the API directly
curl -s https://chat-ai.academiccloud.de/v1/models \
  -H "Authorization: Bearer $SAIA_API_KEY" | head -20
```

**Plugin errors**

```vim
:checkhealth codecompanion
```

**Enable debug logging**

In `ai-assistant.lua`, change `log_level = "ERROR"` to `"DEBUG"`, then
check the log path shown by `:checkhealth codecompanion`.
