;;; init-eshell.el ---                               -*- lexical-binding: t; -*-

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

(use-package eshell
  :ensure nil
  :defines (compilation-last-buffer eshell-prompt-function)
  :commands (eshell/alias
             eshell-send-input eshell-flatten-list
             eshell-interactive-output-p eshell-parse-command)
  :hook ((eshell-mode . (lambda ()
                          (bind-key "C-l" 'petmacs/eshell-clear eshell-mode-map)))
	 (eshell-mode  . (lambda () (display-line-numbers-mode -1)(hl-line-mode -1)))
	 (eshell-after-prompt . petmacs//protect-eshell-prompt)
	 )
  :preface
  (defun petmacs/eshell-clear ()
    "Clear the eshell buffer."
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))

  (defun petmacs//protect-eshell-prompt ()
    "Protect Eshell's prompt like Comint's prompts.

E.g. `evil-change-whole-line' won't wipe the prompt. This
is achieved by adding the relevant text properties."
    (let ((inhibit-field-text-motion t))
      (add-text-properties
       (point-at-bol)
       (point)
       '(rear-nonsticky t
			inhibit-line-move-field-capture t
			field output
			read-only t
			front-sticky (field inhibit-line-move-field-capture)))))
  :init
  ;; add alias to eshell
  (setq eshell-aliases-file (expand-file-name "alias" user-emacs-directory))
  )

(use-package eshell-prompt-extras
  :ensure t
  :custom-face
  (epe-pipeline-delimiter-face ((t (:foreground "#fd780f" :weight bold))))
  (epe-pipeline-host-face ((t (:foreground "#3cd8a2" :weight bold))))
  (epe-pipeline-time-face ((t (:foreground "#e2c504"))))
  (epe-pipeline-user-face ((t (:foreground "#ef2d2d" :weight bold))))
  :init
  (with-eval-after-load "esh-opt"
    ;; (require 'virtualenvwrapper)
    ;; (venv-initialize-eshell)
    (autoload 'epe-theme-pipeline "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          ;; add new line adhead of tty
          eshell-prompt-function (lambda ()
                                   (concat "\n" (epe-theme-pipeline))))))

;; Fish-like history autosuggestions
;; disable because of lagging
;; (use-package esh-autosuggest
;;   :pin melpa-stable
;;   :defines ivy-display-functions-alist
;;   :preface
;;   (defun setup-eshell-ivy-completion ()
;;     (setq-local ivy-display-functions-alist
;;                 (remq (assoc 'ivy-completion-in-region ivy-display-functions-alist)
;; 		      ivy-display-functions-alist)))
;;   :bind (:map eshell-mode-map
;; 	      ([remap eshell-pcomplete] . completion-at-point))
;;   :hook ((eshell-mode . esh-autosuggest-mode)
;;          (eshell-mode . setup-eshell-ivy-completion)))

;; Eldoc support
(use-package esh-help
  :ensure t
  :init (setup-esh-help-eldoc))

;; `cd' to frequent directory in eshell
(use-package eshell-z
  :ensure t
  :hook (eshell-mode . (lambda () (require 'eshell-z))))

(provide 'init-eshell)
(message "init-eshell loaded in '%.2f' seconds ..." (get-time-diff time-marked))
;;; init-eshell.el ends here