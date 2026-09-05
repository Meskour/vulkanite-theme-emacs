;;; vulkanite-theme.el --- Vulkanite theme triad inspired by Kanagawa -*- lexical-binding: t -*-

;; Copyright (C) 2026
;; Author: Mohamed Meskour
;; Keywords: themes faces
;; Version: 1.1.0

;;; Commentary:

;; Vulkanite is an atmospheric theme suite inspired by the volcanic palette of
;; Vulkanite / Omarchy and styled with the aesthetic balance and extensive face
;; coverage of Kanagawa Wave, Dragon, and Lotus.
;;
;; Available variants:
;; - vulkanite / vulkanite-wave: Classic volcanic slate-teal dark theme (#0f1416)
;; - vulkanite-dragon: Deep obsidian black with warm fiery ember accents (#090d0e)
;; - vulkanite-magma: Warm volcanic basalt dark theme with glowing molten lava accents (#121014)

;;; Code:

(defgroup vulkanite-theme nil
  "Vulkanite theme options."
  :group 'faces)

(defcustom vulkanite-theme-comment-italic t
  "Enable italics for comments."
  :type 'boolean
  :group 'vulkanite-theme)

(defcustom vulkanite-theme-keyword-italic t
  "Enable italics for keywords."
  :type 'boolean
  :group 'vulkanite-theme)

(defcustom vulkanite-theme-org-height t
  "Use varying text heights for org headings."
  :type 'boolean
  :group 'vulkanite-theme)

(defcustom vulkanite-theme-org-bold t
  "Inherit bold weight for org headings."
  :type 'boolean
  :group 'vulkanite-theme)

(defcustom vulkanite-theme-org-priority-bold t
  "Inherit bold weight for priority items in agenda view."
  :type 'boolean
  :group 'vulkanite-theme)

(defcustom vulkanite-theme-org-highlight nil
  "Highlight org headings with background tint."
  :type 'boolean
  :group 'vulkanite-theme)

(defun vulkanite--darken-hex (hex percent)
  "Darken HEX color string (e.g. \"#18181A\") by PERCENT (e.g. 10)."
  (if (and (stringp hex)
           (string-prefix-p "#" hex)
           (= (length hex) 7))
      (let* ((r (string-to-number (substring hex 1 3) 16))
             (g (string-to-number (substring hex 3 5) 16))
             (b (string-to-number (substring hex 5 7) 16))
             (factor (- 1.0 (/ (float percent) 100.0)))
             (dr (max 0 (min 255 (round (* r factor)))))
             (dg (max 0 (min 255 (round (* g factor)))))
             (db (max 0 (min 255 (round (* b factor))))))
        (format "#%02x%02x%02x" dr dg db))
    hex))

(defun vulkanite-theme-apply (theme-name &optional variant)
  "Apply Vulkanite face specifications to THEME-NAME according to VARIANT.
VARIANT can be `wave' (default), `dragon', `aether', `tycho',
`aura', `batou', `demon', `japan-night', `matrix', `one-dark-pro',
`rose-pine-dark', `terminus', `vantablack', `vesper', `catppuccin',
`ethereal', `everforest', `gruvbox', `kanagawa', `last-horizon',
`miasma', `osaka-jade', `retro-82', `solitude', or `tokyo-night'."
  (let* ((variant (or variant 'wave))
         (colors
          (pcase variant
            ('tycho
             ;; Omarchy Tycho: warm charcoal dark with dusty rose & terracotta
             ;; Palette sourced directly from ~/.config/omarchy/themes/tycho
             '((fuji-white      . "#f0e9ec") ; fg  (color15 — warm near-white)
               (old-white       . "#c5aeb9") ; fg-dim (color7 — dusty rose grey)
               (fuji-gray       . "#897981") ; syn-comment (color8 — warm grey)
               (katana-gray     . "#6b5f67") ; border-light / dim (mid rose-grey)
               (sumi-ink-0      . "#181c1f") ; bg-dim / bg-m3 (darker than bg)
               (sumi-ink-1      . "#1e2125") ; bg (color0 — warm charcoal)
               (sumi-ink-2      . "#252a2e") ; bg-m1 / bg-p1 (modeline)
               (sumi-ink-3      . "#2d3237") ; bg-p2 (hl-line)
               (sumi-ink-4      . "#353b41") ; bg-gutter / divider
               (sumi-ink-5      . "#474f57") ; border / visual selection
               (wave-blue-1     . "#2e2830") ; bg-visual (warm plum selection)
               (wave-blue-2     . "#3a3240") ; bg-search
               (crystal-blue    . "#a5a1b2") ; syn-fun (color14 cyan — dusty lavender)
               (spring-blue     . "#9b826b") ; syn-type (color4 blue — warm tan)
               (wave-aqua-1     . "#976870") ; syn-keyword (color1 red — rose)
               (wave-aqua-2     . "#b48162") ; syn-operator (color5 magenta — toffee)
               (spring-green    . "#b4756b") ; syn-string (color2 green — muted brick)
               (winter-green    . "#2a2820") ; diff-add bg
               (carp-yellow     . "#c17a6a") ; syn-param / warn (color3 yellow — terracotta)
               (ronin-yellow    . "#dfbab2") ; diag-warning (color11 — pale salmon)
               (sakura-pink     . "#c1a4a9") ; syn-number (color9 — dusty rose)
               (winter-red      . "#2e1f21") ; diff-delete bg
               (samurai-red     . "#976870") ; diag-error (color1 rose-red)
               (spring-violet-1 . "#d5b8a7") ; syn-constant (color13 — warm beige)
               (winter-blue     . "#1f2029") ; diff-change bg
               (winter-yellow   . "#2c2820")))
             ('dragon
             ;; Deeper obsidian black, warm ash grey, fiery magma ember accents
             '((fuji-white      . "#c9d3d7") ; fg (ash slate grey)
               (old-white       . "#98a3a7") ; fg-dim
               (fuji-gray       . "#6f7a7e") ; syn-comment (ash grey)
               (katana-gray     . "#556064") ; border-light / dim
               (sumi-ink-0      . "#06090a") ; bg-dim / bg-m3 (deep obsidian)
               (sumi-ink-1      . "#090d0e") ; bg (volcanic obsidian black)
               (sumi-ink-2      . "#0f1517") ; bg-m1 / bg-p1
               (sumi-ink-3      . "#1a2428") ; bg-p2 (hl-line)
               (sumi-ink-4      . "#1e292e") ; bg-gutter / divider
               (sumi-ink-5      . "#303e44") ; border / visual
               (wave-blue-1     . "#1c333e") ; bg-visual (selection)
               (wave-blue-2     . "#264452") ; bg-search
               (crystal-blue    . "#7ec8e3") ; syn-fun (ice cyan)
               (spring-blue     . "#8ea4a2") ; syn-type (mineral sage aqua)
               (wave-aqua-1     . "#c4746e") ; syn-keyword (ember rust red)
               (wave-aqua-2     . "#e07a5f") ; syn-operator (ember orange)
               (spring-green    . "#8da678") ; syn-string (moss green)
               (winter-green    . "#1f3826") ; diff-add
               (carp-yellow     . "#c4b28a") ; syn-param / warn brass
               (ronin-yellow    . "#c4b28a") ; diag-warning
               (sakura-pink     . "#e05f64") ; syn-number (fiery coral)
               (winter-red      . "#3e1e21") ; diff-delete
               (samurai-red     . "#e03f32") ; diag-error
               (spring-violet-1 . "#e0af68") ; syn-constant (amber ember)
               (winter-blue     . "#192c3d") ; diff-change
               (winter-yellow   . "#423722")))
            ('aether
             ;; High-contrast aether: void-black bg, electric neon accents
             '((fuji-white      . "#f0f4ff") ; fg (near-white with cool blue tint)
               (old-white       . "#b8c4d4") ; fg-dim (cool steel)
               (fuji-gray       . "#6a7a92") ; syn-comment (muted blue-grey)
               (katana-gray     . "#3d4f64") ; border-light / dim
               (sumi-ink-0      . "#040609") ; bg-dim / bg-m3 (absolute void)
               (sumi-ink-1      . "#080a0d") ; bg (deep space black)
               (sumi-ink-2      . "#0e1219") ; bg-m1 / bg-p1 (modeline)
               (sumi-ink-3      . "#141c27") ; bg-p2 (hl-line) - clear step up
               (sumi-ink-4      . "#1a2535") ; bg-gutter / divider
               (sumi-ink-5      . "#243040") ; border / visual
               (wave-blue-1     . "#0f2140") ; bg-visual (deep electric selection)
               (wave-blue-2     . "#163255") ; bg-search
               (crystal-blue    . "#00d9ff") ; syn-fun (electric cyan - max contrast)
               (spring-blue     . "#7eb8ff") ; syn-type (bright periwinkle blue)
               (wave-aqua-1     . "#c792ea") ; syn-keyword (vivid violet)
               (wave-aqua-2     . "#89ddff") ; syn-operator (icy neon blue)
               (spring-green    . "#c3e88d") ; syn-string (bright lime-mint)
               (winter-green    . "#0d2e16") ; diff-add
               (carp-yellow     . "#ffcb6b") ; syn-param / warn (vivid gold)
               (ronin-yellow    . "#ffcb6b") ; diag-warning
               (sakura-pink     . "#ff79c6") ; syn-number (neon pink)
               (winter-red      . "#2e0d15") ; diff-delete
               (samurai-red     . "#ff5370") ; diag-error (hot coral)
               (spring-violet-1 . "#ff9cac") ; syn-constant (bright rose)
               (winter-blue     . "#0c1f3d") ; diff-change
               (winter-yellow   . "#2e2400")))
             ('vantablack
              ;; Omarchy Vantablack: pure black void with white-on-black monochrome
              '((fuji-white      . "#ffffff") ; fg  (pure white)
                (old-white       . "#ececec") ; fg-dim (light foreground)
                (fuji-gray       . "#505050") ; syn-comment (dark foreground)
                (katana-gray     . "#3a3a3a") ; border-light
                (sumi-ink-0      . "#070707") ; bg-dim
                (sumi-ink-1      . "#000000") ; bg (absolute black)
                (sumi-ink-2      . "#0d0d0d") ; bg-m1
                (sumi-ink-3      . "#151515") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#1a1a1a") ; bg-gutter
                (sumi-ink-5      . "#262626") ; border
                (wave-blue-1     . "#1a1a1a") ; bg-visual
                (wave-blue-2     . "#222222") ; bg-search
                (crystal-blue    . "#b0b0b0") ; syn-fun  (mid grey)
                (spring-blue     . "#9b9b9b") ; syn-type (medium grey)
                (wave-aqua-1     . "#a4a4a4") ; syn-keyword (grey red)
                (wave-aqua-2     . "#b9b9b9") ; syn-operator (grey orange)
                (spring-green    . "#b6b6b6") ; syn-string (grey green)
                (winter-green    . "#0d1a0d") ; diff-add
                (carp-yellow     . "#cecece") ; syn-param / warn
                (ronin-yellow    . "#cecece") ; diag-warning
                (sakura-pink     . "#8d8d8d") ; syn-number (accent)
                (winter-red      . "#1a0d0d") ; diff-delete
                (samurai-red     . "#a4a4a4") ; diag-error
                (spring-violet-1 . "#c8c8c8") ; syn-constant
                (winter-blue     . "#0d0d1a") ; diff-change
                (winter-yellow   . "#1a1a00")))
             ('vesper
              ;; Omarchy Vesper: pure near-black with peachy-salmon pastel accents
              '((fuji-white      . "#ffffff") ; fg  (pure white)
                (old-white       . "#a0a0a0") ; fg-dim
                (fuji-gray       . "#7e7e7e") ; syn-comment (dim black)
                (katana-gray     . "#5a5a5a") ; border-light
                (sumi-ink-0      . "#080808") ; bg-dim
                (sumi-ink-1      . "#101010") ; bg (near-black)
                (sumi-ink-2      . "#181818") ; bg-m1
                (sumi-ink-3      . "#202020") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#2a2a2a") ; bg-gutter
                (sumi-ink-5      . "#383838") ; border
                (wave-blue-1     . "#1e1a18") ; bg-visual (warm dark selection)
                (wave-blue-2     . "#281e16") ; bg-search
                (crystal-blue    . "#ea83a5") ; syn-fun  (cyan → hot pink)
                (spring-blue     . "#aca1cf") ; syn-type (periwinkle blue)
                (wave-aqua-1     . "#f5a191") ; syn-keyword (peach red)
                (wave-aqua-2     . "#e6b99d") ; syn-operator (soft orange)
                (spring-green    . "#90b99f") ; syn-string (sage green)
                (winter-green    . "#121e14") ; diff-add
                (carp-yellow     . "#ffc799") ; syn-param / warn
                (ronin-yellow    . "#ffc799") ; diag-warning
                (sakura-pink     . "#e29eca") ; syn-number (magenta pink)
                (winter-red      . "#201010") ; diff-delete
                (samurai-red     . "#ff8080") ; diag-error
                (spring-violet-1 . "#b9aeda") ; syn-constant (lavender blue)
                (winter-blue     . "#10101e") ; diff-change
                (winter-yellow   . "#1e1800")))
             ('catppuccin
              ;; Omarchy Catppuccin Mocha: cool purple-dark with pastel rainbow
              '((fuji-white      . "#cdd6f4") ; fg  (text)
                (old-white       . "#bac2de") ; fg-dim (subtext1)
                (fuji-gray       . "#6c7086") ; syn-comment (overlay0)
                (katana-gray     . "#585b70") ; border-light (surface2)
                (sumi-ink-0      . "#101019") ; bg-dim (darker_background)
                (sumi-ink-1      . "#1e1e2e") ; bg (base)
                (sumi-ink-2      . "#181825") ; bg-m1 (mantle)
                (sumi-ink-3      . "#313244") ; bg-p2 (hl-line / surface0)
                (sumi-ink-4      . "#45475a") ; bg-gutter (surface1)
                (sumi-ink-5      . "#585b70") ; border (surface2)
                (wave-blue-1     . "#45475a") ; bg-visual (selection)
                (wave-blue-2     . "#585b70") ; bg-search
                (crystal-blue    . "#89b4fa") ; syn-fun  (blue)
                (spring-blue     . "#94e2d5") ; syn-type (teal)
                (wave-aqua-1     . "#cba6f7") ; syn-keyword (mauve)
                (wave-aqua-2     . "#89dceb") ; syn-operator (sky)
                (spring-green    . "#a6e3a1") ; syn-string (green)
                (winter-green    . "#1a2e1a") ; diff-add
                (carp-yellow     . "#f9e2af") ; syn-param / warn (yellow)
                (ronin-yellow    . "#f9e2af") ; diag-warning
                (sakura-pink     . "#f38ba8") ; syn-number (red)
                (winter-red      . "#2e1a1e") ; diff-delete
                (samurai-red     . "#f38ba8") ; diag-error
                (spring-violet-1 . "#fab387") ; syn-constant (peach)
                (winter-blue     . "#161628") ; diff-change
                (winter-yellow   . "#2a2210")))
             ('ethereal
              ;; Omarchy Ethereal: deep midnight blue with warm peach/apricot glow
              '((fuji-white      . "#ffcead") ; fg  (warm apricot)
                (old-white       . "#c9b8a6") ; fg-dim
                (fuji-gray       . "#6d7db6") ; syn-comment (muted blue)
                (katana-gray     . "#3d4d86") ; border-light
                (sumi-ink-0      . "#030610") ; bg-dim
                (sumi-ink-1      . "#060B1E") ; bg (deep space midnight)
                (sumi-ink-2      . "#0c1230") ; bg-m1
                (sumi-ink-3      . "#131a3a") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#1a2248") ; bg-gutter
                (sumi-ink-5      . "#252e56") ; border
                (wave-blue-1     . "#0d1535") ; bg-visual
                (wave-blue-2     . "#141e48") ; bg-search
                (crystal-blue    . "#a3bfd1") ; syn-fun  (soft ice blue)
                (spring-blue     . "#7d82d9") ; syn-type (indigo blue)
                (wave-aqua-1     . "#c89dc1") ; syn-keyword (mauve)
                (wave-aqua-2     . "#c2c4f0") ; syn-operator (periwinkle)
                (spring-green    . "#92a593") ; syn-string (sage)
                (winter-green    . "#0d1e10") ; diff-add
                (carp-yellow     . "#E9BB4F") ; syn-param / warn (gold)
                (ronin-yellow    . "#f7dc9c") ; diag-warning (pale gold)
                (sakura-pink     . "#ED5B5A") ; syn-number (coral red)
                (winter-red      . "#200a0a") ; diff-delete
                (samurai-red     . "#faaaa9") ; diag-error (pale coral)
                (spring-violet-1 . "#ead7e7") ; syn-constant (pale mauve)
                (winter-blue     . "#060e28") ; diff-change
                (winter-yellow   . "#1c1400")))
             ('everforest
              ;; Omarchy Everforest: warm forest green-grey dark theme
              '((fuji-white      . "#d3c6aa") ; fg  (warm parchment)
                (old-white       . "#9da9a0") ; fg-dim (muted grey-green)
                (fuji-gray       . "#475258") ; syn-comment (muted)
                (katana-gray     . "#3d484d") ; border-light
                (sumi-ink-0      . "#181d20") ; bg-dim
                (sumi-ink-1      . "#2d353b") ; bg (hard dark)
                (sumi-ink-2      . "#232a2f") ; bg-m1
                (sumi-ink-3      . "#343f44") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#3d484d") ; bg-gutter
                (sumi-ink-5      . "#475258") ; border
                (wave-blue-1     . "#3d484d") ; bg-visual
                (wave-blue-2     . "#475258") ; bg-search
                (crystal-blue    . "#7fbbb3") ; syn-fun  (blue)
                (spring-blue     . "#83c092") ; syn-type (aqua)
                (wave-aqua-1     . "#a7c080") ; syn-keyword (green)
                (wave-aqua-2     . "#7fbbb3") ; syn-operator (blue)
                (spring-green    . "#a7c080") ; syn-string (green)
                (winter-green    . "#1e2a1e") ; diff-add
                (carp-yellow     . "#dbbc7f") ; syn-param / warn (yellow)
                (ronin-yellow    . "#dbbc7f") ; diag-warning
                (sakura-pink     . "#e67e80") ; syn-number (red)
                (winter-red      . "#2a1a1a") ; diff-delete
                (samurai-red     . "#e67e80") ; diag-error
                (spring-violet-1 . "#d699b6") ; syn-constant (pink)
                (winter-blue     . "#1a2230") ; diff-change
                (winter-yellow   . "#2a2010")))
             ('gruvbox
              ;; Omarchy Gruvbox: warm retro dark with earthy yellows and reds
              '((fuji-white      . "#d4be98") ; fg  (warm parchment)
                (old-white       . "#bdae93") ; fg-dim
                (fuji-gray       . "#7c6f64") ; syn-comment
                (katana-gray     . "#504945") ; border-light
                (sumi-ink-0      . "#161616") ; bg-dim
                (sumi-ink-1      . "#282828") ; bg (dark hard)
                (sumi-ink-2      . "#1e1e1e") ; bg-m1
                (sumi-ink-3      . "#3c3836") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#504945") ; bg-gutter
                (sumi-ink-5      . "#665c54") ; border
                (wave-blue-1     . "#3c3836") ; bg-visual
                (wave-blue-2     . "#504945") ; bg-search
                (crystal-blue    . "#7daea3") ; syn-fun  (blue/aqua)
                (spring-blue     . "#89b482") ; syn-type (green)
                (wave-aqua-1     . "#d3869b") ; syn-keyword (pink/purple)
                (wave-aqua-2     . "#7daea3") ; syn-operator (blue)
                (spring-green    . "#a9b665") ; syn-string (green)
                (winter-green    . "#1e2410") ; diff-add
                (carp-yellow     . "#d8a657") ; syn-param / warn (yellow)
                (ronin-yellow    . "#d8a657") ; diag-warning
                (sakura-pink     . "#ea6962") ; syn-number (red)
                (winter-red      . "#2a1410") ; diff-delete
                (samurai-red     . "#ea6962") ; diag-error
                (spring-violet-1 . "#e1875c") ; syn-constant (orange)
                (winter-blue     . "#101820") ; diff-change
                (winter-yellow   . "#2a1c08")))
             ('kanagawa
              ;; Omarchy Kanagawa Wave: ink black with samurai palette
              '((fuji-white      . "#dcd7ba") ; fg  (fuji white)
                (old-white       . "#c8c093") ; fg-dim (old white)
                (fuji-gray       . "#727169") ; syn-comment
                (katana-gray     . "#54546D") ; border-light
                (sumi-ink-0      . "#111116") ; bg-dim
                (sumi-ink-1      . "#1f1f28") ; bg (sumi ink)
                (sumi-ink-2      . "#17171e") ; bg-m1
                (sumi-ink-3      . "#363646") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#2a2a3a") ; bg-gutter
                (sumi-ink-5      . "#54546D") ; border
                (wave-blue-1     . "#2d4f67") ; bg-visual (wave blue)
                (wave-blue-2     . "#223249") ; bg-search
                (crystal-blue    . "#7fb4ca") ; syn-fun  (spring blue)
                (spring-blue     . "#7e9cd8") ; syn-type (crystal blue)
                (wave-aqua-1     . "#6a9589") ; syn-keyword (wave aqua 1)
                (wave-aqua-2     . "#7aa89f") ; syn-operator (wave aqua 2)
                (spring-green    . "#98bb6c") ; syn-string (spring green)
                (winter-green    . "#1e2e1a") ; diff-add
                (carp-yellow     . "#e6c384") ; syn-param / warn (carp yellow)
                (ronin-yellow    . "#c0a36e") ; diag-warning
                (sakura-pink     . "#e82424") ; syn-number (samurai red)
                (winter-red      . "#2a1010") ; diff-delete
                (samurai-red     . "#e82424") ; diag-error
                (spring-violet-1 . "#938aa9") ; syn-constant (spring violet)
                (winter-blue     . "#1c2a3a") ; diff-change
                (winter-yellow   . "#2a2010")))
             ('last-horizon
              ;; Omarchy Last Horizon: pitch black with dusty rose & steel-blue
              '((fuji-white      . "#FAFCFB") ; fg  (near white)
                (old-white       . "#cfd3cd") ; fg-dim
                (fuji-gray       . "#584e51") ; syn-comment (dark warm grey)
                (katana-gray     . "#3e3840") ; border-light
                (sumi-ink-0      . "#060606") ; bg-dim
                (sumi-ink-1      . "#0c0b0c") ; bg (near absolute black)
                (sumi-ink-2      . "#121012") ; bg-m1
                (sumi-ink-3      . "#1a181a") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#222022") ; bg-gutter
                (sumi-ink-5      . "#2e2a2e") ; border
                (wave-blue-1     . "#1a1618") ; bg-visual
                (wave-blue-2     . "#221e22") ; bg-search
                (crystal-blue    . "#c4d8e2") ; syn-fun  (pale blue)
                (spring-blue     . "#a5a0b6") ; syn-type (steel lavender)
                (wave-aqua-1     . "#87a9b0") ; syn-keyword (dusty teal)
                (wave-aqua-2     . "#b59790") ; syn-operator (dusty rose)
                (spring-green    . "#87a9b0") ; syn-string (teal)
                (winter-green    . "#0a1612") ; diff-add
                (carp-yellow     . "#6B5E73") ; syn-param / warn (plum)
                (ronin-yellow    . "#6B5E73") ; diag-warning
                (sakura-pink     . "#c38b7b") ; syn-number (dusty coral)
                (winter-red      . "#1a0c0a") ; diff-delete
                (samurai-red     . "#c38b7b") ; diag-error
                (spring-violet-1 . "#e2dddc") ; syn-constant (warm white)
                (winter-blue     . "#0c0c1a") ; diff-change
                (winter-yellow   . "#181214")))
             ('miasma
              ;; Omarchy Miasma: dark charcoal with olive-muted organic tones
              '((fuji-white      . "#c2c2b0") ; fg  (warm khaki white)
                (old-white       . "#8a8a7e") ; fg-dim
                (fuji-gray       . "#555555") ; syn-comment
                (katana-gray     . "#454545") ; border-light
                (sumi-ink-0      . "#121212") ; bg-dim
                (sumi-ink-1      . "#222222") ; bg (dark charcoal)
                (sumi-ink-2      . "#191919") ; bg-m1
                (sumi-ink-3      . "#2c2c2c") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#383838") ; bg-gutter
                (sumi-ink-5      . "#444444") ; border
                (wave-blue-1     . "#282420") ; bg-visual (warm dark)
                (wave-blue-2     . "#302a20") ; bg-search
                (crystal-blue    . "#78824b") ; syn-fun  (olive green accent)
                (spring-blue     . "#5f875f") ; syn-type (forest green)
                (wave-aqua-1     . "#bb7744") ; syn-keyword (rust orange)
                (wave-aqua-2     . "#b36d43") ; syn-operator (amber orange)
                (spring-green    . "#5f875f") ; syn-string (muted green)
                (winter-green    . "#141e10") ; diff-add
                (carp-yellow     . "#c9a554") ; syn-param / warn (warm gold)
                (ronin-yellow    . "#c9a554") ; diag-warning
                (sakura-pink     . "#685742") ; syn-number (dark khaki)
                (winter-red      . "#221610") ; diff-delete
                (samurai-red     . "#bb7744") ; diag-error
                (spring-violet-1 . "#8d6242") ; syn-constant (warm brown)
                (winter-blue     . "#141414") ; diff-change
                (winter-yellow   . "#1c1800")))
             ('osaka-jade
              ;; Omarchy Osaka Jade: deep forest-night with jade & citron accents
              '((fuji-white      . "#F7E8B2") ; fg  (warm gold-white)
                (old-white       . "#D6D5BC") ; fg-dim (warm grey)
                (fuji-gray       . "#81B8A8") ; syn-comment (teal-grey)
                (katana-gray     . "#53685B") ; border-light (forest muted)
                (sumi-ink-0      . "#090f0d") ; bg-dim
                (sumi-ink-1      . "#111c18") ; bg (deep forest night)
                (sumi-ink-2      . "#0c1512") ; bg-m1
                (sumi-ink-3      . "#23372B") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#2a4030") ; bg-gutter
                (sumi-ink-5      . "#32473B") ; border
                (wave-blue-1     . "#1a3028") ; bg-visual
                (wave-blue-2     . "#203a30") ; bg-search
                (crystal-blue    . "#2DD5B7") ; syn-fun  (vivid teal)
                (spring-blue     . "#ACD4CF") ; syn-type (pale teal)
                (wave-aqua-1     . "#509475") ; syn-keyword (jade green)
                (wave-aqua-2     . "#8CD3CB") ; syn-operator (soft cyan)
                (spring-green    . "#63b07a") ; syn-string (emerald)
                (winter-green    . "#0e2016") ; diff-add
                (carp-yellow     . "#E5C736") ; syn-param / warn (vivid citron)
                (ronin-yellow    . "#E5C736") ; diag-warning
                (sakura-pink     . "#D2689C") ; syn-number (magenta)
                (winter-red      . "#1e0c10") ; diff-delete
                (samurai-red     . "#FF5345") ; diag-error (vivid red)
                (spring-violet-1 . "#75bbb3") ; syn-constant (pale teal)
                (winter-blue     . "#0a1c14") ; diff-change
                (winter-yellow   . "#1e1c00")))
             ('retro-82
              ;; Omarchy Retro-82: deep navy with synthwave orange and teal
              '((fuji-white      . "#f6dcac") ; fg  (warm cream)
                (old-white       . "#a7c9c6") ; fg-dim (light teal)
                (fuji-gray       . "#3f8f8a") ; syn-comment (dark teal)
                (katana-gray     . "#2a6b78") ; border-light
                (sumi-ink-0      . "#020c17") ; bg-dim
                (sumi-ink-1      . "#05182e") ; bg (deep retro navy)
                (sumi-ink-2      . "#031222") ; bg-m1
                (sumi-ink-3      . "#0a2540") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#0f2e50") ; bg-gutter
                (sumi-ink-5      . "#134e5a") ; border
                (wave-blue-1     . "#072040") ; bg-visual
                (wave-blue-2     . "#0a2a50") ; bg-search
                (crystal-blue    . "#8cbfb8") ; syn-fun  (pale teal)
                (spring-blue     . "#028391") ; syn-type (deep cyan)
                (wave-aqua-1     . "#faa968") ; syn-keyword (orange accent)
                (wave-aqua-2     . "#e97b3c") ; syn-operator (amber)
                (spring-green    . "#028391") ; syn-string (teal)
                (winter-green    . "#062018") ; diff-add
                (carp-yellow     . "#faa968") ; syn-param / warn (orange)
                (ronin-yellow    . "#e97b3c") ; diag-warning
                (sakura-pink     . "#f85525") ; syn-number (vivid orange-red)
                (winter-red      . "#200808") ; diff-delete
                (samurai-red     . "#f85525") ; diag-error
                (spring-violet-1 . "#a7c9c6") ; syn-constant (light teal)
                (winter-blue     . "#040e20") ; diff-change
                (winter-yellow   . "#181000")))
             ('solitude
              ;; Omarchy Solitude: cool near-black with greyscale & warm accent
              '((fuji-white      . "#cacccc") ; fg  (cool grey-white)
                (old-white       . "#cbc2be") ; fg-dim (warm light)
                (fuji-gray       . "#4b4e55") ; syn-comment (dark grey)
                (katana-gray     . "#343d41") ; border-light
                (sumi-ink-0      . "#080a0b") ; bg-dim
                (sumi-ink-1      . "#101315") ; bg (near black)
                (sumi-ink-2      . "#0c0e10") ; bg-m1
                (sumi-ink-3      . "#181c1e") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#1e2428") ; bg-gutter
                (sumi-ink-5      . "#343d41") ; border
                (wave-blue-1     . "#181c1e") ; bg-visual
                (wave-blue-2     . "#1e2428") ; bg-search
                (crystal-blue    . "#9fa5a9") ; syn-fun  (cool grey)
                (spring-blue     . "#798186") ; syn-type (accent blue-grey)
                (wave-aqua-1     . "#aeaeae") ; syn-keyword (mid grey)
                (wave-aqua-2     . "#9a9a9a") ; syn-operator
                (spring-green    . "#9fa5a9") ; syn-string
                (winter-green    . "#0e1810") ; diff-add
                (carp-yellow     . "#d9dbdc") ; syn-param / warn (bright grey)
                (ronin-yellow    . "#c9c2b4") ; diag-warning
                (sakura-pink     . "#de6145") ; syn-number (warm orange-red)
                (winter-red      . "#1e100c") ; diff-delete
                (samurai-red     . "#de6145") ; diag-error
                (spring-violet-1 . "#a5aeb4") ; syn-constant
                (winter-blue     . "#0c1018") ; diff-change
                (winter-yellow   . "#181410")))
             ('tokyo-night
              ;; Omarchy Tokyo Night: stormy deep blue-purple with bright neon
              '((fuji-white      . "#c0caf5") ; fg  (bright lavender white)
                (old-white       . "#b4bee6") ; fg-dim (light foreground)
                (fuji-gray       . "#565f89") ; syn-comment (dark purple)
                (katana-gray     . "#414868") ; border-light
                (sumi-ink-0      . "#0e0e14") ; bg-dim
                (sumi-ink-1      . "#1a1b26") ; bg (storm dark)
                (sumi-ink-2      . "#13141c") ; bg-m1
                (sumi-ink-3      . "#24283b") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#292e42") ; bg-gutter
                (sumi-ink-5      . "#414868") ; border
                (wave-blue-1     . "#292e42") ; bg-visual (selection)
                (wave-blue-2     . "#33395a") ; bg-search
                (crystal-blue    . "#7da6ff") ; syn-fun  (bright blue)
                (spring-blue     . "#7aa2f7") ; syn-type (blue)
                (wave-aqua-1     . "#bb9af7") ; syn-keyword (purple)
                (wave-aqua-2     . "#0db9d7") ; syn-operator (bright cyan)
                (spring-green    . "#9ece6a") ; syn-string (green)
                (winter-green    . "#162014") ; diff-add
                (carp-yellow     . "#e0af68") ; syn-param / warn (gold)
                (ronin-yellow    . "#ff9e64") ; diag-warning (bright orange)
                (sakura-pink     . "#f7768e") ; syn-number (pink-red)
                (winter-red      . "#2a1020") ; diff-delete
                (samurai-red     . "#ff7a93") ; diag-error (bright pink)
                (spring-violet-1 . "#ad8ee6") ; syn-constant (medium purple)
                (winter-blue     . "#101628") ; diff-change
                (winter-yellow   . "#201800")))
             ('aura
              ;; Omarchy Aura: Dracula-inspired soft pastels on purple-dark
              '((fuji-white      . "#f8f8f2") ; fg  (crisp near-white)
                (old-white       . "#bfc4d0") ; fg-dim (cool lavender grey)
                (fuji-gray       . "#6272a4") ; syn-comment (Dracula comment blue)
                (katana-gray     . "#44475a") ; border-light / selection
                (sumi-ink-0      . "#14151b") ; bg-dim (darker_background)
                (sumi-ink-1      . "#1e2029") ; bg (dark_background)
                (sumi-ink-2      . "#282a36") ; bg-m1 (main background)
                (sumi-ink-3      . "#343746") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#44475a") ; bg-gutter / divider
                (sumi-ink-5      . "#565a6e") ; border / visual
                (wave-blue-1     . "#44475a") ; bg-visual (selection)
                (wave-blue-2     . "#565a6e") ; bg-search
                (crystal-blue    . "#8be9fd") ; syn-fun  (electric cyan accent)
                (spring-blue     . "#bde0fe") ; syn-type (bright sky blue)
                (wave-aqua-1     . "#ffafcc") ; syn-keyword (soft pink)
                (wave-aqua-2     . "#8be9fd") ; syn-operator (cyan)
                (spring-green    . "#a8e6b0") ; syn-string (soft green)
                (winter-green    . "#1e3a2a") ; diff-add
                (carp-yellow     . "#ffb86c") ; syn-param / warn (orange)
                (ronin-yellow    . "#ffb86c") ; diag-warning
                (sakura-pink     . "#ffc8dd") ; syn-number (light magenta)
                (winter-red      . "#3a1a2a") ; diff-delete
                (samurai-red     . "#ff5555") ; diag-error
                (spring-violet-1 . "#cbc3e3") ; syn-constant (soft lavender)
                (winter-blue     . "#1a2240") ; diff-change
                (winter-yellow   . "#2e2a1a")))
             ('batou
              ;; Omarchy Batou: warm monochrome — near-black with muted peach/stone
              '((fuji-white      . "#dbd9d3") ; fg  (warm parchment white)
                (old-white       . "#a4a4a4") ; fg-dim (neutral grey)
                (fuji-gray       . "#605d5b") ; syn-comment (warm charcoal)
                (katana-gray     . "#4a4846") ; border-light / dim
                (sumi-ink-0      . "#0c0c0c") ; bg-dim
                (sumi-ink-1      . "#121212") ; bg (deep near-black)
                (sumi-ink-2      . "#1c1c1c") ; bg-m1
                (sumi-ink-3      . "#252525") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#303030") ; bg-gutter
                (sumi-ink-5      . "#383735") ; border / visual
                (wave-blue-1     . "#282520") ; bg-visual (warm selection)
                (wave-blue-2     . "#302c26") ; bg-search
                (crystal-blue    . "#C2BBB0") ; syn-fun  (warm stone cyan)
                (spring-blue     . "#b7a798") ; syn-type (warm tan)
                (wave-aqua-1     . "#e19e74") ; syn-keyword (muted peach)
                (wave-aqua-2     . "#c6c4b0") ; syn-operator (warm khaki)
                (spring-green    . "#a5a297") ; syn-string (warm stone)
                (winter-green    . "#1e2018") ; diff-add
                (carp-yellow     . "#c6c4b0") ; syn-param / warn
                (ronin-yellow    . "#c6c4b0") ; diag-warning
                (sakura-pink     . "#8a8575") ; syn-number (muted olive)
                (winter-red      . "#2a1a14") ; diff-delete
                (samurai-red     . "#984b1e") ; diag-error (dark rust)
                (spring-violet-1 . "#90947a") ; syn-constant (muted sage)
                (winter-blue     . "#1a1c20") ; diff-change
                (winter-yellow   . "#201e18")))
             ('demon
              ;; Omarchy Demon: absolute black with hellfire red-orange accents
              '((fuji-white      . "#E0D4C2") ; fg  (warm bone)
                (old-white       . "#BDB5AA") ; fg-dim (warm grey)
                (fuji-gray       . "#6B6867") ; syn-comment (ash)
                (katana-gray     . "#4a4846") ; border-light / dim
                (sumi-ink-0      . "#080808") ; bg-dim
                (sumi-ink-1      . "#0F0F0F") ; bg (near-absolute black)
                (sumi-ink-2      . "#171717") ; bg-m1
                (sumi-ink-3      . "#1e1e1e") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#282828") ; bg-gutter
                (sumi-ink-5      . "#333333") ; border
                (wave-blue-1     . "#2a0c0c") ; bg-visual (dark blood selection)
                (wave-blue-2     . "#3a1010") ; bg-search (deep crimson)
                (crystal-blue    . "#7A7D80") ; syn-fun  (cool steel grey)
                (spring-blue     . "#4A6829") ; syn-type (army green)
                (wave-aqua-1     . "#BB1C1C") ; syn-keyword (deep crimson red)
                (wave-aqua-2     . "#E24C00") ; syn-operator (hellfire orange)
                (spring-green    . "#3C6A3E") ; syn-string (dark forest green)
                (winter-green    . "#112211") ; diff-add
                (carp-yellow     . "#E24C00") ; syn-param / warn (orange fire)
                (ronin-yellow    . "#E24C00") ; diag-warning
                (sakura-pink     . "#FF4500") ; syn-number (OrangeRed)
                (winter-red      . "#330a0a") ; diff-delete
                (samurai-red     . "#BB1C1C") ; diag-error
                (spring-violet-1 . "#655E56") ; syn-constant (warm taupe)
                (winter-blue     . "#0f1a10") ; diff-change
                (winter-yellow   . "#201800")))
             ('japan-night
              ;; Omarchy Japan Night: deep ink-navy with muted earth tones
              '((fuji-white      . "#d4d1c2") ; fg  (warm parchment)
                (old-white       . "#b9b6a7") ; fg-dim
                (fuji-gray       . "#667286") ; syn-comment (dark slate blue)
                (katana-gray     . "#3d4e5e") ; border-light
                (sumi-ink-0      . "#061018") ; bg-dim (darker_background)
                (sumi-ink-1      . "#0b1b2b") ; bg (deep ink navy)
                (sumi-ink-2      . "#0f2030") ; bg-m1
                (sumi-ink-3      . "#152838") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#1c3348") ; bg-gutter
                (sumi-ink-5      . "#26404f") ; border
                (wave-blue-1     . "#0e2035") ; bg-visual
                (wave-blue-2     . "#142d47") ; bg-search
                (crystal-blue    . "#7aa8ab") ; syn-fun  (bright cyan)
                (spring-blue     . "#4d6a94") ; syn-type (steel blue)
                (wave-aqua-1     . "#b9968f") ; syn-keyword (dusty rose)
                (wave-aqua-2     . "#638f92") ; syn-operator (teal)
                (spring-green    . "#84a6a5") ; syn-string (sage teal)
                (winter-green    . "#0d2018") ; diff-add
                (carp-yellow     . "#bca88c") ; syn-param / warn (warm sand)
                (ronin-yellow    . "#bca88c") ; diag-warning
                (sakura-pink     . "#be928a") ; syn-number (dusty rose)
                (winter-red      . "#25100e") ; diff-delete
                (samurai-red     . "#b9968f") ; diag-error
                (spring-violet-1 . "#8c6760") ; syn-constant (deep rose)
                (winter-blue     . "#0a1825") ; diff-change
                (winter-yellow   . "#1c1808")))
             ('matrix
              ;; Omarchy Matrix: absolute void black with CRT phosphor green
              '((fuji-white      . "#C5E6C6") ; fg  (bright phosphor)
                (old-white       . "#8BC98C") ; fg-dim (phosphor green)
                (fuji-gray       . "#3A6840") ; syn-comment (dark phosphor)
                (katana-gray     . "#1A3320") ; border-light
                (sumi-ink-0      . "#020302") ; bg-dim (absolute void)
                (sumi-ink-1      . "#080C09") ; bg (deep matrix black)
                (sumi-ink-2      . "#0d1410") ; bg-m1
                (sumi-ink-3      . "#121A13") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#172016") ; bg-gutter
                (sumi-ink-5      . "#1e2e1e") ; border
                (wave-blue-1     . "#0a1e0c") ; bg-visual (dark phosphor selection)
                (wave-blue-2     . "#102810") ; bg-search
                (crystal-blue    . "#6ECB88") ; syn-fun  (bright phosphor cyan)
                (spring-blue     . "#5AA080") ; syn-type (teal phosphor)
                (wave-aqua-1     . "#3CBF5C") ; syn-keyword (vivid phosphor green)
                (wave-aqua-2     . "#4BB56A") ; syn-operator (medium green)
                (spring-green    . "#5ED87A") ; syn-string (bright lime)
                (winter-green    . "#062010") ; diff-add
                (carp-yellow     . "#D4D66A") ; syn-param / warn (phosphor yellow)
                (ronin-yellow    . "#D4D66A") ; diag-warning
                (sakura-pink     . "#7A927A") ; syn-number (muted green-grey)
                (winter-red      . "#1a0808") ; diff-delete
                (samurai-red     . "#D05050") ; diag-error (dull red)
                (spring-violet-1 . "#A8D4A9") ; syn-constant (pale phosphor)
                (winter-blue     . "#060c08") ; diff-change
                (winter-yellow   . "#121a00")))
             ('one-dark-pro
              ;; Omarchy One Dark Pro: the classic — warm grey on deep charcoal
              '((fuji-white      . "#c8ccd4") ; fg  (bright foreground)
                (old-white       . "#abb2bf") ; fg-dim
                (fuji-gray       . "#5c6370") ; syn-comment
                (katana-gray     . "#4a5260") ; border-light
                (sumi-ink-0      . "#181a1f") ; bg-dim (darker_background)
                (sumi-ink-1      . "#21252b") ; bg (dark background)
                (sumi-ink-2      . "#282c34") ; bg-m1 (main background)
                (sumi-ink-3      . "#2c313c") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#3e4451") ; bg-gutter / selection
                (sumi-ink-5      . "#545d6a") ; border
                (wave-blue-1     . "#3e4451") ; bg-visual (selection)
                (wave-blue-2     . "#4a5260") ; bg-search
                (crystal-blue    . "#61afef") ; syn-fun  (bright blue)
                (spring-blue     . "#56b6c2") ; syn-type (cyan)
                (wave-aqua-1     . "#c678dd") ; syn-keyword (purple)
                (wave-aqua-2     . "#56b6c2") ; syn-operator (cyan)
                (spring-green    . "#98c379") ; syn-string (green)
                (winter-green    . "#1e2d1a") ; diff-add
                (carp-yellow     . "#e5c07b") ; syn-param / warn (gold)
                (ronin-yellow    . "#e5c07b") ; diag-warning
                (sakura-pink     . "#e06c75") ; syn-number (rose)
                (winter-red      . "#2d1a1c") ; diff-delete
                (samurai-red     . "#e06c75") ; diag-error
                (spring-violet-1 . "#d19a66") ; syn-constant (orange)
                (winter-blue     . "#1a2030") ; diff-change
                (winter-yellow   . "#2a2210")))
             ('rose-pine-dark
              ;; Omarchy Rose Pine Dark: purple midnight with rose/foam/gold
              '((fuji-white      . "#e0def4") ; fg  (soft lavender white)
                (old-white       . "#c4a7e7") ; fg-dim (muted iris)
                (fuji-gray       . "#6e6a86") ; syn-comment (muted purple)
                (katana-gray     . "#524f67") ; border-light / cursor
                (sumi-ink-0      . "#111020") ; bg-dim
                (sumi-ink-1      . "#191724") ; bg (deep midnight)
                (sumi-ink-2      . "#1f1d2e") ; bg-m1
                (sumi-ink-3      . "#26233a") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#31304a") ; bg-gutter
                (sumi-ink-5      . "#524f67") ; border
                (wave-blue-1     . "#26233a") ; bg-visual (selection)
                (wave-blue-2     . "#332f50") ; bg-search
                (crystal-blue    . "#9ccfd8") ; syn-fun  (foam blue)
                (spring-blue     . "#31748f") ; syn-type (pine teal)
                (wave-aqua-1     . "#c4a7e7") ; syn-keyword (iris purple)
                (wave-aqua-2     . "#9ccfd8") ; syn-operator (foam)
                (spring-green    . "#31748f") ; syn-string (pine)
                (winter-green    . "#14222a") ; diff-add
                (carp-yellow     . "#f6c177") ; syn-param / warn (gold)
                (ronin-yellow    . "#f6c177") ; diag-warning
                (sakura-pink     . "#eb6f92") ; syn-number (rose)
                (winter-red      . "#2a1420") ; diff-delete
                (samurai-red     . "#eb6f92") ; diag-error
                (spring-violet-1 . "#ebbcba") ; syn-constant (rose gold)
                (winter-blue     . "#181626") ; diff-change
                (winter-yellow   . "#20180c")))
             ('terminus
              ;; Omarchy Terminus: deep navy Foundation with warm gold accents
              '((fuji-white      . "#f2e8d5") ; fg  (warm parchment)
                (old-white       . "#d8cbb4") ; fg-dim (warm sand)
                (fuji-gray       . "#9f9f9e") ; syn-comment (neutral grey)
                (katana-gray     . "#5e6e87") ; border-light (muted slate)
                (sumi-ink-0      . "#070c15") ; bg-dim
                (sumi-ink-1      . "#0c1626") ; bg (deep foundation navy)
                (sumi-ink-2      . "#11203a") ; bg-m1
                (sumi-ink-3      . "#17243a") ; bg-p2 (hl-line)
                (sumi-ink-4      . "#1e2e48") ; bg-gutter
                (sumi-ink-5      . "#26364e") ; border
                (wave-blue-1     . "#162030") ; bg-visual
                (wave-blue-2     . "#1c2d40") ; bg-search
                (crystal-blue    . "#8fb0d4") ; syn-fun  (bright steel blue)
                (spring-blue     . "#6e93bb") ; syn-type (medium blue)
                (wave-aqua-1     . "#7fa8ab") ; syn-keyword (dusty teal)
                (wave-aqua-2     . "#a8ccce") ; syn-operator (bright teal)
                (spring-green    . "#a8c48a") ; syn-string (warm sage green)
                (winter-green    . "#10200e") ; diff-add
                (carp-yellow     . "#d9a862") ; syn-param / warn (warm gold accent)
                (ronin-yellow    . "#f0d4a0") ; diag-warning (pale gold)
                (sakura-pink     . "#ab7fa8") ; syn-number (mauve)
                (winter-red      . "#25100c") ; diff-delete
                (samurai-red     . "#e07a5f") ; diag-error (bright red-orange)
                (spring-violet-1 . "#c9a3c4") ; syn-constant (pale mauve)
                (winter-blue     . "#0a1828") ; diff-change
                (winter-yellow   . "#1e1600")))
            (_
             ;; Classic Wave: Balanced volcanic slate-teal black
             '((fuji-white      . "#dce5e9") ; fg (pale slate grey)
               (old-white       . "#abb2bf") ; fg-dim (muted grey)
               (fuji-gray       . "#8e969a") ; syn-comment (stone grey)
               (katana-gray     . "#5c6370") ; border-light / dim comment
               (sumi-ink-0      . "#0b1012") ; bg-dim / bg-m3 (deepest obsidian)
               (sumi-ink-1      . "#0f1416") ; bg (volcanic dark slate/teal black)
               (sumi-ink-2      . "#151b1e") ; bg-m1 / bg-p1 (soft black / modeline / floats)
               (sumi-ink-3      . "#1a2327") ; bg-p2 (hl-line / subtle contrast)
               (sumi-ink-4      . "#253238") ; bg-gutter / divider dark
               (sumi-ink-5      . "#394b53") ; border / visual selection dark
               (wave-blue-1     . "#223843") ; bg-visual (selection)
               (wave-blue-2     . "#2c4c5e") ; bg-search / incsearch
               (crystal-blue    . "#8fe0fa") ; syn-fun / electric cyan
               (spring-blue     . "#76c7e3") ; syn-type / sky blue
               (wave-aqua-1     . "#37868b") ; syn-keyword / dark teal
               (wave-aqua-2     . "#4fa3a6") ; syn-operator / bright teal
               (spring-green    . "#8be086") ; syn-string / bamboo green
               (winter-green    . "#233d2b") ; diff-add bg
               (carp-yellow     . "#e0af68") ; syn-identifier / warn
               (ronin-yellow    . "#e0af68") ; diag-warning
               (sakura-pink     . "#e05f64") ; syn-number / coral red
               (winter-red      . "#422123") ; diff-delete bg
               (samurai-red     . "#e03f32") ; diag-error
               (spring-violet-1 . "#9083b9") ; syn-constant / amethyst purple
               (winter-blue     . "#1d3244") ; diff-change bg
               (winter-yellow   . "#364d5c")))))

         (fuji-white      (alist-get 'fuji-white colors))
         (old-white       (alist-get 'old-white colors))
         (fuji-gray       (alist-get 'fuji-gray colors))
         (katana-gray     (alist-get 'katana-gray colors))

         (sumi-ink-0      (alist-get 'sumi-ink-0 colors))
         (sumi-ink-1      (alist-get 'sumi-ink-1 colors))
         (sumi-ink-2      (alist-get 'sumi-ink-2 colors))
         (sumi-ink-3      (alist-get 'sumi-ink-3 colors))
         (sumi-ink-4      (alist-get 'sumi-ink-4 colors))
         (sumi-ink-5      (alist-get 'sumi-ink-5 colors))

         (wave-blue-1     (alist-get 'wave-blue-1 colors))
         (wave-blue-2     (alist-get 'wave-blue-2 colors))

         (crystal-blue    (alist-get 'crystal-blue colors))
         (spring-blue     (alist-get 'spring-blue colors))
         (wave-aqua-1     (alist-get 'wave-aqua-1 colors))
         (wave-aqua-2     (alist-get 'wave-aqua-2 colors))

         (spring-green    (alist-get 'spring-green colors))
         (winter-green    (alist-get 'winter-green colors))

         (carp-yellow     (alist-get 'carp-yellow colors))
         (ronin-yellow    (alist-get 'ronin-yellow colors))

         (sakura-pink     (alist-get 'sakura-pink colors))
         (winter-red      (alist-get 'winter-red colors))
         (samurai-red     (alist-get 'samurai-red colors))

         (spring-violet-1 (alist-get 'spring-violet-1 colors))

         (winter-blue     (alist-get 'winter-blue colors))
         (winter-yellow   (alist-get 'winter-yellow colors))

         ;; Semantic mappings
         (fg              fuji-white)
         (fg-dim          old-white)

         (bg-dim          sumi-ink-0)
         (bg-gutter       sumi-ink-4)

         (bg-m3           sumi-ink-0)
         (bg-m2           sumi-ink-1)
         (bg-m1           sumi-ink-2)
         (bg              sumi-ink-1)
         (bg-p1           sumi-ink-2)
         (bg-p2           sumi-ink-3)
         (bg-num-bar      (vulkanite--darken-hex bg 10))

         (special         wave-aqua-2)
         (nontext         katana-gray)
         (whitespace      sumi-ink-5)

         (bg-visual       wave-blue-1)
         (bg-search       wave-blue-2)

         (pmenu-fg        fuji-white)
         (pmenu-bg        sumi-ink-2)
         (pmenu-bg-sel    wave-blue-1)
         (pmenu-bg-sbar   sumi-ink-4)
         (pmenu-bg-thumb  wave-aqua-2)

         (syn-string      spring-green)
         (syn-variable    fuji-white)
         (syn-number      sakura-pink)
         (syn-constant    spring-violet-1)
         (syn-identifier  spring-blue)
         (syn-parameter   old-white)
         (syn-fun         crystal-blue)
         (syn-statement   wave-aqua-1)
         (syn-keyword     wave-aqua-1)
         (syn-operator    wave-aqua-2)
         (syn-preproc     spring-blue)
         (syn-type        spring-blue)
         (syn-regex       carp-yellow)
         (syn-deprecated  katana-gray)
         (syn-comment     fuji-gray)
         (syn-punct       wave-aqua-2)
         (syn-special-1   crystal-blue)
         (syn-special-2   spring-violet-1)
         (syn-special-3   sakura-pink)

         (diff-add        winter-green)
         (diff-delete     winter-red)
         (diff-change     winter-blue)
         (diff-text       winter-yellow)

         (diag-ok         spring-green)
         (diag-error      samurai-red)
         (diag-warning    ronin-yellow)
         (diag-info       crystal-blue)
         (diag-hint       wave-aqua-2)

         (black           sumi-ink-0)
         (red             sakura-pink)
         (green           spring-green)
         (yellow          carp-yellow)
         (blue            crystal-blue)
         (magenta         spring-violet-1)
         (cyan            wave-aqua-2)
         (white           old-white)
         (bright-black    fuji-gray)
         (bright-red      samurai-red)
         (bright-green    spring-green)
         (bright-yellow   carp-yellow)
         (bright-blue     spring-blue)
         (bright-magenta  spring-violet-1)
         (bright-cyan     crystal-blue)
         (bright-white    fuji-white))

    (apply
     #'custom-theme-set-faces
     theme-name
     `(
       ;;;;;; Basic Coloring & UI
       (button ((t (:underline t))))
       (link ((t (:foreground ,crystal-blue :underline t :weight bold))))
       (link-visited ((t (:foreground ,spring-blue :underline t :weight normal))))
       (default ((t (:foreground ,fg :background ,bg))))
       (cursor ((t (:foreground ,bg :background ,crystal-blue))))
       (widget-field ((t (:foreground ,fg :background ,bg-p1))))
       (escape-glyph ((t (:foreground ,special :weight bold))))
       (fringe ((t (:foreground ,katana-gray :background ,bg-num-bar))))
       (header-line ((t (:foreground ,fg :background ,bg-p1 :extend t))))
       (highlight ((t (:foreground ,fg :background ,bg-p2 :weight bold))))
       (success ((t (:foreground ,diag-ok :weight bold))))
       (warning ((t (:foreground ,diag-warning :weight bold))))
       (error ((t (:foreground ,diag-error :weight bold))))
       (tooltip ((t (:foreground ,pmenu-fg :background ,pmenu-bg))))
       (menu ((t (:foreground ,fg :background ,bg))))
       (region ((t (:background ,bg-visual :extend t))))
       (secondary-selection ((t (:background ,bg-search :extend t))))
       (separator-line ((t (:background ,bg-gutter))))
       (shadow ((t (:foreground ,katana-gray))))
       (nobreak-space ((t (:foreground ,nontext :underline t))))
       (window-border ((t (:background ,bg))))
       (window-divider ((t (:foreground ,bg-gutter))))
       (window-divider-first-pixel ((t (:foreground ,bg-gutter))))
       (window-divider-last-pixel ((t (:foreground ,bg-gutter))))
       (vertical-border ((t (:foreground ,bg-gutter))))
       (minibuffer-prompt ((t (:foreground ,wave-aqua-2 :weight bold))))

       ;;;;;; Whitespace Mode
       (whitespace-space ((t (:foreground ,whitespace))))
       (whitespace-tab ((t (:foreground ,whitespace))))
       (whitespace-newline ((t (:foreground ,whitespace))))
       (whitespace-line ((t (:background ,bg-p2))))

       ;;;;;; Font Lock (Syntax Highlighting)
       (font-lock-builtin-face ((t (:foreground ,syn-special-2))))
       (font-lock-comment-face ((t (:foreground ,syn-comment
                                                :slant ,(if vulkanite-theme-comment-italic 'italic 'normal)))))
       (font-lock-comment-delimiter-face ((t (:foreground ,katana-gray
                                                          :slant ,(if vulkanite-theme-comment-italic 'italic 'normal)))))
       (font-lock-bracket-face ((t (:foreground ,syn-punct))))
       (font-lock-delimiter-face ((t (:foreground ,syn-punct))))
       (font-lock-misc-punctuation-face ((t (:foreground ,syn-punct))))
       (font-lock-constant-face ((t (:foreground ,syn-constant))))
       (font-lock-doc-face ((t (:foreground ,syn-string :slant italic))))
       (font-lock-doc-markup-face ((t (:foreground ,syn-special-1))))
       (font-lock-function-name-face ((t (:foreground ,syn-fun :weight bold))))
       (font-lock-function-call-face ((t (:foreground ,syn-fun))))
       (font-lock-keyword-face ((t (:foreground ,syn-keyword
                                                :weight bold
                                                :slant ,(if vulkanite-theme-keyword-italic 'italic 'normal)))))
       (font-lock-operator-face ((t (:foreground ,syn-operator))))
       (font-lock-negation-char-face ((t (:foreground ,syn-operator :weight bold))))
       (font-lock-preprocessor-face ((t (:foreground ,syn-preproc))))
       (font-lock-regexp-grouping-construct ((t (:foreground ,syn-regex :weight bold))))
       (font-lock-regexp-grouping-backslash ((t (:foreground ,syn-regex :weight bold))))
       (font-lock-escape-face ((t (:foreground ,syn-regex :weight bold))))
       (font-lock-string-face ((t (:foreground ,syn-string))))
       (font-lock-number-face ((t (:foreground ,syn-number))))
       (font-lock-type-face ((t (:foreground ,syn-type))))
       (font-lock-variable-name-face ((t (:foreground ,syn-variable))))
       (font-lock-variable-use-face ((t (:foreground ,syn-parameter))))
       (font-lock-property-name-face ((t (:foreground ,syn-identifier))))
       (font-lock-property-use-face ((t (:foreground ,syn-identifier))))
       (font-lock-warning-face ((t (:foreground ,diag-warning :weight bold))))
       (c-annotation-face ((t (:inherit font-lock-constant-face))))

       ;;;;;; Line Numbers
       (line-number ((t (:foreground ,katana-gray :background ,bg-num-bar))))
       (line-number-current-line ((t (:foreground ,crystal-blue :background ,bg-num-bar :weight bold))))
       (line-number-major-tick ((t (:foreground ,spring-blue :background ,bg-num-bar :weight bold))))
       (line-number-minor-tick ((t (:foreground ,katana-gray :background ,bg-num-bar))))

       ;;;;;; Search & Matching
       (isearch ((t (:foreground ,fg :background ,wave-blue-2 :weight bold))))
       (isearch-fail ((t (:foreground ,fg :background ,diag-error :weight bold))))
       (lazy-highlight ((t (:foreground ,fg :background ,bg-visual))))
       (match ((t (:foreground ,crystal-blue :background ,bg-search :weight bold))))
       (show-paren-match ((t (:foreground ,crystal-blue :background ,bg-search :weight bold :underline t))))
       (show-paren-match-expression ((t (:inherit show-paren-match))))
       (show-paren-mismatch ((t (:foreground ,fg :background ,diag-error :weight bold))))

       ;;;;;; Mode Line
       (mode-line ((t (:foreground ,fg-dim :background ,bg-m3 :box (:line-width -1 :color ,bg-gutter)))))
       (mode-line-inactive ((t (:foreground ,katana-gray :background ,bg-dim :box (:line-width -1 :color ,bg-dim)))))
       (mode-line-buffer-id ((t (:foreground ,crystal-blue :weight bold))))
       (mode-line-emphasis ((t (:foreground ,wave-aqua-2 :weight bold))))
       (mode-line-highlight ((t (:foreground ,crystal-blue :background ,bg-p2))))

       ;;;;;; HL-Line
       (hl-line ((t (:background ,bg-p2 :extend t))))

       ;;;;;; Tab Line & Tab Bar
       (tab-line ((t (:background ,bg-m3 :foreground ,katana-gray))))
       (tab-line-tab ((t (:background ,bg-m1 :foreground ,fg-dim))))
       (tab-line-tab-current ((t (:background ,bg :foreground ,fg :weight bold))))
       (tab-line-tab-inactive ((t (:background ,bg-m3 :foreground ,katana-gray))))
       (tab-bar ((t (:background ,bg-m3 :foreground ,katana-gray))))
       (tab-bar-tab ((t (:background ,bg :foreground ,fg :weight bold))))
       (tab-bar-tab-inactive ((t (:background ,bg-m3 :foreground ,katana-gray))))

       ;;;;;; ANSI Colors (Terminal/Eat/Vterm)
       (ansi-color-black ((t (:foreground ,black :background ,black))))
       (ansi-color-red ((t (:foreground ,red :background ,red))))
       (ansi-color-green ((t (:foreground ,green :background ,green))))
       (ansi-color-yellow ((t (:foreground ,yellow :background ,yellow))))
       (ansi-color-blue ((t (:foreground ,blue :background ,blue))))
       (ansi-color-magenta ((t (:foreground ,magenta :background ,magenta))))
       (ansi-color-cyan ((t (:foreground ,cyan :background ,cyan))))
       (ansi-color-white ((t (:foreground ,white :background ,white))))
       (ansi-color-bright-black ((t (:foreground ,bright-black :background ,bright-black))))
       (ansi-color-bright-red ((t (:foreground ,bright-red :background ,bright-red))))
       (ansi-color-bright-green ((t (:foreground ,bright-green :background ,bright-green))))
       (ansi-color-bright-yellow ((t (:foreground ,bright-yellow :background ,bright-yellow))))
       (ansi-color-bright-blue ((t (:foreground ,bright-blue :background ,bright-blue))))
       (ansi-color-bright-magenta ((t (:foreground ,bright-magenta :background ,bright-magenta))))
       (ansi-color-bright-cyan ((t (:foreground ,bright-cyan :background ,bright-cyan))))
       (ansi-color-bright-white ((t (:foreground ,bright-white :background ,bright-white))))

       (term ((t (:foreground ,fg :background ,bg))))
       (term-color-black ((t (:foreground ,black :background ,black))))
       (term-color-red ((t (:foreground ,red :background ,red))))
       (term-color-green ((t (:foreground ,green :background ,green))))
       (term-color-yellow ((t (:foreground ,yellow :background ,yellow))))
       (term-color-blue ((t (:foreground ,blue :background ,blue))))
       (term-color-magenta ((t (:foreground ,magenta :background ,magenta))))
       (term-color-cyan ((t (:foreground ,cyan :background ,cyan))))
       (term-color-white ((t (:foreground ,white :background ,white))))

       ;;;;;; Org Mode
       (org-level-1 ((t (:foreground ,crystal-blue
                                     :height ,(if vulkanite-theme-org-height 1.25 1.0)
                                     :weight ,(if vulkanite-theme-org-bold 'bold 'normal)))))
       (org-level-2 ((t (:foreground ,spring-blue
                                     :height ,(if vulkanite-theme-org-height 1.15 1.0)
                                     :weight ,(if vulkanite-theme-org-bold 'bold 'normal)))))
       (org-level-3 ((t (:foreground ,wave-aqua-2
                                     :height ,(if vulkanite-theme-org-height 1.08 1.0)
                                     :weight ,(if vulkanite-theme-org-bold 'bold 'normal)))))
       (org-level-4 ((t (:foreground ,spring-green))))
       (org-level-5 ((t (:foreground ,carp-yellow))))
       (org-level-6 ((t (:foreground ,spring-violet-1))))
       (org-level-7 ((t (:foreground ,sakura-pink))))
       (org-level-8 ((t (:foreground ,wave-aqua-1))))
       (org-document-title ((t (:foreground ,crystal-blue :weight bold :height 1.3))))
       (org-document-info ((t (:foreground ,fg-dim))))
       (org-document-info-keyword ((t (:foreground ,katana-gray))))
       (org-done ((t (:foreground ,spring-green :weight bold))))
       (org-headline-done ((t (:foreground ,katana-gray :strike-through t))))
       (org-todo ((t (:foreground ,sakura-pink :weight bold))))
       (org-headline-todo ((t (:foreground ,fg))))
       (org-code ((t (:foreground ,spring-green :background ,bg-m3))))
       (org-verbatim ((t (:foreground ,carp-yellow :background ,bg-m3))))
       (org-meta-line ((t (:foreground ,katana-gray :slant italic))))
       (org-block ((t (:foreground ,fg :background ,bg-m3 :extend t))))
       (org-block-begin-line ((t (:foreground ,katana-gray :background ,bg-m3 :slant italic :extend t))))
       (org-block-end-line ((t (:foreground ,katana-gray :background ,bg-m3 :slant italic :extend t))))
       (org-upcoming-deadline ((t (:foreground ,sakura-pink))))
       (org-footnote ((t (:foreground ,wave-aqua-2))))
       (org-indent ((t (:foreground ,bg :background ,bg))))
       (org-hide ((t (:inherit org-indent))))
       (org-date ((t (:foreground ,wave-aqua-2 :underline t))))
       (org-ellipsis ((t (:foreground ,katana-gray :weight bold))))
       (org-table ((t (:foreground ,spring-blue :background ,bg-m3))))
       (org-formula ((t (:foreground ,sakura-pink))))
       (org-link ((t (:foreground ,crystal-blue :underline t))))
       (org-priority ((t (:foreground ,carp-yellow
                                      :weight ,(if vulkanite-theme-org-priority-bold 'bold 'normal)))))
       (org-tag ((t (:foreground ,wave-aqua-2 :slant italic))))

       ;;;;;; Markdown Mode
       (markdown-header-face-1 ((t (:inherit org-level-1))))
       (markdown-header-face-2 ((t (:inherit org-level-2))))
       (markdown-header-face-3 ((t (:inherit org-level-3))))
       (markdown-header-face-4 ((t (:inherit org-level-4))))
       (markdown-header-face-5 ((t (:inherit org-level-5))))
       (markdown-header-face-6 ((t (:inherit org-level-6))))
       (markdown-code-face ((t (:inherit org-code))))
       (markdown-inline-code-face ((t (:inherit org-code))))
       (markdown-pre-face ((t (:inherit org-block))))
       (markdown-language-keyword-face ((t (:foreground ,katana-gray))))
       (markdown-link-face ((t (:foreground ,crystal-blue :underline t))))
       (markdown-url-face ((t (:foreground ,spring-blue :underline t))))

       ;;;;;; Dired & Diredfl
       (dired-directory ((t (:foreground ,crystal-blue :weight bold))))
       (dired-flagged ((t (:foreground ,samurai-red :weight bold))))
       (dired-header ((t (:foreground ,wave-aqua-2 :weight bold))))
       (dired-ignored ((t (:inherit shadow))))
       (dired-mark ((t (:foreground ,carp-yellow :weight bold))))
       (dired-marked ((t (:foreground ,spring-violet-1 :weight bold))))
       (dired-perm-write ((t (:foreground ,fg :underline t))))
       (dired-symlink ((t (:foreground ,wave-aqua-2))))
       (dired-warning ((t (:foreground ,diag-warning))))
       (diredfl-autofile-name ((t (:foreground ,wave-blue-2))))
       (diredfl-compressed-file-name ((t (:foreground ,carp-yellow))))
       (diredfl-compressed-file-suffix ((t (:foreground ,carp-yellow))))
       (diredfl-date-time ((t (:foreground ,wave-aqua-2))))
       (diredfl-deletion ((t (:background ,diff-delete :foreground ,samurai-red))))
       (diredfl-deletion-file-name ((t (:foreground ,samurai-red :strike-through t))))
       (diredfl-dir-heading ((t (:foreground ,crystal-blue :weight bold))))
       (diredfl-dir-name ((t (:foreground ,crystal-blue :weight bold))))
       (diredfl-dir-priv ((t (:foreground ,crystal-blue))))
       (diredfl-exec-priv ((t (:foreground ,spring-green))))
       (diredfl-executable-tag ((t (:foreground ,spring-green))))
       (diredfl-file-name ((t (:foreground ,fg))))
       (diredfl-file-suffix ((t (:foreground ,fg-dim))))
       (diredfl-flag-mark ((t (:foreground ,carp-yellow :weight bold))))
       (diredfl-flag-mark-line ((t (:background ,bg-p2))))
       (diredfl-ignored-file-name ((t (:inherit shadow))))
       (diredfl-link-priv ((t (:foreground ,spring-violet-1))))
       (diredfl-no-priv ((t (:foreground ,katana-gray))))
       (diredfl-number ((t (:foreground ,sakura-pink))))
       (diredfl-other-priv ((t (:foreground ,wave-aqua-2))))
       (diredfl-rare-priv ((t (:foreground ,samurai-red))))
       (diredfl-read-priv ((t (:foreground ,spring-blue))))
       (diredfl-symlink ((t (:foreground ,wave-aqua-2))))
       (diredfl-tagged-autofile-name ((t (:foreground ,spring-green))))
       (diredfl-write-priv ((t (:foreground ,carp-yellow))))

       ;;;;;; Diff & VCS
       (diff-added ((t (:background ,diff-add :foreground ,spring-green :extend t))))
       (diff-changed ((t (:background ,diff-change :foreground ,spring-blue :extend t))))
       (diff-removed ((t (:background ,diff-delete :foreground ,samurai-red :extend t))))
       (diff-refine-added ((t (:background ,diff-add :foreground ,spring-green :weight bold))))
       (diff-refine-changed ((t (:background ,diff-text :foreground ,crystal-blue :weight bold))))
       (diff-refine-removed ((t (:background ,diff-delete :foreground ,samurai-red :weight bold))))
       (diff-header ((t (:background ,bg-p1 :foreground ,wave-aqua-2 :extend t))))
       (diff-file-header ((t (:background ,bg-p2 :foreground ,crystal-blue :weight bold :extend t))))
       (diff-hunk-header ((t (:background ,bg-p1 :foreground ,spring-violet-1 :extend t))))

       (diff-hl-insert ((t (:foreground ,spring-green :background ,diff-add))))
       (diff-hl-delete ((t (:foreground ,samurai-red :background ,diff-delete))))
       (diff-hl-change ((t (:foreground ,crystal-blue :background ,diff-change))))
       (diff-hl-margin-insert ((t (:inherit diff-hl-insert))))
       (diff-hl-margin-delete ((t (:inherit diff-hl-delete))))
       (diff-hl-margin-change ((t (:inherit diff-hl-change))))

       (git-gutter:added ((t (:foreground ,spring-green))))
       (git-gutter:deleted ((t (:foreground ,samurai-red))))
       (git-gutter:modified ((t (:foreground ,crystal-blue))))

       ;;;;;; Magit
       (magit-section-heading ((t (:foreground ,wave-aqua-2 :weight bold :extend t))))
       (magit-section-highlight ((t (:background ,bg-p1 :extend t))))
       (magit-section-title ((t (:foreground ,crystal-blue :weight bold))))
       (magit-branch-local ((t (:foreground ,crystal-blue :weight bold))))
       (magit-branch-remote ((t (:foreground ,wave-aqua-2 :weight bold))))
       (magit-branch-current ((t (:foreground ,crystal-blue :weight bold :box (:line-width 1 :color ,wave-aqua-2)))))
       (magit-tag ((t (:foreground ,carp-yellow :weight bold))))
       (magit-hash ((t (:foreground ,katana-gray))))
       (magit-diff-context-highlight ((t (:background ,bg-p1 :foreground ,fg :extend t))))
       (magit-diff-hunk-heading ((t (:background ,bg-p1 :foreground ,wave-aqua-2 :extend t))))
       (magit-diff-hunk-heading-highlight ((t (:background ,bg-p2 :foreground ,crystal-blue :weight bold :extend t))))
       (magit-diff-added ((t (:background ,diff-add :foreground ,spring-green :extend t))))
       (magit-diff-added-highlight ((t (:background ,diff-add :foreground ,spring-green :weight bold :extend t))))
       (magit-diff-removed ((t (:background ,diff-delete :foreground ,samurai-red :extend t))))
       (magit-diff-removed-highlight ((t (:background ,diff-delete :foreground ,samurai-red :weight bold :extend t))))
       (magit-diff-base ((t (:background ,diff-change :foreground ,carp-yellow :extend t))))
       (magit-diff-base-highlight ((t (:background ,diff-text :foreground ,carp-yellow :extend t))))
       (magit-log-author ((t (:foreground ,spring-blue))))
       (magit-log-date ((t (:foreground ,katana-gray))))
       (magit-log-graph ((t (:foreground ,katana-gray))))
       (magit-process-ok ((t (:foreground ,spring-green :weight bold))))
       (magit-process-ng ((t (:foreground ,samurai-red :weight bold))))

       ;;;;;; Corfu & Completions
       (corfu-default ((t (:background ,pmenu-bg :foreground ,fg))))
       (corfu-current ((t (:background ,pmenu-bg-sel :foreground ,crystal-blue :weight bold))))
       (corfu-bar ((t (:background ,pmenu-bg-thumb))))
       (corfu-border ((t (:background ,pmenu-bg-sbar))))
       (corfu-annotations ((t (:foreground ,katana-gray :slant italic))))
       (corfu-deprecated ((t (:foreground ,syn-deprecated :strike-through t))))

       ;;;;;; Vertico & Marginalia
       (vertico-current ((t (:background ,wave-blue-1 :foreground ,crystal-blue :weight bold :extend t))))
       (vertico-group-title ((t (:foreground ,wave-aqua-2 :weight bold :slant italic))))
       (vertico-group-separator ((t (:foreground ,bg-gutter :strike-through t))))
       (vertico-multiline ((t (:foreground ,diag-warning))))
       (marginalia-key ((t (:foreground ,wave-aqua-2))))
       (marginalia-type ((t (:foreground ,spring-blue :slant italic))))
       (marginalia-char ((t (:foreground ,spring-violet-1))))
       (marginalia-documentation ((t (:foreground ,katana-gray :slant italic))))
       (marginalia-file-name ((t (:foreground ,fg))))
       (marginalia-file-owner ((t (:foreground ,katana-gray))))
       (marginalia-file-priv-no ((t (:foreground ,katana-gray))))
       (marginalia-file-priv-read ((t (:foreground ,spring-blue))))
       (marginalia-file-priv-write ((t (:foreground ,carp-yellow))))
       (marginalia-file-priv-exec ((t (:foreground ,spring-green))))
       (marginalia-size ((t (:foreground ,sakura-pink))))
       (marginalia-value ((t (:foreground ,spring-violet-1))))
       (marginalia-version ((t (:foreground ,carp-yellow))))

       ;;;;;; Orderless
       (orderless-match-face-0 ((t (:foreground ,crystal-blue :weight bold))))
       (orderless-match-face-1 ((t (:foreground ,spring-green :weight bold))))
       (orderless-match-face-2 ((t (:foreground ,carp-yellow :weight bold))))
       (orderless-match-face-3 ((t (:foreground ,spring-violet-1 :weight bold))))

       ;;;;;; Company
       (company-tooltip ((t (:background ,pmenu-bg :foreground ,fg))))
       (company-tooltip-selection ((t (:background ,pmenu-bg-sel :foreground ,crystal-blue :weight bold))))
       (company-tooltip-common ((t (:foreground ,crystal-blue :weight bold))))
       (company-tooltip-annotation ((t (:foreground ,katana-gray :slant italic))))
       (company-scrollbar-bg ((t (:background ,bg-m3))))
       (company-scrollbar-fg ((t (:background ,pmenu-bg-thumb))))
       (company-preview ((t (:foreground ,katana-gray))))
       (company-preview-common ((t (:foreground ,crystal-blue))))

       ;;;;;; Tree-sitter & Modern Emacs 29+ TS Modes
       (tree-sitter-hl-face:variable ((t (:foreground ,fg))))
       (tree-sitter-hl-face:variable.builtin ((t (:foreground ,syn-special-2 :slant italic))))
       (tree-sitter-hl-face:variable.parameter ((t (:foreground ,syn-parameter))))
       (tree-sitter-hl-face:variable.special ((t (:foreground ,syn-special-3))))
       (tree-sitter-hl-face:string ((t (:foreground ,syn-string))))
       (tree-sitter-hl-face:number ((t (:foreground ,syn-number))))
       (tree-sitter-hl-face:string.special ((t (:foreground ,syn-regex))))
       (tree-sitter-hl-face:attribute ((t (:foreground ,syn-identifier))))
       (tree-sitter-hl-face:constructor ((t (:foreground ,crystal-blue :weight bold))))
       (tree-sitter-hl-face:operator ((t (:foreground ,syn-operator))))
       (tree-sitter-hl-face:keyword ((t (:foreground ,syn-statement
                                                     :weight bold
                                                     :slant ,(if vulkanite-theme-keyword-italic 'italic 'normal)))))
       (tree-sitter-hl-face:punctuation ((t (:foreground ,syn-punct))))
       (tree-sitter-hl-face:punctuation.delimiter ((t (:foreground ,syn-punct))))
       (tree-sitter-hl-face:punctuation.bracket ((t (:foreground ,syn-punct))))
       (tree-sitter-hl-face:punctuation.special ((t (:foreground ,syn-punct))))
       (tree-sitter-hl-face:comment ((t (:inherit font-lock-comment-face))))
       (tree-sitter-hl-face:tag ((t (:foreground ,wave-aqua-1 :weight bold))))
       (tree-sitter-hl-face:label ((t (:foreground ,syn-punct))))

       ;; Emacs 29 built-in treesit faces
       (treesit-font-lock-punctuation ((t (:foreground ,syn-punct))))
       (treesit-font-lock-operator ((t (:foreground ,syn-operator))))
       (treesit-font-lock-property ((t (:foreground ,syn-identifier))))
       (treesit-font-lock-string ((t (:foreground ,syn-string))))
       (treesit-font-lock-number ((t (:foreground ,syn-number))))
       (treesit-font-lock-keyword ((t (:foreground ,syn-keyword
                                                   :weight bold
                                                   :slant ,(if vulkanite-theme-keyword-italic 'italic 'normal)))))
       (treesit-font-lock-type ((t (:foreground ,syn-type))))
       (treesit-font-lock-function ((t (:foreground ,syn-fun :weight bold))))
       (treesit-font-lock-variable ((t (:foreground ,fg))))
       (treesit-font-lock-constant ((t (:foreground ,syn-constant))))

       ;;;;;; Web-mode & Front-end (Vue / TS / TSX / HTML / CSS)
       (web-mode-html-tag-face ((t (:foreground ,wave-aqua-1 :weight bold))))
       (web-mode-html-tag-bracket-face ((t (:foreground ,wave-aqua-2))))
       (web-mode-html-attr-name-face ((t (:foreground ,spring-blue))))
       (web-mode-html-attr-value-face ((t (:foreground ,spring-green))))
       (web-mode-html-attr-equal-face ((t (:foreground ,wave-aqua-2))))
       (web-mode-builtin-face ((t (:foreground ,syn-special-2))))
       (web-mode-keyword-face ((t (:inherit font-lock-keyword-face))))
       (web-mode-function-name-face ((t (:inherit font-lock-function-name-face))))
       (web-mode-variable-name-face ((t (:inherit font-lock-variable-name-face))))
       (web-mode-string-face ((t (:inherit font-lock-string-face))))
       (web-mode-comment-face ((t (:inherit font-lock-comment-face))))
       (web-mode-type-face ((t (:inherit font-lock-type-face))))
       (web-mode-constant-face ((t (:inherit font-lock-constant-face))))
       (web-mode-css-selector-face ((t (:foreground ,crystal-blue :weight bold))))
       (web-mode-css-pseudo-class-face ((t (:foreground ,wave-aqua-2))))
       (web-mode-css-property-name-face ((t (:foreground ,spring-blue))))
       (web-mode-css-string-face ((t (:foreground ,spring-green))))
       (web-mode-css-color-face ((t (:foreground ,sakura-pink))))
       (web-mode-block-face ((t (:background ,bg-dim))))
       (web-mode-current-element-highlight-face ((t (:background ,bg-p2))))

       ;;;;;; Rainbow Delimiters
       (rainbow-delimiters-depth-1-face ((t (:foreground ,wave-aqua-2))))
       (rainbow-delimiters-depth-2-face ((t (:foreground ,crystal-blue))))
       (rainbow-delimiters-depth-3-face ((t (:foreground ,spring-blue))))
       (rainbow-delimiters-depth-4-face ((t (:foreground ,spring-green))))
       (rainbow-delimiters-depth-5-face ((t (:foreground ,carp-yellow))))
       (rainbow-delimiters-depth-6-face ((t (:foreground ,spring-violet-1))))
       (rainbow-delimiters-depth-7-face ((t (:foreground ,sakura-pink))))
       (rainbow-delimiters-depth-8-face ((t (:foreground ,wave-aqua-1))))
       (rainbow-delimiters-depth-9-face ((t (:foreground ,old-white))))
       (rainbow-delimiters-unmatched-face ((t (:foreground ,samurai-red :weight bold :inverse-video t))))
       (rainbow-delimiters-mismatched-face ((t (:foreground ,samurai-red :weight bold :inverse-video t))))
       (rainbow-delimiters-base-error-face ((t (:foreground ,samurai-red :weight bold))))

       ;;;;;; Flycheck & Flymake
       (flycheck-error ((t (:underline (:style wave :color ,diag-error)))))
       (flycheck-warning ((t (:underline (:style wave :color ,diag-warning)))))
       (flycheck-info ((t (:underline (:style wave :color ,diag-info)))))
       (flycheck-fringe-error ((t (:foreground ,diag-error :weight bold))))
       (flycheck-fringe-warning ((t (:foreground ,diag-warning :weight bold))))
       (flycheck-fringe-info ((t (:foreground ,diag-hint :weight bold))))
       (flycheck-error-list-error ((t (:foreground ,diag-error :weight bold))))
       (flycheck-error-list-warning ((t (:foreground ,diag-warning :weight bold))))
       (flycheck-error-list-info ((t (:foreground ,diag-info :weight bold))))

       (flymake-error ((t (:underline (:style wave :color ,diag-error)))))
       (flymake-warning ((t (:underline (:style wave :color ,diag-warning)))))
       (flymake-note ((t (:underline (:style wave :color ,diag-info)))))

       ;;;;;; LSP & Eglot
       (lsp-face-highlight-read ((t (:background ,bg-p2 :underline t))))
       (lsp-face-highlight-write ((t (:background ,bg-p2 :weight bold :underline t))))
       (lsp-face-highlight-textual ((t (:background ,bg-p2))))
       (lsp-headerline-breadcrumb-path-face ((t (:foreground ,katana-gray :background ,bg-m3))))
       (lsp-headerline-breadcrumb-symbols-face ((t (:foreground ,crystal-blue :background ,bg-m3 :weight bold))))
       (lsp-headerline-breadcrumb-separator-face ((t (:foreground ,katana-gray :background ,bg-m3))))
       (lsp-ui-doc-background ((t (:background ,bg-m3 :foreground ,fg))))
       (lsp-ui-doc-header ((t (:background ,bg-p1 :foreground ,crystal-blue :weight bold))))
       (lsp-ui-peek-peek ((t (:background ,bg-m2))))
       (lsp-ui-peek-list ((t (:background ,bg-m3))))
       (lsp-ui-peek-filename ((t (:foreground ,crystal-blue))))
       (lsp-ui-peek-line-number ((t (:foreground ,katana-gray))))
       (lsp-ui-peek-highlight ((t (:background ,bg-search :foreground ,fg))))
       (lsp-ui-peek-header ((t (:background ,bg-p1 :foreground ,fg :weight bold))))
       (lsp-ui-peek-selection ((t (:background ,wave-blue-1 :foreground ,crystal-blue :weight bold))))
       (lsp-ui-sideline-symbol ((t (:foreground ,katana-gray :slant italic))))
       (lsp-ui-sideline-current-symbol ((t (:foreground ,crystal-blue :weight bold))))
       (lsp-ui-sideline-code-action ((t (:foreground ,carp-yellow))))

       (eglot-highlight-symbol-face ((t (:background ,bg-p2 :underline t))))

       ;;;;;; Which-Key
       (which-key-key-face ((t (:foreground ,crystal-blue :weight bold))))
       (which-key-command-description-face ((t (:foreground ,fg))))
       (which-key-group-description-face ((t (:foreground ,wave-aqua-2 :weight bold))))
       (which-key-local-map-description-face ((t (:foreground ,carp-yellow))))
       (which-key-separator-face ((t (:foreground ,katana-gray))))
       (which-key-special-key-face ((t (:foreground ,sakura-pink :weight bold))))

       ;;;;;; Eldoc
       (eldoc-highlight-function-argument ((t (:foreground ,crystal-blue :weight bold :underline t))))

       ;;;;;; Anzu
       (anzu-mode-line ((t (:foreground ,crystal-blue :weight bold))))
       (anzu-match-1 ((t (:foreground ,crystal-blue :background ,bg-m1))))
       (anzu-match-2 ((t (:foreground ,spring-green :background ,bg-m1))))
       (anzu-match-3 ((t (:foreground ,carp-yellow :background ,bg-m1))))
       (anzu-replace-to ((t (:foreground ,spring-green :background ,diff-add))))
       (anzu-replace-highlight ((t (:foreground ,samurai-red :background ,diff-delete :strike-through t))))

       ;;;;;; Doom Modeline
       (doom-modeline-buffer-file ((t (:foreground ,crystal-blue :weight bold))))
       (doom-modeline-buffer-modified ((t (:foreground ,carp-yellow :weight bold))))
       (doom-modeline-project-dir ((t (:foreground ,wave-aqua-2 :weight bold))))
       (doom-modeline-bar ((t (:background ,crystal-blue))))
       (doom-modeline-evil-normal-state ((t (:foreground ,crystal-blue :weight bold))))
       (doom-modeline-evil-insert-state ((t (:foreground ,spring-green :weight bold))))
       (doom-modeline-evil-visual-state ((t (:foreground ,carp-yellow :weight bold))))
       (doom-modeline-evil-replace-state ((t (:foreground ,sakura-pink :weight bold))))
       (doom-modeline-evil-operator-state ((t (:foreground ,wave-aqua-2 :weight bold))))
       (doom-modeline-evil-emacs-state ((t (:foreground ,spring-violet-1 :weight bold))))
       (doom-modeline-evil-motion-state ((t (:foreground ,spring-blue :weight bold))))
       ))))

;; Define default vulkanite theme (wave variant)
(deftheme vulkanite "The Vulkanite theme (Wave variant), inspired by Kanagawa.")
(vulkanite-theme-apply 'vulkanite 'wave)
(provide-theme 'vulkanite)

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;;; ─────────────────────────────────────────────────────────────────────────
;;; Omarchy Dynamic Theme Sync
;;; ─────────────────────────────────────────────────────────────────────────

(defcustom vulkanite-omarchy-theme-name-file
  (expand-file-name "~/.local/state/omarchy/current/theme.name")
  "Path to the Omarchy current theme name file."
  :type 'file
  :group 'vulkanite-themes)

(defvar vulkanite--omarchy-theme-map
  '(("aura"            . vulkanite-aura)
    ("batou"           . vulkanite-batou)
    ("catppuccin"      . vulkanite-catppuccin)
    ("demon"           . vulkanite-demon)
    ("ethereal"        . vulkanite-ethereal)
    ("everforest"      . vulkanite-everforest)
    ("gruvbox"         . vulkanite-gruvbox)
    ("japan-night"     . vulkanite-japan-night)
    ("kanagawa"        . vulkanite-kanagawa)
    ("last-horizon"    . vulkanite-last-horizon)
    ("matrix"          . vulkanite-matrix)
    ("miasma"          . vulkanite-miasma)
    ("one-dark-pro"    . vulkanite-one-dark-pro)
    ("osaka-jade"      . vulkanite-osaka-jade)
    ("retro-82"        . vulkanite-retro-82)
    ("rose-pine-dark"  . vulkanite-rose-pine-dark)
    ("rose-pine"       . vulkanite-rose-pine-dark)
    ("solitude"        . vulkanite-solitude)
    ("terminus"        . vulkanite-terminus)
    ("tokyo-night"     . vulkanite-tokyo-night)
    ("tycho"           . vulkanite-tycho)
    ("vantablack"      . vulkanite-vantablack)
    ("vesper"          . vulkanite-vesper)
    ("aether"          . vulkanite-aether)
    ("dragon"          . vulkanite-dragon)
    ("vulkanite"       . vulkanite-wave)
    ("wave"            . vulkanite-wave))
  "Alist mapping omarchy theme names to vulkanite theme symbols.")

;;;###autoload
;;; vulkanite-theme
(defun vulkanite-sync-omarchy-theme ()
  "Load the Vulkanite theme that matches the current Omarchy theme.
Reads the theme name from `vulkanite-omarchy-theme-name-file' and
loads the corresponding vulkanite-* theme variant."
  (interactive)
  (if (not (file-readable-p vulkanite-omarchy-theme-name-file))
      (message "Vulkanite: omarchy theme.name file not found at %s"
               vulkanite-omarchy-theme-name-file)
    (let* ((name (string-trim (with-temp-buffer
                                (insert-file-contents vulkanite-omarchy-theme-name-file)
                                (buffer-string))))
           (theme (alist-get name vulkanite--omarchy-theme-map nil nil #'string=)))
      (if theme
          (progn
            (mapc #'disable-theme custom-enabled-themes)
            (load-theme theme t)
            (message "Vulkanite: loaded %s (omarchy: %s)" theme name))
        (message "Vulkanite: no mapping for omarchy theme '%s' — staying on current theme" name)))))

;;;###autoload
(defun vulkanite-watch-omarchy-theme ()
  "Set up a file-notify watcher so Emacs auto-syncs the Vulkanite theme
whenever the Omarchy theme changes (e.g. after Super+Alt+Space)."
  (interactive)
  (require 'filenotify)
  (when (file-readable-p vulkanite-omarchy-theme-name-file)
    (file-notify-add-watch
     vulkanite-omarchy-theme-name-file
     '(change)
     (lambda (_event)
       (run-with-timer 0.3 nil #'vulkanite-sync-omarchy-theme)))
    (message "Vulkanite: watching %s for omarchy theme changes"
             vulkanite-omarchy-theme-name-file)))

(provide 'vulkanite-theme)
;;; vulkanite-theme.el ends here
