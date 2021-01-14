;;; init-lsp-python.el ---                           -*- lexical-binding: t; -*-

;; Copyright (C) 2020  linyi

;; Author: linyi <linyi@ubu-born-0>
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

;; Python Mode
;; Install:
;;   pip install yapf
;;   pip install isort
;;   pip install autoflake
(use-package python
  :ensure nil
  :hook
  ((python-mode . (lambda ()
		    (setq-local flycheck-checkers '(python-pylint))
		    (pyvenv-mode 1)))
   (inferior-python-mode . (lambda ()
			     (process-query-on-exit-flag
			      (get-process "Python")))))
  :init
  ;; Disable readline based native completion
  (setq python-shell-completion-native-enable nil)

  :config
  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-env "PYTHONPATH"))

  (define-key inferior-python-mode-map (kbd "C-j") 'comint-next-input)
  (define-key inferior-python-mode-map (kbd "<up>") 'comint-next-input)
  (define-key inferior-python-mode-map (kbd "C-k") 'comint-previous-input)
  (define-key inferior-python-mode-map (kbd "<down>") 'comint-previous-input)
  (define-key inferior-python-mode-map
    (kbd "C-r") 'comint-history-isearch-backward))

(use-package py-isort)

(use-package pyvenv
  :preface
  ;; autoload virtual environment if project_root/.venv file exists,
  ;; .venv file only has the name of the virtual environment.
  (defun pyvenv-autoload ()
    (require 'projectile)
    (let* ((pdir (projectile-project-root)) (pfile (concat pdir ".venv")))
      (if (file-exists-p pfile)
          (pyvenv-workon (with-temp-buffer
                           (insert-file-contents pfile)
                           (nth 0 (split-string (buffer-string))))))))
  :hook (python-mode . pyvenv-autoload))

(use-package pipenv
  :commands (pipenv-activate
             pipenv-deactivate
             pipenv-shell
             pipenv-open
             pipenv-install
             pipenv-uninstall))
(use-package virtualenvwrapper)

;; Format using YAPF
;; Install: pip install yapf
(use-package yapfify
  :diminish yapf-mode
  :hook (python-mode . yapf-mode))

(if (member 'python-mode petmacs-lsp-active-modes)
    (progn
      (use-package lsp-python-ms
	:hook (pyvenv-mode . (lambda ()
			       (require 'lsp-python-ms)
			       (lsp-deferred)))
	:init
	(setq lsp-python-ms-auto-install-server t
	      lsp-python-ms-nupkg-channel "stable"))

      ;; ;; Python: pyright
      ;; ;; install pyright:  npm install -g pyright
      ;; ;; update pyright: npm update -g pyright
      ;; (use-package lsp-pyright
      ;; 	:hook (python-mode . (lambda () (require 'lsp-pyright))))
      )
  (progn
    (use-package anaconda-mode
      :defines anaconda-mode-localhost-address
      :diminish anaconda-mode
      :hook ((python-mode . anaconda-mode)
	     (python-mode . anaconda-eldoc-mode))
      :config
      ;; WORKAROUND: https://github.com/proofit404/anaconda-mode#faq
      (setq anaconda-mode-localhost-address "localhost"))

    (use-package company-anaconda
      :after company
      :defines company-backends
      :init (cl-pushnew 'company-anaconda company-backends)
      :config
      (evil-define-minor-mode-key 'normal 'anaconda-mode (kbd "C-M-i") 'company-anaconda)
      (evil-define-minor-mode-key 'insert 'anaconda-mode (kbd "C-M-i") 'company-anaconda))))

(provide 'init-lsp-python-pet)
(message "init-python loaded in '%.2f' seconds ..." (get-time-diff time-marked))
;;; init-lsp-python.el ends here