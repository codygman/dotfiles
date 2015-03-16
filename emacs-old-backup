(require 'package)
(add-to-list 'package-archives
             ;; '("marmalade" . "http://marmalade-repo.org/packages/")
	     '("melpa" . "http://melpa.milkbox.net/packages/"))

(setq inhibit-splash-screen t)

(let ((cabal-path (expand-file-name "~/.cabal/bin")))
 (add-to-list 'exec-path cabal-path)
 (setenv "PATH" (concat cabal-path ":" (getenv "PATH"))))

(setenv "ANDROID_HOME" "/home/cody/android-sdk-linux")
(setenv "ANDROID_SDK_HOME" "/home/cody/android-sdk-linux") 



(transient-mark-mode t)

(setq deactivate-mark nil)

(add-to-list 'load-path "~/.emacs.d/el-get/")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(add-hook 'after-init-hook '(lambda ()
  (load "~/.emacs.d/my-packages.el")))

(package-initialize)

;; use string regex syntax to avoid escaping and backslash madness
(setq reb-re-syntax 'string)

;; uniquify
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buf

;; ;; C-x b term mode
;; (add-hook 'term-mode-hook
;;    (lambda ()
;;      ;; C-x is the prefix command, rather than C-c
;;      (term-set-escape-char ?\C-x)
;;      (define-key term-raw-map "\M-y" 'yank-pop)
;;      (define-key term-raw-map "\M-w" 'kill-ring-save)))

;; keyboard shortcuts

(global-set-key (kbd "C-c a r") 'align-regexp)
(global-set-key (kbd "C-c r r") 'replace-regexp)
(global-set-key (kbd "C-c r b") 'rename-buffer)
(global-set-key (kbd "C-c e b") 'eval-buffer)
(global-set-key (kbd "C-c c r") 'comment-or-uncomment-region-or-line)
;; (global-set-key (kbd "C-c u r") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c r s") 'replace-string)
(global-set-key (kbd "C-c g s") 'magit-status)


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

;; RET rebinds
(add-hook 'lisp-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

;; set re default mode to string syntax
(setq reb-re-syntax 'string)

;; slime stuff
(setq inferior-lisp-program "/usr/bin/sbcl")

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(ido-mode t)

(load-theme 'solarized-dark t)

(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "/home/cody/.emacs.d/elpa/auto-complete-1.4/dict")

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers	

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)


;; lisp/elisp
(show-paren-mode 1)
;; (setq show-paren-style 'expression) ; highlight entire bracket expression

;; python
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-hook 'python-mode-hook 'pyvenv-mode)
;; (setq jedi:setup-keys t)                      ; optional
;; (setq jedi:complete-on-dot t)                 ; optional

;; haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(defun pretty-lambdas-haskell ()
  (font-lock-add-keywords
   nil `((,(concat "\\(" (regexp-quote "\\") "\\)")
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))
(add-hook 'haskell-mode-hook 'pretty-lambdas-haskell)
(setq haskell-font-lock-symbols t)

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
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(pivotal-api-token "43565d5095f0e07dc594b40c93fbaac5"))

(setq
 python-shell-interpreter "python")
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code
;;    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; clojure
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)


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

;; my custom stuff
;; (set-face-attribute 'default nil :font "Inconsolata-13")
(defalias 'yes-or-no-p 'y-or-n-p)
;; (fset 'yes-or-no-p 'y-or-n-p)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; load password
(load-file "~/.private.el")

(setq circe-network-options
      `(("Freenode"
	 :nick "codygman"
	 :channels ("#emacs" "#django" "#go-nuts"
		    "#debian" "#restframework" "#bumblebee"
		    "#steamlug" "#bumblebee" 
		    "#haskell" "#xmonad" "#haskell-game" "#happs"
		    "#nothaskell")
	 :nickserv-password, freenode-password
	 )
	("Debian"
	 :host "irc.debian.org"
	 :nick "codygman"
	 :channels ("#debian-backports")
	 ))
      )

(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t) 
        (backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))

;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

;; plugin settings
;; (require 'evil-leader)
;; (global-evil-leader-mode)
;; (evil-leader/set-leader ",")

;; (evil-leader/set-key
;;   "e" 'find-file
;;   "b" 'switch-to-buffer
;;   "k" 'kill-buffer
;;   "c" 'ace-jump-char-mode
;;   "w" 'ace-jump-word-mode
;;   "l" 'ace-jump-line-mode
;;   "x" 'eval-buffer)

;; (require 'evil)
;; (evil-mode 1)


;; add manually installed/my packages
;; (add-to-list 'load-path "/home/cody/.emacs.d/other-packages/")
;;(load "tramp-virtualenv/tramp-virtualenv.el")


;; CSS color values colored by themselves
;; http://news.ycombinator.com/item?id=873541
(defvar hexcolor-keywords
  '(("#[abcdef[:digit:]]+"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))

(defun hexcolor-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolor-keywords))

(add-hook 'lisp-interaction-mode 'hexcolor-add-to-font-lock)
(add-hook 'emacs-lisp-mode-hook 'hexcolor-add-to-font-lock)
(put 'erase-buffer 'disabled nil)


;; scala

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; gimp mode
(load "/home/cody/.emacs.d/custom-install/gimpmode/gimp-init.el")

;; Uncomment following line to globally use `gimp-selector':
;; (global-set-key "\C-cg" 'gimp-selector)


;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
         '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

(defun kibit-current-file ()
  "Run kibit on the current file.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile (concat "lein kibit " buffer-file-name)))
