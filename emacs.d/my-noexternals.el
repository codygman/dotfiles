;; ~/.emacs.d/my-noexternals.el

;; Remove scrollbars, menu bars, and toolbars
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; no welcome
(setq inhibit-startup-message t)
;; no scratch text
(setq initial-scratch-message nil)

;; Wind-move
(global-set-key (kbd "C-c C-l") 'windmove-right)
(global-set-key (kbd "C-c C-j") 'windmove-down)
(global-set-key (kbd "C-c C-k") 'windmove-up)
(global-set-key (kbd "C-c C-h") 'windmove-left)

(global-set-key (kbd "C-c e b") 'eval-buffer)
(global-set-key (kbd "C-c r b") 'rename-buffer)
(global-set-key (kbd "C-c c r") 'comment-or-uncomment-region-or-line)

;; helpful functions for custom keybinds
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
