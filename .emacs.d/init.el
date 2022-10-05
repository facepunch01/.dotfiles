;; -*- no-byte-compile: t; -*-
(set-face-attribute 'default nil :family "Iosevka" :height 110)
(defvar bootstrap-version)
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
(setq native-comp-async-report-warnings-errors 'nil)
(setq straight-use-package-by-default '1)
(use-package gcmh
  :config
  (gcmh-mode 1))
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
(setq load-prefer-newer noninteractive)
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
(setq inhibit-startup-message t)
(require 'bind-key)
(require 'map)
(use-package bind-key)
(use-package auto-compile
  :init
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))
(setq vc-follow-symlinks t)
(add-to-list 'load-path "~/.macdots/.emacs.d")

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1) 
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
	dashboard-center-content t))
(setq modus-themes-mode-line '(borderless))
(load-theme 'modus-operandi t)
(global-display-line-numbers-mode)
(setq column-number-mode t)
(use-package all-the-icons
  :if (display-graphic-p)
  :defer)


(load "ui")
(load "complete")
(load "keys")
(load "org")
(autoload '+org/return "org-autoload.el" "org return")
(autoload '+org/dwim-at-point "org-autoload.el" "org dwim")
(autoload '+org/shift-return "org-autoload.el" "org shift-return")
(autoload 'launch-separate-emacs-in-terminal "keys-autoload")
(autoload 'launch-separate-emacs-under-x "keys-autoload")
(autoload 'restart-emacs "keys-autoload" "restart emacs")


(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-x p" . projectile-command-map)))


(use-package esup
  :commands esup)
