(require 'package)
;; load autoload files and populate load-path’s
(package-initialize)
;; store load-path
(setq luna-dumped-load-path load-path
      luna-dumped t)
;; (package-initialize) doens’t require each package, we need to load
;; those we want manually
(dolist (package '(use-package org org-contrib ox-clip org-cliplink
		    org-modern org-roam modus-themes good-scroll which-key
		    general vertico doom-modeline corfu projectile
		    goto-chg evil evil-collection flyspell flyspell-correct
		    savehist marginalia))
  (require package))

;; pre-load themes
(load-theme 'modus-vivendi t t)
(load-theme 'modus-operandi t t)
;; dump image
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")
