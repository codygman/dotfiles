;; loading and configuring packages
(load "~/.emacs.d/my-packages.el")

(exec-path-from-shell-copy-env "ANDROID_HOME")

;; emacs base package configs
;; todo enable this where *ONLY* useful
;; (electric-indent-mode +1)

;; maybe needed if python electric ident doesn't work right
;;; Indentation for python

;; Ignoring electric indentation
;; (defun electric-indent-ignore-python (char)
;;   "Ignore electric indentation for python-mode"
;;   (if (equal major-mode 'python-mode)
;;       `no-indent'
;;     nil))
;; (add-hook 'electric-indent-functions 'electric-indent-ignore-python)

;; ;; Enter key executes newline-and-indent
;; (defun set-newline-and-indent ()
;;   "Map the return key with `newline-and-indent'"
;;   (local-set-key (kbd "RET") 'newline-and-indent))
;; (add-hook 'python-mode-hook 'set-newline-and-indent)

;; installed package configs

(require 'helm-config)
(helm-mode 1)

(require 'solarized-theme)
(load-theme 'solarized-dark t)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'golden-ratio)
(golden-ratio-mode 1)

(require 'magit)
(define-key global-map (kbd "C-c g s") 'magit-status)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'scala-mode2)

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
  '(haskell-process-show-debug-tips f)
)

;; TODO: Only load when Java file open
;; (add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;; TODO: For some reason this isn't loading jde....
;; (add-hook 'java-mode-hook '(lambda ()
;; 			     (load "jde")
;; 			     (setq jde-complete-function 'jde-complete-minibuf)))
;; (load "jde")
;; (setq jde-complete-function 'jde-complete-minibuf) ;; helm completition

(require 'gradle-mode)
(gradle-mode 1) ;; just enable it for now since I installed a newer version on system
;; TODO: Use gradlew when possible
;; this is wrong because it happens on activation og gradle-mode
;; (setq gradle-executable-path
;;       (let ((gradlew-path (expand-file-name "gradlew" default-directory)))
;; 	(if (file-exists-p gradlew-path) gradlew-path (executable-find "gradle"))))

(require 'uniquify) 
(setq uniquify-buffer-name-style 'forward)

;; (require 'org-mode)
;; (setq org-todo-keywords
;;       (quote ((sequence "TODO(t)" "|" "ABANDONED(b)" "DONE(d)"))))
;; (setq org-log-done t)

;; allow haskell code blocks in org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((haskell . t)))

(load "~/.emacs.d/org-mode-agenda-customizations.el")
;; (require 'yasnippet)
;; (yas-global-mode 1)
;; (yas-load-directory "~/.emacs.d/snippets")
;; (add-hook 'term-mode-hook (lambda()
;;     (setq yas-dont-activate t)))


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
