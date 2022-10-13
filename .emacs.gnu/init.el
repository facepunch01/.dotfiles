;; -*- no-byte-compile: t;lexical-binding: t -*-
(defvar doom--file-name-handler-alist file-name-handler-alist)
(require 'package)
(with-eval-after-load 'package (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq file-name-handler-alist nil)
(add-to-list 'default-frame-alist '(font . "Iosevka Comfy")) 
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(require 'use-package)
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
  ;; add load-path’s and load autoload files
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
(setq inhibit-startup-message t)
(require 'bind-key)
(require 'map)
(use-package bind-key
  :demand t)
(use-package auto-compile
  :demand t
  :init
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))
(setq vc-follow-symlinks t)
(add-to-list 'load-path "~/.dotfiles/.emacs.gnu")
(defun my/dashboard-banner ()
  """Set a dashboard banner including information on package initialization
   time and garbage collections."""
  (setq dashboard-banner-logo-title
        (format "Emacs ready in %.2f seconds with %d garbage collections."
                (float-time (time-subtract after-init-time before-init-time)) gcs-done)))
 
(use-package page-break-lines
  :demand t
  :init
  (page-break-lines-mode))
(use-package dashboard
  :demand t
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
  :defer t)


(load "ui")
(load "complete")
(load "keys")
(load "org-config")
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
  :demand t
  :config
  (gcmh-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(benchmark-init which-key vertico use-package rainbow-delimiters projectile page-break-lines ox-clip org-roam org-modern org-contrib org-cliplink modus-themes marginalia good-scroll general gcmh flyspell-correct evil-org evil-collection doom-modeline dashboard corfu auto-compile all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
