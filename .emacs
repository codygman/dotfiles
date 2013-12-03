(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers	     

;; globals
(global-git-gutter-mode t)

;; root ssh stuff
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; my custom stuff
(set-face-attribute 'default nil :font "Inconsolata-13")
(fset 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode 0)
(menu-bar-mode 0)
(put 'erase-buffer 'disabled nil)

;;; load password
(load-file "~/.private.el")

(setq circe-network-options
      `(("Freenode"
	 :nick "codygman"
	 :channels ("#emacs" "#django" "#go-nuts"
		    "#debian" "#restframework" "#bumblebee"
		    "#steamlug" "#bumblebee" "#haskell" "#xmonad")
	 :nickserv-password, freenode-password
	 )))

(defun irc ()
  "Connect to IRC."
  (interactive)
  (circe "Freenode")
  (circe "Bitlbee"))


;; plugin settings
(require 'ido)
(ido-mode t)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'solarized)
(load-theme 'solarized-dark t)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20130724.1750/dict")
(ac-config-default)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c CS-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-x a r") 'align-regexp)
;; (global-set-key (kbd "C-x e p") 'eval-print-last-sexp)

;; haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; (when (load
;;       (expand-file-name "~/.emacs.d/elpa/ac-python/ac-python.el")))
;; (require 'ac-python)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(pivotal-api-token "43565d5095f0e07dc594b40c93fbaac5"))

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(require 'info-look)

(info-lookup-add-help
 :mode 'python-mode
 :regexp "[[:alnum:]_]+"
 :doc-spec
 '(("(python)Index" nil "")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
