(load "/home/cody/.emacs.d/my-loadpackages.el")
;; ummm this isn't working
(add-hook 'after-init-hook '(lambda ()
			      (load "~/.emacs.d/my-noexternals.el")))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(defalias 'yes-or-no-p 'y-or-n-p)
(setq org-startup-truncated nil)

(global-set-key (kbd "C-c e b") 'eval-buffer)
(global-set-key (kbd "C-c r b") 'rename-buffer)
(global-set-key (kbd "C-c c r") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c r s") 'replace-string)


(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
      '(lambda()
          (local-set-key (kbd "C-l") 'eshell-clear-buffer)))
