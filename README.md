# Vulkanite Theme for GNU Emacs

[![License: GPL-3.0](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Emacs](https://img.shields.io/badge/Emacs-27.1+-purple.svg)](https://www.gnu.org/software/emacs/)

**Vulkanite** is an atmospheric Emacs theme suite offering **26 tailored dark variants**, marrying the rich volcanic palettes of [Omarchy](https://github.com/omarchy) desktop themes with the nuanced aesthetic hierarchy and extensive package face coverage of [Kanagawa](https://github.com/rebelot/kanagawa.nvim).

---

## Features

- **26 Curated Variants:** From deep obsidian blacks and glowing volcanic embers to lush forest greens, cyberpunk neon accents, and soft pastel shades.
- **Omarchy Desktop Auto-Sync:** Built-in watcher that automatically synchronizes your Emacs theme whenever your Omarchy system theme changes in real time.
- **Extensive Package Coverage:** Seamless syntax highlighting and curated faces across dozens of popular packages:
  - **Core & Languages:** Tree-sitter, LSP Mode, Eglot, Flycheck, Flymake, Treesit.
  - **Completion & Navigation:** Vertico, Corfu, Marginalia, Orderless, Ivy, Counsel, Helm, Consult, Which-key, Treemacs.
  - **Version Control:** Magit, Diff-hl, Git-gutter, Smerge, Ediff.
  - **Writing & Notes:** Org Mode (customizable heading scales, bold weights, highlights), Markdown, Outline.
- **Customizable Typography:** Toggles for italicized comments and keywords, org heading scale variations, bold weights, and agenda priority styling.

---

## Available Variants

| Theme Symbol | Theme Name | Accent & Atmosphere |
| :--- | :--- | :--- |
| `vulkanite` / `vulkanite-wave` | Vulkanite Wave | Classic volcanic slate-teal dark palette (`#0f1416`) |
| `vulkanite-dragon` | Vulkanite Dragon | Deep obsidian black with warm fiery ember accents (`#090d0e`) |
| `vulkanite-tycho` | Vulkanite Tycho | Warm charcoal dark with dusty rose, terracotta & lavender mauve (`#1e2125`) |
| `vulkanite-rose-pine-dark` | Rosé Pine Dark | Cozy pine-tinted dark background with soft rose & gold accents |
| `vulkanite-kanagawa` | Kanagawa | Traditional Japanese sumi-e ink washes, autumn maple & spring greens |
| `vulkanite-gruvbox` | Gruvbox | Retro warm dark palette with earthy reddish-brown and golden tones |
| `vulkanite-tokyo-night` | Tokyo Night | Deep indigo nighttime palette with neon violet, magenta & cyan |
| `vulkanite-catppuccin` | Catppuccin Mocha | Soothing pastel accents on a rich mocha slate background |
| `vulkanite-everforest` | Everforest | Calming natural forest green dark theme |
| `vulkanite-one-dark-pro` | One Dark Pro | Iconic Atom-inspired balanced dark theme |
| `vulkanite-aura` | Aura | Deep dark backdrop with glowing ethereal violet and electric teal |
| `vulkanite-batou` | Batou | Tactical cyber-noir dark aesthetic |
| `vulkanite-demon` | Demon | Smoldering crimson, blood orange and scorched obsidian |
| `vulkanite-ethereal` | Ethereal | Dreamy, mystical violet and twilight haze |
| `vulkanite-japan-night` | Japan Night | Neon-lit Tokyo midnight city streets |
| `vulkanite-last-horizon` | Last Horizon | Deep cosmic void with twilight horizon gradients |
| `vulkanite-matrix` | Matrix | Monochromatic phosphorus terminal greens on pure dark |
| `vulkanite-miasma` | Miasma | Foggy olive, swampy greens, and weathered parchment |
| `vulkanite-osaka-jade` | Osaka Jade | Deep serene emerald and jade tones |
| `vulkanite-retro-82` | Retro 82 | Vintage 1982 CRT warm amber and cyan phosphor |
| `vulkanite-solitude` | Solitude | Minimalist monochrome dark with whisper-soft cyan accents |
| `vulkanite-terminus` | Terminus | High-contrast hacker terminal aesthetic |
| `vulkanite-vantablack` | Vantablack | Ultra-deep abyss black (`#000000` / `#050505`) with crisp neon accents |
| `vulkanite-vesper` | Vesper | Moody deep graphite dark with warm amber/candlelight accents |
| `vulkanite-aether` | Aether | Translucent celestial blue and starlight cyan |
| `omarchy-vulkanite` | Omarchy Vulkanite | Direct alias loading the signature Omarchy theme |

---

## Installation

### With `use-package` and `:vc` (Emacs 29+)

```elisp
(use-package vulkanite-theme
  :vc (:fetcher github :repo "Meskour/vulkanite-theme")
  :config
  (load-theme 'vulkanite-wave t))
```

### With `straight.el`

```elisp
(straight-use-package
 '(vulkanite-theme :type git :host github :repo "Meskour/vulkanite-theme"))

(load-theme 'vulkanite-wave t)
```

### With `elpaca`

```elisp
(use-package vulkanite-theme
  :ensure (:host github :repo "Meskour/vulkanite-theme")
  :config
  (load-theme 'vulkanite-wave t))
```

### With Doom Emacs

In `~/.config/doom/packages.el`:
```elisp
(package! vulkanite-theme
  :recipe (:host github :repo "Meskour/vulkanite-theme"))
```

In `~/.config/doom/config.el`:
```elisp
(setq doom-theme 'vulkanite-wave)
```

### Manual Installation

Clone the repository into your preferred directory:
```bash
git clone https://github.com/Meskour/vulkanite-theme-emacs.git ~/.emacs.d/site-lisp/vulkanite-theme
```

Add it to your `init.el`:
```elisp
(add-to-list 'load-path "~/.emacs.d/site-lisp/vulkanite-theme")
(add-to-list 'custom-theme-load-path "~/.emacs.d/site-lisp/vulkanite-theme")

(load-theme 'vulkanite-wave t)
```

---

## Omarchy Desktop Auto-Sync

If you use [Omarchy](https://github.com/omarchy) as your desktop manager or shell environment, Vulkanite can automatically track your desktop theme changes in real time.

Add the following to your configuration:

```elisp
(require 'vulkanite-theme)

;; Sync the theme on Emacs startup
(vulkanite-sync-omarchy-theme)

;; Auto-sync whenever the Omarchy theme switches (e.g. Super+Alt+Space)
(vulkanite-watch-omarchy-theme)
```

By default, Vulkanite reads the active Omarchy theme from:
```elisp
(setq vulkanite-omarchy-theme-name-file "~/.local/state/omarchy/current/theme.name")
```

---

## Configuration

Customize these variables **before** calling `load-theme`:

```elisp
;; Enable or disable italic comments (default: t)
(setq vulkanite-theme-comment-italic t)

;; Enable or disable italic keywords (default: t)
(setq vulkanite-theme-keyword-italic t)

;; Org mode: variable heading heights (default: t)
(setq vulkanite-theme-org-height t)

;; Org mode: bold headings (default: t)
(setq vulkanite-theme-org-bold t)

;; Org mode: bold agenda priority items (default: t)
(setq vulkanite-theme-org-priority-bold t)

;; Org mode: background highlight on headings (default: nil)
(setq vulkanite-theme-org-highlight nil)
```

---

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
