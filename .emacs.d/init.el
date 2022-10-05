;; -*- no-byte-compile: t;lexical-binding: t -*-
(defvar doom--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font Mono")) 
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
(setq load-prefer-newer noninteractive)
(setq column-number-mode t)
(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)
(setq native-comp-async-report-warnings-errors 'nil)
(setq frame-inhibit-implied-resize t)
(defvar bootstrap-version)
;;(setq straight-check-for-modifications '(check-on-save find-when-checking))
(setq straight-check-for-modifications nil)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default '1)
(use-package benchmark-init
  :disabled
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
(setq inhibit-startup-message t)
(require 'bind-key)
(require 'map)
(use-package bind-key)
(use-package auto-compile
  :init
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))
(setq vc-follow-symlinks t)
(add-to-list 'load-path "~/.dotfiles/.emacs.d")
(defun my/dashboard-banner ()
  """Set a dashboard banner including information on package initialization
   time and garbage collections."""
  (setq dashboard-banner-logo-title
        (format "Emacs ready in %.2f seconds with %d garbage collections."
                (float-time (time-subtract after-init-time before-init-time)) gcs-done)))
 
(use-package page-break-lines
  :init
  (page-break-lines-mode))
(use-package dashboard
  :init
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  (add-hook 'dashboard-mode-hook 'my/dashboard-banner)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
	dashboard-center-content t))
(setq modus-themes-mode-line '(borderless))
(load-theme 'modus-operandi t)
(use-package all-the-icons
  :if (display-graphic-p)
  :defer)


(load "ui")
(load "complete")
(load "keys")
(load "org")
(autoload '+org/return "autoload" "org return")
(autoload '+org/dwim-at-point "autoload" "org dwim")
(autoload '+org/shift-return "autoload" "org shift-return")
(autoload 'launch-separate-emacs-in-terminal "autoload" "launch")
(autoload 'launch-separate-emacs-under-x "autoload" "launch")
(autoload 'restart-emacs "autoload" "restart emacs")


(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-x p" . projectile-command-map)))

(setq file-name-handler-alist doom--file-name-handler-alist)
(use-package gcmh
  :config
  (gcmh-mode 1))
