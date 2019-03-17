;;; init-highlight.el ---                            -*- lexical-binding: t; -*-

;; Copyright (C) 2019  

;; Author:  <peter.linyi@DESKTOP-PMTGUNT>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(mark-time-here)

(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;; Highlight symbols
(use-package symbol-overlay
  :ensure t
  :diminish
  :functions (symbol-overlay-switch-first symbol-overlay-switch-last)
  :commands (symbol-overlay-get-symbol
             symbol-overlay-assoc
             symbol-overlay-get-list
             symbol-overlay-jump-call)
  :hook ((prog-mode . symbol-overlay-mode))
  :config
  (global-set-key (kbd "M-i") 'symbol-overlay-put)
  (global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
  (global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
  (global-set-key (kbd "<f7>") 'symbol-overlay-mode)
  (global-set-key (kbd "M-c") 'symbol-overlay-remove-all)
  ;; (global-set-key (kbd "<f8>") 'symbol-overlay-remove-all)

  ;; remap help tooltip keybinding from h to H in symbol-overlay-map
  (define-key symbol-overlay-map (kbd "h") 'evil-backward-char)
  (define-key symbol-overlay-map (kbd "H") 'symbol-overlay-map-help))

(use-package highlight-indent-guides
  :ensure t
  ;; :defer t
  :hook (((python-mode yaml-mode) . highlight-indent-guides-mode)
         (highlight-indent-guides-mode . (lambda ()
                                           (set-face-foreground 'highlight-indent-guides-character-face "#8f9091")
                                           (set-face-foreground 'highlight-indent-guides-top-character-face "#fe5e10"))))
  :config
  (progn
    (setq highlight-indent-guides-method 'character
          
          highlight-indent-guides-character ?\┆ ;; candidates: , ⋮, ┆, ┊, ┋, ┇
          highlight-indent-guides-responsive 'top
          highlight-indent-guides-auto-enabled nil
          highlight-indent-guides-auto-character-face-perc 10
          highlight-indent-guides-auto-top-character-face-perc 20)))

;; Highlight matching paren
(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t)
  (setq show-paren-when-point-in-periphery t))

;; Highlight TODO and similar keywords in comments and strings
(use-package hl-todo
  :ensure t
  :custom-face (hl-todo ((t (:box t :inherit 'hl-todo))))
  :bind (:map hl-todo-mode-map
              ([C-f3] . hl-todo-occur)
              ("C-c t p" . hl-todo-previous)
              ("C-c t n" . hl-todo-next)
              ("C-c t o" . hl-todo-occur))
  :hook (after-init . global-hl-todo-mode)
  :config
  (dolist (keyword '("BUG" "DEFECT" "ISSUE"))
    (cl-pushnew `(,keyword . ,(face-foreground 'error)) hl-todo-keyword-faces))
  (dolist (keyword '("WORKAROUND" "HACK" "TRICK"))
    (cl-pushnew `(,keyword . ,(face-foreground 'warning)) hl-todo-keyword-faces)))

(provide 'init-highlight)
(message "init-highlight loaded in '%.2f' seconds ..." (get-time-diff time-marked))
;;; init-highlight.el ends here