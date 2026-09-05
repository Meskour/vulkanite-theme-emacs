;;; vulkanite-matrix-theme.el --- Vulkanite Matrix theme -*- lexical-binding: t -*-

;; Copyright (C) 2026
;; Author: Mohamed Meskour
;; Keywords: themes faces

;; Palette sourced from the Omarchy Matrix theme.

;;; Code:

(require 'vulkanite-theme)

(deftheme vulkanite-matrix
  "The Vulkanite Matrix theme — absolute void black with CRT phosphor green (Omarchy Matrix).")

(vulkanite-theme-apply 'vulkanite-matrix 'matrix)

(provide-theme 'vulkanite-matrix)

;;; vulkanite-matrix-theme.el ends here
