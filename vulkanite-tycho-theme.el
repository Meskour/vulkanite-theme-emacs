;;; vulkanite-tycho-theme.el --- Vulkanite Tycho theme -*- lexical-binding: t -*-

;; Copyright (C) 2026
;; Author: Mohamed Meskour
;; Keywords: themes faces

;; Palette sourced from the Omarchy Tycho theme by Leonardo Betti
;; (https://github.com/leonardobetti/omarchy-tycho)
;; Colors: warm charcoal dark (#1e2125) with dusty rose, terracotta & mauve accents.

;;; Code:

(require 'vulkanite-theme)

(deftheme vulkanite-tycho
  "The Vulkanite Tycho theme — warm charcoal dark with dusty rose, \
terracotta, and lavender-mauve accents, faithfully ported from the \
Omarchy Tycho desktop theme.")

(vulkanite-theme-apply 'vulkanite-tycho 'tycho)

(provide-theme 'vulkanite-tycho)

;;; vulkanite-tycho-theme.el ends here
