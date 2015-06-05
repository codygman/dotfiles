;; defining the list of packages I want
;; this is a change.
(require 'package)
(add-to-list 'package-archives
            '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar codygman-packages
  '(
    helm
    scala-mode2
    exec-path-from-shell
    ;; ace-jump-mode
    ;; auto-complete
    ;; circe        ;; replaced with rcirc
    ;; cl-lib
    ;; concurrent
    ;; ctable
    ;; dash
    ;; deferred
    ;; dpaste
    ;; epc
    ;; epl
    ;; f
    ;; flycheck
    ;; flycheck-color-mode-line
    ;; ghc
    ;; ghci-completion
    ;; git-gutter
    ;; haml-mode
    haskell-mode
    ;; jedi
    ;; json-mode
    ;; lcs
    ;; lui
    magit
    markdown-mode
    ;; multiple-cursors
    ;; pastebin
    ;; pivotal-tracker
    ;; pkg-info
    ;; popup
    ;; s
    ;; shorten
    solarized-emacs
    ;; tracking
    ;; pyvenv
    bind-key
    purescript-mode
    slime
   ) "A list of packages to ensure are installed at launch.")

;; http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
(setq url-http-attempt-keepalives nil)

(defun packages-installed-p ()
  (loop for p in codygman-packages
        when (not (el-get-package-installed-p p)) do (return nil)
        finally (return t)))

(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  ;; (package-refresh-contents) ;; not needed for el-get idt
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p codygman-packages)
    (when (not (package-installed-p p))
      (el-get-install p))))

