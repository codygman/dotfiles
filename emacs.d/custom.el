;; (require 'color-theme-solarized)
;; (color-theme-solarized)

(let ((cabal-path (expand-file-name "~/.cabal/bin")))
 (add-to-list 'exec-path cabal-path)
 (setenv "PATH" (concat cabal-path ":" (getenv "PATH"))))

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buf

;; misc
(setq inhibit-splash-screen t)
(ido-mode t)
;; highlight code in color in org files
(setq org-src-fontify-natively t)
;; show free keys
(load-theme 'solarized-dark)

;; helm
(require 'helm-config)
(helm-mode 1)

;; keyboard shortcuts
;; helm
;; (global-set-key (kbd "M-x") 'helm-M-x) ;; this is already done?
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; misc
;; (global-set-key (kbd "C-c a r") 'align-regexp)
(global-set-key (kbd "C-c r r") 'replace-regexp)
(global-set-key (kbd "C-c r b") 'rename-buffer)
(global-set-key (kbd "C-c e b") 'eval-buffer)
(global-set-key (kbd "C-c c r") 'comment-or-uncomment-region-or-line)
;; (global-set-key (kbd "C-c u r") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c r s") 'replace-string)
(global-set-key (kbd "C-c g s") 'magit-status)


;; environment variables
(setenv "ANDROID_HOME" "/home/cody/android-sdk-linux")
(setenv "ANDROID_SDK_HOME" "/home/cody/android-sdk-linux") 

;; how to backup
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; my functions
(defun comment-or-uncomment-region-or-line ()
  "Like comment-or-uncomment-region, but if there's no mark \(that means no
region\) apply comment-or-uncomment to the current line"
  (interactive)
  (if (not mark-active)
      (comment-or-uncomment-region
       (line-beginning-position) (line-end-position))
    (if (< (point) (mark))
        (comment-or-uncomment-region (point) (mark))
      (comment-or-uncomment-region (mark) (point)))))

;; mode init/customizations
(require 'haskell)
(require 'haskell-mode)
(require 'haskell-interactive-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)


(defun haskell-who-calls (&optional prompt)
  "Grep the codebase to see who uses the symbol at point."
  (interactive "P")
  (let ((sym (if prompt
                 (read-from-minibuffer "Look for: ")
               (haskell-ident-at-point))))
    (let ((existing (get-buffer "*who-calls*")))
      (when existing
        (kill-buffer existing)))
    (let ((buffer
           (grep-find (format "cd %s && find . -name '*.hs' -exec grep -inH -e %s {} +"
                              (haskell-session-current-dir (haskell-session))
                              sym))))
      (with-current-buffer buffer
        (rename-buffer "*who-calls*")
        (switch-to-buffer-other-window buffer)))))

;; ghci-ng stuff
;; (setq haskell-process-args-cabal-repl
;;       '("--ghc-option=-ferror-spans" "--with-ghc=ghci-ng"))
;; (setq haskell-process-path-ghci "ghci-ng")

(define-key interactive-haskell-mode-map (kbd "M-.") 'haskell-mode-goto-loc)
(define-key interactive-haskell-mode-map (kbd "C-?") 'haskell-mode-find-uses)
(define-key interactive-haskell-mode-map (kbd "C-c C-t") 'haskell-mode-show-type-at)
(define-key interactive-haskell-mode-map (kbd "M-,") 'haskell-who-calls)

(setq haskell-program-name "nix-repl --pure --command \"ghci\"")
(setq haskell-stylish-on-save t)

(load-file "/home/cody/.emacs.d/user-lisp/hindent.el")
(add-hook 'haskell-mode-hook #'hindent-mode)


;; lisp
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
(setq slime-contribs '(slime-fancy))



(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
                'set-default)
            ',variable ,value))

(csetq ediff-window-setup-function 'ediff-setup-windows-plain)
(csetq ediff-split-window-function 'split-window-horizontally)

;; purescript
(require 'purescript-mode-autoloads)

;; TODO: use ~ and expand it or whatever the elisp idiom is
;; TODO: should I use eval-after-load? What is it for?
(load-file "/home/cody/.emacs.d/user-lisp/rcirc-config.el")
(load-file "~/.emacs.d/user-lisp/org-mode-day-planner.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;### (autoloads nil nil ("init.el") (21865 21318 228161 266000))

;;;***
