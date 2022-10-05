;; -*- lexical-binding: t -*-
(use-package good-scroll
  :config
  (good-scroll-mode 1))
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))
(use-package modus-themes)
 
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

