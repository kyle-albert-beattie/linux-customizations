;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
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
(setq doom-theme 'ef-frost)
;;(setq load-theme 'ef-frost-theme)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; enable clipboard in emacs
(setq x-select-enable-clipboard t)

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
(require 'org)
(require 'package)
(require 'matlab)
(require 'flyspell-lazy)
(require 'vmd-mode)
(require 'ess-r-mode)
(require 'ox-latex)
(require 'ox-html)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(use-package flyspell-lazy)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
(org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (org . t)
     (latex . t)
     (emacs-lisp . t)
     (bash . t)))

(add-hook 'latex-mode-hook 'visual-line-mode)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This will automatically write any code that is in an org file to a separate file as a copy any time the file is saved
(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

;; This will automatically export an org file as html any time it is saved.
(defun my-org-export-to-html ()
  (when (eq major-mode 'org-mode)
    (org-html-export-to-html)))

(add-hook 'after-save-hook 'my-org-export-to-html)

(setq use-package-always-ensure t)
(setq flyspell-large-region 1)
(flyspell-lazy-mode 1)


(setq org-reveal-root "file:///media/kyle/4B/Tutoring/reveal.js")

(use-package ess)
(use-package matlab)

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)

(setq company-selection-wrap-around t
      company-tooltip-align-annotations t
      company-idle-delay 0.45
      company-minimum-prefix-length 3
      company-tooltip-limit 10)

 (setq x-select-enable-clipboard-manager t)

;; Make the current line of text red;;
(defun highlight-current-line-red ()
  "Turn the current line of text red."
  (interactive)
  (let ((overlay (make-overlay (line-beginning-position) (line-end-position))))
    (overlay-put overlay 'face '(:foreground "red"))))

;; Make a line bold and underlined
(defun bold-underline-current-line ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (insert (format "%s" "*_"))
    (end-of-line)
    (insert (format "%s" "_*"))))

;; Make a line bold and italicized
(defun bold-italicize-current-line ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (insert (format "%s" "*/"))
    (end-of-line)
    (insert (format "%s" "/*"))))

;; Insert a + before each line which will make the lines a bullet point list
(defun insert-x-before-each-line (beg end)
  "Insert '+' before each line in the region"
  (interactive "r")
  (save-excursion
    (narrow-to-region beg end)
    (goto-char (point-min))
    (while (not (eobp))
      (insert "+ ")
      (forward-line 1)))
      (widen))

;; Insert a + before each line which will make the lines a bullet point list
(defun insert-1-before-each-line (beg end)
  "Insert '1' before each line in the region"
  (interactive "r")
  (save-excursion
    (narrow-to-region beg end)
    (goto-char (point-min))
    (while (not (eobp))
      (insert "1. ")
      (forward-line 1)))
      (widen))

;; Turn a link into a clickable link
(defun url-to-html-link(input)
  "Convert INPUT url into a html link. The link text will be the text after the last slash or you can end the url with a | and add text after that"
  (let ((split-on-| (split-string input "|"))
    (split-on-/ (split-string input "/"))
    (fmt-string "<a href=\"%s\">%s</a>"))
    (if (> (length split-on-|) 1)
      (format fmt-string (first split-on-|) (second split-on-|))
      (format fmt-string input (first (last split-on-/))))))

;; Turn a region into a clickable link
(defun url-region-to-html-link(b e)
  (interactive "r")
  (let ((link
     (url-to-html-link (buffer-substring-no-properties b e))))
    (delete-region b e)
    (insert link)))

;; Duplicate lines Function
(defun duplicate-lines (arg)
  (interactive "P")
  (let* ((arg (if arg arg 1))
         (beg (save-excursion (beginning-of-line) (point)))
         (end (save-excursion (end-of-line) (point)))
         (line (buffer-substring-no-properties beg end)))
    (save-excursion
      (end-of-line)
      (open-line arg)
      (setq num 0)
      (while (< num arg)
        (setq num (1+ num))
        (forward-line 1)
        (insert line)))))

;; Paste the boilerplate of an org document
(defun paste-static-text ()
  "Begins an org document with all necessary title information"
  (interactive)
  (insert "#+TITLE:
#+AUTHOR: Kyle A. Beattie
#+EMAIL: kbeattie@ualberta.ca
#+DATE: September 27, 2024
#+DESCRIPTION:
#+OPTIONS: H:3
#+HTML_HEAD_EXTRA: <style>body { font-size: 24px; }</style>
#+LATEX_HEADER: \mode<beamer>{\u0073setheme{Goettingen}}
#+KEYWORDS:
#+LANGUAGE: en"))

;; Paste today's date
(defun insert-date ()
  (interactive)
  (insert (format-time-string "%A %B %d, %Y")))

;; Add a square root symbol with a line
(defface sqrt-delimiter '((t :height 0.1))
"Face for the curly braces around square roots.")
(defface sqrt-symbol '((t :family "Iosevka"))
"Face for the square root symbol.")
(defun insert-sqrt ()
(font-lock-add-keywords
 'org-mode
 '(("√" (0 'sqrt-symbol))
   ("√\\({\\)\\([^}\n]*\\)\\(}\\)"
    (1 '(:overline t :inherit sqrt-delimiter)) (2 '(:overline t))
    (3 '(:overline t :inherit sqrt-delimiter))))))

;; Co-Pilot Autocomplete AI
(defun copilot-complete ()
  (interactive)
  (let* ((spot (point))
         (inhibit-quit t)
         (curfile (buffer-file-name))
         (cash (concat curfile ".cache"))
         (hist (concat curfile ".prompt"))
         (lang (file-name-extension curfile))
         ;; extract current line, to left of caret
         ;; and the previous line, to give the llm
         (code (save-excursion
                 (dotimes (i 2)
                   (when (> (line-number-at-pos) 1)
                     (previous-line)))
                 (beginning-of-line)
                 (buffer-substring-no-properties (point) spot)))

         ;; create new prompt for this interaction
         (system "\
You are an Emacs code generator. \
Writing comments is forbidden. \
Writing test code is forbidden. \
Writing English explanations is forbidden. ")
         (prompt (format
                  "[INST]%sGenerate %s code to complete:[/INST]\n```%s\n%s"
                  (if (file-exists-p cash) "" system) lang lang code)))

    ;; iterate text deleted within editor then purge it from prompt
    (when kill-ring
      (save-current-buffer
        (find-file hist)
        (dotimes (i 10)
          (let ((substring (current-kill i t)))
            (when (and substring (string-match-p "\n.*\n" substring))
              (goto-char (point-min))
              (while (search-forward substring nil t)
                (delete-region (- (point) (length substring)) (point))))))
        (save-buffer 0)
        (kill-buffer (current-buffer))))

    ;; append prompt for current interaction to the big old prompt
    (write-region prompt nil hist 'append 'silent)

    ;; run llamafile streaming stdout into buffer catching ctrl-g
    (with-local-quit
      (call-process "wizardcoder-python-34b-v1.0.Q5_K_M.llamafile"
                    nil (list (current-buffer) nil) t
                    "--prompt-cache" cash
                    "--prompt-cache-all"
                    "--silent-prompt"
                    "--temp" "0"
                    "-c" "1024"
                    "-ngl" "35"
                    "-r" "```"
                    "-r" "\n}"
                    "-f" hist))

    ;; get rid of most markdown syntax
    (let ((end (point)))
      (save-excursion
        (goto-char spot)
        (while (search-forward "\\_" end t)
          (backward-char)
          (delete-backward-char 1 nil)
          (setq end (- end 1)))
        (goto-char spot)
        (while (search-forward "```" end t)
          (delete-backward-char 3 nil)
          (setq end (- end 3))))

      ;; append generated code to prompt
      (write-region spot end hist 'append 'silent))))

;; Add the ability to duplicate lines with a keybinding
(global-set-key (kbd "C-S-o") 'duplicate-lines)

;; This is an alternative latex class for articles with a more modern look
(add-to-list 'org-latex-classes
          '("koma-article"
            "\\documentclass{scrartcl}"
            ("\\section{%s}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; This is a very simple tool for running an org-file as a
;; presentation.

;;; Code:

(require 'org)
(require 'eimp)
(require 'cl)

(defun org-pres--eimp-fit ()
  "Function used as a hook, fits the image found to the window."
  (when (eq major-mode (quote image-mode))
    (eimp-fit-image-to-window nil)))

;; the exact path may differ --- check it
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(defun org-pres-next ()
  "Next 'slide'."
  (interactive)
  (if (save-excursion
        (let ((bol (beginning-of-line)))
          (when bol
            (goto-char bol))
        (looking-at "^\\*+")))
      (progn
        (call-interactively 'org-cycle)
        (next-line)
        (show-branches)
        (save-excursion
          (let ((next-outline
                 (save-excursion
                   (next-line)
                   (re-search-forward "^\\*[^*]" nil 't))))
            (when (re-search-forward
                   "\\[\\[.*\\.\\(jpg\\|gif\\|png\\)" next-outline t)
              (org-open-at-point)
              (other-window -1)))))
      (hide-subtree)
      (re-search-forward "^\\*+" nil nil)
      (show-branches)))

;;;###autoload
(define-minor-mode org-pres-mode
    "Turn on Org Presentation mode.

Treats a single org file as a list of top level 'slides',
'opening' each one in turn (and closing the previous one).

A postive prefix argument forces this mode on, a negative prefix
argument forces this mode off; otherwise the mode is toggled."
  nil
  "PRES"
  '(([?\x20]   . org-pres-next))
  (unless (eq major-mode 'org-mode)
    (error "only works with org-mode!"))
  (visual-line-mode t)
  (add-hook 'find-file-hook 'org-pres--eimp-fit))

(provide 'org-presie)

;;; org-presie.el ends here


;; (default +bindings +smartparens))

;; eradio Settings

(use-package eradio
  :init
  (setq eradio-player '("vlc" "--no-video" "--no-terminal"))
  :config
  (setq eradio-channels '(("Infowars" . "https://banned.video/watch?id=5b92a1e6568f22455f55be2b")
                           ("Suburbs of Goa" . "https://somafm.com/suburbsofgoa.pls")
                           ("Cafe Tropical" . "https://zeno.fm/radio/cafe-tropical/")
                           ("420 Radio" . "https://zeno.fm/radio/420-radio/")
                           ("Binaural-Beats-FM" . "https://zeno.fm/radio/mulaFM/")
                           ("Radio America 1540AM" . "https://zeno.fm/radio/radio-america-1540am-master-input-station-app/")
                           ("Night Scans Radio" . "https://zeno.fm/radio/night-scans-radio/")
                           ("XTRA 106.3 Conservative Talk Radio" . "https://zeno.fm/radio/1230-106-3fm-master-station-8214/")
                           ("Time Business News" . "https://zeno.fm/radio/time-business-news/")
                           ("Hacker FM" . "https://zeno.fm/radio/hackerfm/")
                           ("KBVR Oregon State University Radio, Corvalis" . "https://zeno.fm/radio/kbvr-fm/")
                           ("English Radio" . "https://zeno.fm/radio/english-listen/")
                           ("Revolution Radio Studio B" . "https://www.streamingthe.net/Revolution-Radio-Studio-B/p/37700/live"))))


;; Key Bindings

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
(global-unset-key (kbd "C-z"))

(use-package general
  :config
  (general-evil-setup)

;; set up 'SPC' as the global leader key
  (general-create-definer dt/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (dt/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find file")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "TAB TAB" '(comment-line :wk "Comment lines")
    "u" '(universal-argument :wk "Universal argument"))

  (dt/leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    "b b" '(switch-to-buffer :wk "Switch to buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-current-buffer :wk "Kill current buffer")
    "b K" '(kill-some-buffers :wk "Kill multiple buffers")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b u" '(bold-underline-current-line :wk "Make line bold underline")
    "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

  (dt/leader-keys
     "c" '(paste-static-text :wk "Paste org Title Boilerplate")
     "c d" '(insert-date :wk "Insert today's date")
    )

  (dt/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d f" '(wdired-finish-edit :wk "Writable dired finish edit")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d p" '(peep-dired :wk "Peep-dired")
    "d w" '(wdired-change-to-wdired-mode :wk "Writable dired"))

  (dt/leader-keys
    "e" '(:ignore t :wk "Ediff/Eshell/Eval/EWW")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e f" '(ediff-files :wk "Run ediff on a pair of files")
    "e F" '(ediff-files3 :wk "Run ediff on three files")
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e R" '(eww-reload :which-key "Reload current page in EWW")
    "e s" '(eshell :which-key "Eshell")
    "e w" '(eww :which-key "EWW emacs web wowser"))

  (dt/leader-keys
    "f" '(:ignore t :wk "Files")
    "f c" '((lambda () (interactive)
              (find-file "~/.config/emacs/config.org"))
            :wk "Open emacs config.org")
    "f e" '((lambda () (interactive)
              (dired "~/.config/emacs/"))
            :wk "Open user-emacs-directory in dired")
    "f d" '(find-grep-dired :wk "Search for string in files in DIR")
    "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
    "f i" '((lambda () (interactive)
              (find-file "~/.config/emacs/init.el"))
            :wk "Open emacs init.el")
    "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
    "f l" '(counsel-locate :wk "Locate a file")
    "f r" '(counsel-recentf :wk "Find recent files")
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f U" '(sudo-edit :wk "Sudo edit file"))

  (dt/leader-keys
    "g" '(:ignore t :wk "Git")
    "g /" '(magit-displatch :wk "Magit dispatch")
    "g ." '(magit-file-displatch :wk "Magit file dispatch")
    "g b" '(magit-branch-checkout :wk "Switch branch")
    "g c" '(:ignore t :wk "Create")
    "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
    "g c c" '(magit-commit-create :wk "Create commit")
    "g c f" '(magit-commit-fixup :wk "Create fixup commit")
    "g C" '(magit-clone :wk "Clone repo")
    "g f" '(:ignore t :wk "Find")
    "g f c" '(magit-show-commit :wk "Show commit")
    "g f f" '(magit-find-file :wk "Magit find file")
    "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
    "g F" '(magit-fetch :wk "Git fetch")
    "g g" '(magit-status :wk "Magit status")
    "g i" '(magit-init :wk "Initialize git repo")
    "g l" '(magit-log-buffer-file :wk "Magit buffer log")
    "g r" '(vc-revert :wk "Git revert file")
    "g s" '(magit-stage-file :wk "Git stage file")
    "g t" '(git-timemachine :wk "Git time machine")
    "g u" '(magit-stage-file :wk "Git unstage file"))

 (dt/leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" '(counsel-apropos :wk "Apropos")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h c" '(describe-char :wk "Describe character under cursor")
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" '(about-emacs :wk "About Emacs")
    "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
    "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "h d m" '(info-emacs-manual :wk "The Emacs manual")
    "h d n" '(view-emacs-news :wk "View Emacs news")
    "h d o" '(describe-distribution :wk "How to obtain Emacs")
    "h d p" '(view-emacs-problems :wk "View Emacs problems")
    "h d t" '(view-emacs-todo :wk "View Emacs todo")
    "h d w" '(describe-no-warranty :wk "Describe no warranty")
    "h e" '(view-echo-area-messages :wk "View echo area messages")
    "h f" '(describe-function :wk "Describe function")
    "h F" '(describe-face :wk "Describe face")
    "h g" '(describe-gnu-project :wk "Describe GNU Project")
    "h i" '(info :wk "Info")
    "h I" '(describe-input-method :wk "Describe input method")
    "h k" '(describe-key :wk "Describe key")
    "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
    "h L" '(describe-language-environment :wk "Describe language environment")
    "h m" '(describe-mode :wk "Describe mode")
    "h r" '(:ignore t :wk "Reload")
    "h r r" '((lambda () (interactive)
                (load-file "~/.config/emacs/init.el")
                (ignore (elpaca-process-queues)))
              :wk "Reload emacs config")
    "h t" '(load-theme :wk "Load theme")
    "h v" '(describe-variable :wk "Describe variable")
    "h w" '(where-is :wk "Prints keybinding for command if set")
    "h x" '(describe-command :wk "Display full documentation for command"))

  (dt/leader-keys
    "m" '(:ignore t :wk "Org")
    "m a" '(org-agenda :wk "Org agenda")
    "m e" '(org-export-dispatch :wk "Org export dispatch")
    "m i" '(org-toggle-item :wk "Org toggle item")
    "m t" '(org-todo :wk "Org todo")
    "m B" '(org-babel-tangle :wk "Org babel tangle")
    "m T" '(org-todo-list :wk "Org todo list"))

  (dt/leader-keys
    "m b" '(:ignore t :wk "Tables")
    "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

  (dt/leader-keys
    "m d" '(:ignore t :wk "Date/deadline")
    "m d t" '(org-time-stamp :wk "Org time stamp"))

  (dt/leader-keys
    "o" '(:ignore t :wk "Open")
    "o d" '(dashboard-open :wk "Dashboard")
    "o e" '(elfeed :wk "Elfeed RSS")
    "o f" '(make-frame :wk "Open buffer in new frame")
    "o F" '(select-frame-by-name :wk "Select frame by name"))

  ;; projectile-command-map already has a ton of bindings
  ;; set for us, so no need to specify each individually.
  (dt/leader-keys
    "p" '(projectile-command-map :wk "Projectile"))

  (dt/leader-keys
    "r" '(:ignore t :wk "Radio")
    "r p" '(eradio-play :wk "Eradio play")
    "r s" '(eradio-stop :wk "Eradio stop")
    "r t" '(eradio-toggle :wk "Eradio toggle"))


  (dt/leader-keys
    "s" '(:ignore t :wk "Search")
    "s d" '(dictionary-search :wk "Search dictionary")
    "s m" '(man :wk "Man pages")
    "s o" '(pdf-occur :wk "Pdf search lines matching STRING")
    "s t" '(tldr :wk "Lookup TLDR docs for a command")
    "s w" '(woman :wk "Similar to man but doesn't require man"))

  (dt/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t e" '(eshell-toggle :wk "Toggle eshell")
    "t f" '(flycheck-mode :wk "Toggle flycheck")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
    "t o" '(org-mode :wk "Toggle org mode")
    "t r" '(rainbow-mode :wk "Toggle rainbow mode")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle vterm"))

  (dt/leader-keys
    "w" '(:ignore t :wk "Windows/Words")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
    ;; Words
    "w d" '(downcase-word :wk "Downcase word")
    "w u" '(upcase-word :wk "Upcase word")
    "w =" '(count-words :wk "Count words/lines for buffer"))
)

;; Global Settings

  (delete-selection-mode 1)    ;; You can select text and delete it by typing
