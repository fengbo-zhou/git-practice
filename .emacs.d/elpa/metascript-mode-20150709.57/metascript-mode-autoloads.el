;;; metascript-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "metascript-mode" "metascript-mode.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from metascript-mode.el

(autoload 'metascript-mode "metascript-mode" "\
A major mode for editing Metascript source files.

\(fn)" t nil)

(autoload 'metascript-repl "metascript-mode" "\
Launch or activate REPL.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . metascript-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "metascript-mode" '("metascript-" "inferior-metascript-repl-p" "flymake-metascript-init" "defmjsface")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; metascript-mode-autoloads.el ends here
