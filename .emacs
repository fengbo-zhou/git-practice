

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq byte-compile-warnings '(cl-functions))
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; Add ELPA packages to the loadpp path
(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))

;; Ensure use-package is installed and loaded
(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))

;; Let use-package install all packages mentioned if they're not
;; already installed.
(setq use-package-always-ensure t)


(display-time)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)


(require 'which-key)
(which-key-mode)
;; Allow C-h to trigger which-key before it is done automatically
(setq which-key-show-early-on-C-h t)
;; make sure which-key doesn't show normally but refreshes quickly after it is
;; triggered.
(setq which-key-idle-delay 10000)
(setq which-key-idle-secondary-delay 0.05)
(define-key which-key-mode-map (kbd "C-x <f5>") 'which-key-C-h-dispatch)
(which-key-mode)

;;setting up theme
(load-theme 'dracula t)

(setq visible-bell t)
(setq inhibit-startup-message t)
(mouse-avoidance-mode 'animate)
(setq default-tab-width 4)
(setq-default indent-tabs-mode t)
(blink-cursor-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;;setting up the line number
(global-linum-mode 1)
(set-face-foreground 'linum "#10E3CA")

;;setting up the paren matching
(show-paren-mode 1)
;; highlight brackets
(setq show-paren-style 'parenthesis)
;; highlight entire expression
(setq show-paren-style 'expression)
;; highlight brackets if visible, else entire expression
(setq show-paren-style 'mixed)
(setq show-paren-delay 0)
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(fset 'yes-or-no-p 'y-or-n-p)

(setq frame-title-format '(:eval (or (buffer-file-name) (buffer-name))))


;;(setq default-frame-alist '((top . 25) (left . 500) (height . 90) (width . 180) (font . "Monospace-10" ))) 
;;(set-fontset-font "fontset-default" 'gb18030 '("Microsoft YaHei" . "unicode-bmp"))
;;(setq my-default-text-scale-height 110)
;;(set-face-attribute 'default nil :height 150)

;; Set Frame width/height
(setq default-frame-alist '((top . 25) (left . 725) (width . 130) (height . 90)))
(set-face-attribute 'default nil :height 140)
(set-fontset-font "fontset-default" 'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

(set-face-background 'mode-line "#4466aa")

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))

;; mode-line-buffer-identification: highlight with color, without key map
(setq-default mode-line-buffer-identification
              (list (propertize "%b" 'face '(:foreground "black" :background "yellow"))))

;; mode-line-position: total line, percent, size, point position
;; when region selected, size becomes char count
(setq-default mode-line-position
              (list '(:eval
                      (let ((lines (count-lines (point-min) (point-max))))
                        (propertize
                         (format "%dL" lines)
                         'help-echo (format "Total %d lines" lines))))
                    (propertize
                     " %p"
                     'local-map mode-line-column-line-number-mode-map
                     'mouse-face 'mode-line-highlight
                     'help-echo "Size indication mode\nmouse-1: Display Line and Column Mode Menu")
                    (if size-indication-mode
                        '(:eval
                          (propertize
                           (if (and transient-mark-mode mark-active)
                               (format " %d chars" (- (region-end) (region-beginning)))
                             " %I")
                           'face (and transient-mark-mode mark-active 'region)
                           'local-map mode-line-column-line-number-mode-map
                           'mouse-face 'mode-line-highlight
                           'help-echo "Size indication mode\nmouse-1: Display Line and Column Mode Menu")))
                    (if line-number-mode
                        (if column-number-mode
                            (propertize
                             " (%l,%c)"
                             'local-map mode-line-column-line-number-mode-map
                             'mouse-face 'mode-line-highlight
                             'help-echo "Line number and Column number\nmouse-1: Display Line and Column Mode Menu")
                          (propertize
                           " L%l"
                           'local-map mode-line-column-line-number-mode-map
                           'mouse-face 'mode-line-highlight
                           'help-echo "Line Number\nmouse-1: Display Line and Column Mode Menu"))
                      (if column-number-mode
                          (propertize
                           " C%c"
                           'local-map mode-line-column-line-number-mode-map
                           'mouse-face 'mode-line-highlight
                           'help-echo "Column number\nmouse-1: Display Line and Column Mode Menu")))))

(setq default-major-mode 'java-mode)
;;(setq-default auto-fill-function 'do-auto-fill)

(setq transient-mark-mode t)

(setq-default kill-whole-line t)
(setq kill-ring-max 200)

;; emacs clipboard can be used outside
(setq x-select-enable-clipboard t)

;; indicating the end of the sentence
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(setq make-backup-files nil)

;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode java-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))


(defun smart-beginning-of-line ()
  "If the point is not on beginning of current line, move point
to beginning of current line, as 'beginning-of-line' does.
If the point already is on the beginning of current line, then
move the point to the first non-space character, if it exists."
  (interactive)
  (if (not (eq (point) (line-beginning-position)))
      (beginning-of-line)
    (when (re-search-forward "[^[:blank:]　]" (line-end-position) t)
      (backward-char))))
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

(defun kill-empty-lines ()
  "Kill all the empty lines in region or delete blank lines."
  (interactive)
  (if (and transient-mark-mode mark-active)
      (progn
        (message "Killing lines in region...")
        (let ((beginning (region-beginning))
              (end (region-end)))
          (save-excursion
            (goto-char beginning)
            (while (re-search-forward "^[[:blank:]　]*$" end t)
              (beginning-of-line)
              (kill-line)))))
    (delete-blank-lines)))
(global-set-key (kbd "C-x C-o") 'kill-empty-lines)


;;setting up gradle
;;(require 'gradle-mode)
;;(add-hook 'java-mode-hook '(lambda() (gradle-mode 1)))

;;(global-set-key [f5]
;;  (lambda () (interactive)
;;    (let ((buf (buffer-file-name)))
;;      (compile (concat "javac -Xlint " buf))
;;      (compile (concat "java " (file-name-sans-extension buf)))
;;      )))
 
(global-set-key [f5] 'quickrun-shell)

;;(add-to-list 'load-path
;;              "~/.emacs.d/plugins/yasnippet")
;;(require 'yasnippet)
;;(yas-global-mode 1)
(add-to-list 'load-path
              "~/.emacs.d/plugins/template-3.3b")
(require 'template)
(global-set-key (kbd "C-x C-a") 'template-new-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dracula-theme java-snippets yasnippet-classic-snippets yasnippet-snippets yatemplate quickrun gradle-mode spacemacs-theme ws-butler which-key use-package smex multiple-cursors ido-vertical-mode ido-completing-read+ helm-swoop helm-projectile gtags flycheck flx-ido expand-region counsel beacon ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

