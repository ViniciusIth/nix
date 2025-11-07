{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;
  };

  imports = [
  ];
}
# Yes — that’s perfect 👍
# You can absolutely make this work **with your existing `niri/config.kdl`**, and you have **two clean ways** to get `' + c` → `ç` depending on whether you want to modify your layout or just add a Compose rule.
#
# Let’s go through both options specifically for **Niri**.
#
# ---
#
# ## 🩷 **Option 1 — Add a Compose override (recommended, easy)**
#
# Your `us(altgr-intl)` layout already supports *dead keys*, so we can just teach `'` + `c` to become `ç`.
#
# 1. Create (or edit) your `~/.XCompose` file:
#
#    ```bash
#    nano ~/.XCompose
#    ```
#
# 2. Add these lines:
#
#    ```text
#    <dead_acute> <c> : "ç"   Ccedilla
#    <dead_acute> <C> : "Ç"   Ccedilla
#    ```
#
# 3. In your Niri config (`~/.config/niri/config.kdl`), make sure Niri uses that Compose file.
#
#    Update your input section like this:
#
#    ```kdl
#    input {
#        keyboard {
#            xkb {
#                layout "us"
#                variant "altgr-intl"
#                options "ctrl:nocaps"
#                compose-file "~/.XCompose"
#            }
#        }
#    }
#    ```
#
#    > ✅ `compose-file` is the correct key to tell Niri to use a custom XCompose file.
#    > (If you’re on an older Niri build that doesn’t yet support `compose-file`, you can instead set the environment variable below.)
#
# 4. If Niri doesn’t pick it up, set the env var before launching it:
#
#    ```bash
#    export XCOMPOSEFILE="$HOME/.XCompose"
#    niri
#    ```
#
# 5. Restart Niri — now `' + c` → `ç` and `' + C` → `Ç`.
#
# ---
#
# ## 🧠 **Option 2 — Custom XKB layout (only if you want it baked in)**
#
# If you’d rather not depend on Compose files:
#
# * Copy the XKB layout file:
#
#   ```bash
#   sudo cp /usr/share/X11/xkb/symbols/us /usr/share/X11/xkb/symbols/us-custom
#   ```
# * Edit the `"altgr-intl"` section:
#
#   ```xkb
#   key <AB03> { [ c, C, ccedilla, Ccedilla ] };
#   ```
# * Then change your Niri config:
#
#   ```kdl
#   input {
#       keyboard {
#           xkb {
#               layout "us-custom"
#               variant "altgr-intl"
#               options "ctrl:nocaps"
#           }
#       }
#   }
#   ```
#
# ---
#
# ## ✅ **Summary**
#
# | Goal                        | Easiest way                    | What to edit    |
# | --------------------------- | ------------------------------ | --------------- |
# | `' + c` → `ç` (user-only)   | `~/.XCompose` + `compose-file` | No root needed  |
# | `' + c` → `ç` (system-wide) | custom XKB layout              | Root + XKB edit |
#
# ---
#
# So yes — your current Niri config **works great** as a base.
# Just add
#
# ```kdl
# compose-file "~/.XCompose"
# ```
#
# inside the `xkb` block, and create that `~/.XCompose` file — that’s all you need.
#

