;;; init-dired.el ---                                -*- lexical-binding: t; -*-

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

(eval-when-compile
  (require 'init-const))

;; (defun vinegar/up-directory (&optional other-window)
;;   "Run Dired on parent directory of current directory."
;;   (interactive "P")
;;   (let* ((dir (dired-current-directory))
;;          (orig (current-buffer))
;;          (up (file-name-directory (directory-file-name dir))))
;;     (or (dired-goto-file (directory-file-name dir))
;;         ;; Only try dired-goto-subdir if buffer has more than one dir.
;;         (and (cdr dired-subdir-alist)
;;              (dired-goto-subdir up))
;;         (progn
;;           (kill-buffer orig)
;;           (dired up)
;;           (dired-goto-file dir)))))

;; Directory operations
(use-package dired
  :ensure nil
  :hook 
  (dired-mode . dired-omit-mode)
  ;; (dired-mode . evil-motion-state)	;fixed "/" search, but ret/gg/Sg not working, suggest to use ranger
  :preface
  (defun unicorn/dired-goto-parent-directory ()
    "go up a level using same buffer"
    (interactive)
    (find-alternate-file ".."))

  :config
  ;; Always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  (when (eq system-type 'windows-nt)
    ;; Suppress the warning: `ls does not support --dired'.
    (setq dired-use-ls-dired nil)

    (when (executable-find "gls")
      ;; Use GNU ls as `gls' from `coreutils' if available.
      (setq insert-directory-program "gls")))

  (when (or (and (eq system-type 'darwin) (executable-find "gls"))
            (and (not (eq system-type 'darwin)) (executable-find "ls")))
    ;; Using `insert-directory-program'
    (setq ls-lisp-use-insert-directory-program t)
    ;; Show directory first
    (setq dired-listing-switches "-alh --group-directories-first"))

  (evil-define-key 'normal dired-mode-map (kbd "RET") 'dired-find-alternate-file) 
  ;; was dired-up-director
  (evil-define-key 'normal dired-mode-map (kbd "C-u") 'unicorn/dired-goto-parent-directory)
  ;; kill current buffer when leaving dired mode
  (evil-define-key 'normal dired-mode-map (kbd "q") 'kill-this-buffer)
  :init
  (put 'dired-find-alternate-file 'disabled nil))

;; Quick sort dired buffers via hydra
(use-package dired-quick-sort
  :ensure t
  :bind (:map dired-mode-map
              ("S" . hydra-dired-quick-sort/body)))

;; bind with all-the-icons
(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode)
  :init
  (require 'font-lock+))

(use-package diredfl			; add colorful to dired mode list
  :ensure t
  :init
  (diredfl-global-mode 1))

(use-package dired-aux :ensure nil)
(use-package dired-x
  :ensure nil
  :demand
  :config
  (let ((cmd (cond
              ((and (display-graphic-p) (eq system-type 'darwin)) "open")
              ((and (display-graphic-p) (eq system-type 'gnu/linux)) "xdg-open")
              ((eq system-type 'windows-nt) "start")
              (t ""))))
    (setq dired-guess-shell-alist-user
          `(("\\.pdf\\'" ,cmd)
            ("\\.docx\\'" ,cmd)
            ("\\.\\(?:djvu\\|eps\\)\\'" ,cmd)
            ("\\.\\(?:jpg\\|jpeg\\|png\\|gif\\|xpm\\)\\'" ,cmd)
            ("\\.\\(?:xcf\\)\\'" ,cmd)
            ("\\.csv\\'" ,cmd)
            ("\\.tex\\'" ,cmd)
	    ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,cmd)
            ("\\.\\(?:mp3\\|flac\\)\\'" ,cmd)
            ("\\.html?\\'" ,cmd)
            ("\\.md\\'" ,cmd))))

  (setq dired-omit-files
        (concat dired-omit-files
                "\\|^.DS_Store$\\|^.projectile$\\|^.git$\\|^.svn$\\|^.vscode$\\|\\.js\\.meta$\\|\\.meta$\\|\\.elc$\\|^.emacs.*")))

;; (use-package ranger
;;   :ensure t
;;   :commands (ranger deer deer-jump-other-window ranger-override-dired-mode)
;;   :init
;;   (setq ranger-cleanup-on-disable t)
;;   (setq ranger-show-hidden t)
;;   (setq ranger-parent-depth 1)
;;   (setq ranger-width-parents 0.12)
;;   (setq ranger-ignored-extensions '("mkv" "iso" "mp4"))
;;   ;; set the max files size (in MB) to preview
;;   (setq ranger-max-preview-size 5)
;;   ;; allow '-' to enter ranger
;;   (define-key evil-normal-state-map (kbd "-") 'deer)
;;   :config
;;   ;; (define-key ranger-mode-map (kbd "-") 'ranger-up-directory)
;;   (define-key ranger-mode-map (kbd "-") 'dired-jump)
;;   (define-key ranger-mode-map (kbd "C-u") 'vinegar/up-directory)
;;   (define-key ranger-mode-map (kbd "+") 'dired-create-directory)
;;   (define-key ranger-mode-map (kbd "m") 'ranger-mark)
;;   (define-key ranger-mode-map (kbd "q") 'quit-window)
;;   (define-key ranger-mode-map (kbd "f") 'ranger-travel))

(provide 'init-dired)
(message "init-dired loaded in '%.2f' seconds" (get-time-diff time-marked))
;;; init-dired.el ends here
