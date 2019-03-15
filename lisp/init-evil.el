;; init-evil.el --- Setup Evil.  

;;; Commentary:

;;; Code:
(use-package evil-anzu
  :ensure t)
(use-package evil
  :config
  (require 'evil-anzu)
  (evil-mode t)
  (progn
    (defun petmacs//evil-visual-shift-left ()
      "evil left shift without losing selection"
      (interactive)
      (call-interactively 'evil-shift-left)
      (evil-normal-state)
      (evil-visual-restore))

    (defun petmacs//evil-visual-shift-right ()
      "evil right shift without losing selection"
      (interactive)
      (call-interactively 'evil-shift-right)
      (evil-normal-state)
      (evil-visual-restore))
    ;; Overload shifts so that they don't lose the selection
    (define-key evil-visual-state-map (kbd "<") 'petmacs//evil-visual-shift-left)
    (define-key evil-visual-state-map (kbd ">") 'petmacs//evil-visual-shift-right)))

(provide 'init-evil)

;;; init-evil.el ends here

