(require 'package)
(require 'cl)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar required-packages
  '(
    solarized-theme
    helm
    haskell-mode
    magit
    rcirc
    yasnippet
    nix-mode
    ace-jump-mode
    undo-tree
    golden-ratio
    android-mode
    emacs-eclim
    exec-path-from-shell
    scala-mode2
    ensime
    gradle-mode
    markdown-mode
  ) "a list of packages to ensure are installed at launch.")


;; todo download eclipse for eclim
;; eclipse 3.8

;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(getenv "PATH")
(require 'exec-path-from-shell)
(exec-path-from-shell-copy-env "ANDROID_HOME")

