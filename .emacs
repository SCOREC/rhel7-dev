; use melpa when we can
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  )
(prefer-coding-system 'utf-8)
(setq linum-format "%4d|")
(global-linum-mode t)
(define-key global-map (kbd "M-g") 'goto-line)

; make sure we have cc-mode, force *.h files to use c++ mode
(require 'cc-mode)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'company-complete)
(define-key c++-mode-map [(tab)] 'company-complete)

;(require 'consel-etags)
; don't ask before re-reading an updated TAGS file
(setq tags-revert-without-query t)
; do not warn when reading a large TAGS file
(setq large-file-warning-threshold nil)
; update TAGS automatically on save
(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      'counsel-etags-virtual-update-tags 'append 'local)))
; ignore the build directory and TAGS files
(eval-after-load 'counsel-etags
  '(progn
     (add-to-list 'counsel-etags-ignore-directories "build")
     (add-to-list 'counsel-etags-ignore-filenames "TAGS")))

; c/c++ formatting rules
(setq c-default-style "linux"
      c-basic-offset 2)
(c-set-offset 'substatement-open '0)
(c-set-offset 'inline-open '0)
(c-set-offset 'inextern-lang '0)
(c-set-offset 'label '*)
(c-set-offset 'case-label '*)
(c-set-offset 'access-lable '*)
(setq-default indent-tabs-mode nil)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(setq inhibit-startup-message t)
(setq-default show-trailing-whitespace t)
(modify-syntax-entry ?_ "w" c-mode-syntax-table)
(modify-syntax-entry ?_ "w" c++-mode-syntax-table)

; sh formating rules
(setq sh-basic-offset 2)
(setq sh-indentation 2)

; yasnippet c++ snippets to speed things up ; installed using melpa
; (require 'yasnippet)
; (yas-global-mode 1)

; cmake-mode and such
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))
(autoload 'cmake-mode (expand-file-name "cmake-mode.el" user-emacs-directory) t)

;whitespace http://www.emacswiki.org/emacs/WhiteSpace
(require 'whitespace)
; tabs are EVIL
; turn on white space mode for tabs
(setq whitespace-style '(tabs tab-mark))
; show whitespace at the end of lines as well
(global-whitespace-mode 1)

; auto-highlight-mode, highlight matching symbols in the same buffer
(require 'highlight-symbol)
(setq highlight-symbol-on-navigation t)
(setq highlight-symbol-idle-delay 0)
(define-globalized-minor-mode global-highlight-symbol highlight-symbol-mode
  (lambda () (highlight-symbol-mode 1)))
(global-highlight-symbol 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (counsel-etags magit yasnippet company highlight-symbol))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
