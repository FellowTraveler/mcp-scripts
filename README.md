# mcp-scripts

Portable shell scripts for managing MCP servers in [Claude Code](https://claude.ai/code).

Three commands:

| Command | Purpose |
|---------|---------|
| `mcpadd` | Add one or more MCP servers |
| `mcpremove` | Remove one or more MCP servers |
| `mcplist` | List all available server names |

## Install

Copy the scripts to anywhere on your `PATH` and make them executable:

```sh
git clone https://github.com/FellowTraveler/mcp-scripts.git
cd mcp-scripts
cp mcpadd mcplist mcpremove ~/bin/   # or /usr/local/bin/
chmod +x ~/bin/mcpadd ~/bin/mcplist ~/bin/mcpremove
```

Requires the [Claude Code CLI](https://claude.ai/code) to be installed.

## Usage

```sh
# List available servers
mcplist

# Add servers (default scope: local)
mcpadd Context7
mcpadd sequential-thinking fetch calculator

# Add at a specific scope
mcpadd --scope user brave-search
mcpadd --scope project repowise

# Remove servers
mcpremove fetch
mcpremove --scope user brave-search

# Remove all at local scope
mcpremove --all
```

## Available Servers

| Name | Notes |
|------|-------|
| `Context7` | Up-to-date library docs |
| `sequential-thinking` | Structured reasoning |
| `foundry-mcp-server` | Foundry/Anvil blockchain tools |
| `rust-docs` | Rust crate documentation (auto-cloned, requires Node) |
| `fetch` | HTTP fetch tool |
| `pdf-reader` | Read PDF files |
| `xcode` | Xcode project tools (auto-cloned, requires Node) |
| `perplexity-ask` | Perplexity search — requires `PERPLEXITY_API_KEY` |
| `calculator` | Basic calculator |
| `playwright` | Browser automation |
| `n8n` | n8n workflow automation — requires `N8N_API_KEY` |
| `brave-search` | Brave web search — requires `BRAVE_API_KEY` |
| `mindmap` | Generate mind maps |
| `puppeteer` | Configurable browser automation |
| `tree-sitter-mcp` | Code parsing via tree-sitter |
| `iterm-mcp` | iTerm2 terminal control (macOS) |
| `repowise` | Codebase intelligence — project scope only |
| `cerebra-legal` | Legal reasoning (auto-cloned, requires Node) — project/local scope only |
| `us-legal` | Congress.gov + CourtListener — project/local scope only |

## Configuration

### Clone directory

Servers that have no published package are cloned and built automatically on
first use. They land in `$HOME/src/` by default. Override with:

```sh
export MCP_SRC_DIR="$HOME/your/preferred/dir"
```

Affected servers: `rust-docs`, `xcode`, `cerebra-legal`

### API keys

Add to `~/.zshrc` or `~/.bashrc` as needed:

```sh
export PERPLEXITY_API_KEY="..."   # perplexity-ask
export BRAVE_API_KEY="..."        # brave-search
export N8N_API_KEY="..."          # n8n
export CONGRESS_API_KEY="..."     # us-legal (optional)
export COURT_LISTENER_API_KEY="..." # us-legal (optional)
```

### Puppeteer browser

By default puppeteer launches with `{"headless":false}` and uses your system
browser. To specify a browser:

```sh
export PUPPETEER_ARGS='{"executablePath":"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome","headless":false}'
mcpadd puppeteer
```

### Scopes

Claude Code supports three scopes: `local` (default), `user`, and `project`.

`repowise` always uses `project` scope regardless of `--scope` — it is stored
in `.mcp.json` and shared with the team. On first add it runs `repowise init`,
which indexes the codebase (~25 min, ~$50 in LLM API costs).

`cerebra-legal` and `us-legal` are restricted to `project` or `local` scope.
