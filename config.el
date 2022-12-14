;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jahan PD"
      user-mail-address "jahan.pd@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
; :weight "semi-light" :weight "semi-light";

;; (setq doom-theme 'gruvbox-dark-hard)
(setq doom-theme 'doom-horizon)
(setq doom-font (font-spec :family "Monofur Nerd Font Mono" :size 13 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Monofur Nerd Font" :size 13 :weight 'normal)
      doom-big-font (font-spec :family "Monofur Nerd Font Mono" :size 18))

(setq doom-font-increment 1)


(if (eq system-type 'darwin)
  ; something for OS X if true
  ; optional something if not
(setq langtool-language-tool-jar "/opt/homebrew/opt/languagetool/libexec/languagetool-commandline.jar")
)

(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'markdown-mode-hook 'variable-pitch-mode)
(setq markdown-header-scaling t)
(custom-set-faces
 '(markdown-header-face ((t (:inherit doom-variable-pitch-font))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.4 :weight bold))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.0))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.0))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.0)))))


;; create function to set bibliography libraries with citar based on project
(use-package citar
  :bind (("C-c b" . citar-insert-citation)
         :map minibuffer-local-map
         ("M-b" . citar-insert-preset)))

(use-package request)


(defun set-bib-files (depth)
  "Function to set bib files as library for citar"
  (interactive "nHow many folders to move up before recursive search for *\.bib$- 0 for the default-directory?")
  (setq citar-bibliography (directory-files-recursively (mapconcat (lambda (x) (concat x "/")) (butlast (split-string default-directory "/") depth) "") "\.bib$" nil t nil))
  (message "New Library: %s" citar-bibliography)
)

;; keymaps to allow vim movements in insert mode with control
(define-key evil-insert-state-map (kbd "C-h") 'evil-backward-char)
(define-key evil-insert-state-map (kbd "C-j") 'evil-next-line)
(define-key evil-insert-state-map (kbd "C-k") 'evil-previous-line)
(define-key evil-insert-state-map (kbd "C-l") 'evil-forward-char)
(define-key evil-normal-state-map  (kbd "<SPC>l") 'evil-switch-to-windows-last-buffer)

;; org-caldav settings
(setq org-caldav-url "http://calendar.jahan/radicale/jahan/")
(setq org-caldav-calendar-id "82e79a76-4f8f-d616-a3ed-6e853c592435")
(setq org-caldav-inbox "~/org/cal.org")
(setq org-caldav-files '("~/org/agenda.org" "~/org/exercise.org"))

(setq org-icalendar-include-todo 'all
      org-caldav-sync-todo t)
(setq org-icalendar-categories '(local-tags))
(setq org-caldav-todo-percent-states
      '((0 "TODO")
       (1 "STARTED")
       (100 "DONE")
       (100 "PROJ"))
)

;; org roam settings
(use-package org-roam
  :custom
  (setq org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         )
  )
(org-roam-db-autosync-mode)
