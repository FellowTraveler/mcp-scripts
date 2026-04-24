#!/usr/bin/env bash
# Install mcpadd, mcplist, and mcpremove to ~/bin or ~/.local/bin

set -euo pipefail

SCRIPTS=(mcpadd mcplist mcpremove)

# Pick the first destination that exists on PATH
if [[ -d "$HOME/bin" ]]; then
  DEST="$HOME/bin"
elif [[ -d "$HOME/.local/bin" ]]; then
  DEST="$HOME/.local/bin"
else
  echo "Error: neither ~/bin nor ~/.local/bin exists. Create one and add it to your PATH." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in "${SCRIPTS[@]}"; do
  cp "$SCRIPT_DIR/$script" "$DEST/$script"
  chmod +x "$DEST/$script"
  echo "✓ Installed $script → $DEST/$script"
done

echo
echo "All scripts installed to $DEST"
echo "Make sure $DEST is on your PATH."
