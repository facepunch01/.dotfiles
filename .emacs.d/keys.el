;; -*- lexical-binding: t; -*-
(recentf-mode 1)
(setq evil-want-keybinding nil)
(use-package goto-chg)
(use-package evil
  :after goto-chg
  :config
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  (evil-mode 1))
(use-package evil-collection
  :init
  (evil-collection-init))
(use-package general
  :config
  (general-evil-setup t)

  (general-create-definer my-leader-keys
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer file-menu
    :prefix "SPC f")
  (general-create-definer org-menu
    ;; :prefix my-local-leader
    :prefix "SPC o")
  (general-create-definer roam-org-menu
    :prefix "SPC r")
  (general-create-definer quit-menu
    :prefix "SPC q"))
(my-leader-keys
  :states 'normal
  "p" 'projectile-command-map
  "a" 'org-agenda
  ":" 'execute-extended-command)
(file-menu
  :states 'normal
  "f" 'find-file
  "r" 'delete-file
  "d" 'dired
  "j" 'dired-jump) 
(org-menu
  :states 'normal
  :keymaps 'org-mode-map
  "l" 'org-insert-link
  "k" 'org-move-item-up
  "j" 'org-move-item-down
  "o" '+org/dwim-at-point)
(global-set-key (kbd "<f5>") (lambda () (interactive) (find-file "~/org-roam/20220914215450-index.org")))

(quit-menu
  :states 'normal
  "q" 'kill-emacs
  "w" 'quit-window
  "r" 'restart-emacs)
(roam-org-menu
  :states 'normal
  :keymaps 'org-mode-map
  "f" 'org-roam-node-find
  "i" 'org-roam-node-insert
  "l" 'org-roam-buffer-toggle)
(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
  (evil-org-agenda-set-keys))

