;; -*- lexical-binding: t; -*-
(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-fold-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…"
 org-modern-list 
  '((?+ . "+")
    (?- . "–")
    (?* . "•"))

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")
(use-package org
  :config
  (setq org-startup-indented t)
  (setq org-return-follows-link t)
  (setq org-startup-with-inline-images t)
  (setq org-image-actual-width nil)
  :mode ("\\.org\\'" . org-mode))
(use-package org-contrib
  :after org)
(use-package ox-clip
  :after org)
(use-package org-cliplink
  :after org)
(use-package org-modern
  :after org
  :init (global-org-modern-mode))
(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-tag "subject")))
(use-package org-roam
  :after org
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n")
       :unnarrowed t)))
  (org-roam-directory "~/org-roam")
  
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :init
  (org-roam-db-autosync-mode)
  (my/org-roam-refresh-agenda-list))
