;;; init-eglot.el ---                                -*- lexical-binding: t; -*-

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

;; (use-package eglot
;;   :ensure t
;;   :config
;;   (define-key c++-mode-map (kbd "gd") 'xref--find-definitions))
(defvar ddavis-clangd-exe (executable-find "clangd")
  "clangd executable path")

(defun dd/projectile-proj-find-function (dir)
  (let ((root (projectile-project-root dir)))
    (and root (cons 'transient root))))

(use-package eglot
  :ensure t)

(defun dd/cpp-eglot-enable ()
  "enable variables and hooks for eglot cpp IDE"
  (interactive)
  (setq company-backends
        (cons 'company-capf
              (remove 'company-capf company-backends)))
  (with-eval-after-load 'project
    (add-to-list 'project-find-functions
                 'dd/projectile-proj-find-function))
  (add-to-list 'eglot-server-programs
               `((c++-mode) ,ddavis-clangd-exe))
  (add-hook 'c++-mode-hook 'eglot-ensure))

(defun dd/cpp-eglot-disable ()
  "disable hook for eglot"
  (interactive)
  (remove-hook 'c++-mode-hook 'eglot-ensure))

(provide 'init-eglot)
(message "init-eglot loaded in '%.2f' seconds ..." (get-time-diff time-marked))
;;; init-eglot.el ends here
