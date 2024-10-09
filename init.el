(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-electric-left-right-brace nil)
 '(LaTeX-math-list nil)
 '(TeX-clean-confirm t)
 '(TeX-command-extra-options "-shell-escape")
 '(TeX-electric-escape nil)
 '(TeX-view-evince-keep-focus t)
 '(TeX-view-program-list
   '(("Evince"
      ("/usr/local/bin/evince %o")
      "evince")
     ("EmacsDocView"
      ("emacsclient %o")
      "")))
 '(TeX-view-program-selection
   '((output-dvi "open")
     (output-pdf "PDF Tools")
     (output-html "open")))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#262626"))
 '(aw-scope 'frame)
 '(custom-safe-themes
   '("261a03733c20ebcf26e6f9533359977f3040a9aa10088727893ae4954369eb43" "ba4f725d8e906551cfab8c5f67e71339f60fac11a8815f51051ddb8409ea6e5c" default))
 '(display-line-numbers-type 'relative)
 '(fci-rule-color "#3a3a3a")
 '(global-display-line-numbers-mode t)
 '(hl-sexp-background-color "#121212")
 '(mode-require-final-newline nil)
 '(package-selected-packages
   '(mellow-theme melancholy-theme py-autopep8 ein solidity-mode pdf-tools undo-tree smartparens latex-preview-pane company-auctex tex-lacheck lacheck blacken flycheck elpy com\
pany-anaconda anaconda-mode auto-complete nlinum-relative magit ace-window outline-magic tex-buf yasnippet-snippets yasnippet use-package helm evil auctex))
 '(pdf-view-incompatible-modes
   '(linum-mode linum-relative-mode helm-linum-relative-mode nlinum-mode nlinum-hl-mode nlinum-relative-mode yalinum-mode))
 '(show-paren-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a")))
 '(vc-annotate-very-old-color nil))
(setq package-check-signature 'allow-unsigned)

(require 'package)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(setq doc-view-continuous t)
(package-initialize)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
  "[ \t\n]*$" "" (shell-command-to-string
  "$SHELL --login -c 'echo $PATH'"
    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

  (use-package tex
  :ensure auctex)
(use-package smartparens
  :ensure t)
(use-package helm
  :ensure t)
;(use-package pdf-tools
 ; :ensure t)
(use-package yasnippet
  :config
  (yas-reload-all)
  :ensure t)
(use-package company-auctex
  :ensure t)
(use-package outline-magic
  :ensure t)
(use-package latex-preview-pane
  :ensure t)
(use-package ace-window
  :ensure t)
(use-package solidity-mode
  :ensure t)
(use-package magit
  :ensure t)
(use-package py-autopep8
  :ensure t)
(use-package auto-complete
  :ensure t
  :config
  (auto-complete-mode)
  )
(use-package anaconda-mode
  :ensure t)
(use-package elpy
  :ensure t)
(use-package flycheck
  :ensure t)
(use-package ein
  :ensure t)
(use-package material-theme
  :ensure t)
(use-package blacken
  :ensure t)

;(require 'smartparens-config)
;(require 'flymake)
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")

(setq inhibit-startup-message t)
(load-theme 'material t)

;(pdf-tools-install)
(setq-default TeX-master nil)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

(auto-complete-mode)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "M-g") 'forward-whitespace)

(global-unset-key (kbd "M-p"))

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(set-default 'preview-scale-function 2)
(defun enable-latex-math-mode()
  (latex-math-mode)
  (setq line-spacing 0.3))
(defun pfs()
  (local-set-key (kbd "C-c C-g") 'pdf-sync-forward-search))
(add-hook 'LaTeX-mode-hook 'enable-latex-math-mode)
(add-hook 'LaTeX-mode-hook 'reftex-mode)
(add-hook 'LaTeX-mode-hook 'pfs)
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'LaTeX-mode-hook 'auto-complete-mode 1)
(add-hook 'LaTeX-mode-hook 'smartparens-mode 1)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;(add-hook 'LaTeX-mode-hook 'periodic-compile)
(add-hook 'LaTeX-mode-hook 'flycheck-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(setq TeX-command-force "LaTeX")
(setq LaTeX-beamer-item-overlay-flag nil)
;(add-hook 'flycheck-after-syntax-check-hook
;  (lambda()
;    ('TeX-run-command "latex-flycheck" "LaTeX" (TeX-master))
;    (interactive)
;    (call-interactively 'TeX-command-master)
;    )
;  )

(electric-pair-mode)

(setq ac-use-menu-map t)
;; Default for completion
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)


(server-start)
;(setq TeX-command-force nil)
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setenv "PKG_CONFIG_PATH" (concat (getenv "PKG_CONFIG_PATH") ":/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))

(setq TeX-save-query nil)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)

(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.


(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'company-anaconda)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-hook 'python-mode-hook 'auto-complete-mode 0)
(defun python-keys()
  (local-set-key (kbd "C-M-i") 'anaconda-mode-complete))
(add-hook 'python-mode-hook 'python-keys)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(add-hook 'python-mode-hook 'elpy-enable)

;; Key-binding for number increment
(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0-9")
      (or (looking-at "[0-9]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))
(global-set-key (kbd "C-c +") 'increment-number-at-point)


(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil
      python-shell-completion-native-enable nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")
;; join line to next line
(global-set-key (kbd "C-J") (lambda () (interactive) (join-line -1)))
;(define-key LaTeX-mode-map (kbd "C-J") (lambda () (interactive) (join-line -1)))
;(defun autocompile()
 ; (TeX-command-sequence t t))
  ;;(master-file (TeX-master-file))
  ;;(TeX-run-TeX "latexmk"
    ;;   (TeX-command-expand "latexmk -pdflatex='pdflatex -file-line-error -synctex=1'-pdf %s"
;;   'TeX-master-file)
;;   'TeX-master-file))
;;(add-hook 'after-save-hook 'autocompile)
