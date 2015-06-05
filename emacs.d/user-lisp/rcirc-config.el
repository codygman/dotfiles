;; rcirc config
;; You can autoload, but at the end of this block we'll
;; connect to two networks anyway.
(require 'rcirc)

;; Don't print /away messages.
;; This does not require rcirc to be loaded already,
;; since rcirc doesn't define a 301 handler (yet).
;; (defun rcirc-handler-301 (process cmd sender args)
;;   "/away message handler.")

;; Turn on spell checking.
(add-hook 'rcirc-mode-hook (lambda ()
			     (flyspell-mode 1)))

;; Keep input line at bottom.                                                                               
;; (add-hook 'rcirc-mode-hook
;; 	  (lambda ()
;; 	    (set (make-local-variable 'scroll-conservatively)
;; 		 8192)))

;; Turn on logging everything to a special buffer, for debugging.
;; (setq rcirc-debug-flag t)

;; Adjust the colours of one of the faces.
;; (set-face-foreground 'rcirc-my-nick "red" nil)

;; Set typeface for rcirc buffers; this example uses variable-width Verdana size 10
(dolist (rcirc-face (remove-if-not 
		     (lambda (elt) (equal (cadr elt) 'custom-face))
		     (get 'rcirc-faces 'custom-group)))
  (set-face-font (car rcirc-face) "verdana-10"))

;; Include date in time stamp.
(setq rcirc-time-format "%Y-%m-%d %H:%M ")

;; Change user info
(setq rcirc-default-nick "codygman")
(setq rcirc-default-user-name "codygman")
(setq rcirc-default-full-name "codygman")

;; ignore these messages
(setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))

(defadvice rcirc (before rcirc-read-from-authinfo activate)
  "Allow rcirc to read authinfo from ~/.authinfo.gpg via the auth-source API.
This doesn't support the chanserv auth method"
  (unless arg
    (dolist (p (auth-source-search :port '("nickserv" "bitlbee" "quakenet")
                                   :require '(:port :user :secret)))
      (let ((secret (plist-get p :secret))
            (method (intern (plist-get p :port))))
        (add-to-list 'rcirc-authinfo
                     (list (plist-get p :host)
                           method
                           (plist-get p :user)
                           (if (functionp secret)
                               (funcall secret)
                             secret)))))))


;; rcirc logging
;; (setq rcirc-log-filename-function 'rcirc-generate-log-filename-1
(setq rcirc-log-directory "~/.rcirc-logs"
      rcirc-log-flag t
      rcirc-log-process-buffers t)


;; Join these channels at startup.
(setq rcirc-server-alist
      '(("irc.freenode.net" :channels ("#emacs" "#rcirc" "#haskell" "#http4s" "#scala" "#idris" "#nothaskell" "#snowdrift" "#haskell-game" "#elisp" "#nixos"))))

;; Connect to servers.
;; (rcirc-connect "irc.freenode.net")
;; (rcirc-connect "localhost"); if you run bitlbee, this will connect to it
