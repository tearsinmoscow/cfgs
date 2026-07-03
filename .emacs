(setq display-time-default-load-average nil
      tab-width 4
      inhibit-splash-screen t
      display-line-numbers-type 'relative)
(global-completion-preview-mode 1)
(display-time-mode 1)
(ido-mode 1)
(ido-everywhere 1)
(electric-pair-mode)
(custom-set-faces
 '(font-lock-keyword-face ((t (:foreground "#d96bff")))))
(add-to-list 'default-frame-alist '(background-color . "#181818"))
(add-to-list 'default-frame-alist '(foreground-color . "#d8d8d8"))
(menu-bar-mode 0)
(global-display-line-numbers-mode)
