;; --------------------
;; No backup / autosave
;; --------------------
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)    ; ロックファイル (.#*) を作らない
;;; init.el --- Minimal & Portable Configuration

;; -----------------------------------------------------------------------------
;; 1. 基本的なキーバインド設定
;; -----------------------------------------------------------------------------
;; C-h を Backspace として動作させる
;; (ヘルプは F1 か M-x help-for-help でアクセス可能)
(define-key key-translation-map [?\C-h] [?\C-?])

;; -----------------------------------------------------------------------------
;; 2. UI/UX の最小化（ポータビリティ重視）
;; -----------------------------------------------------------------------------
(setq inhibit-startup-screen t)    ; 起動画面を表示しない
(setq visible-bell t)
(unless (eq window-system nil)     ; GUI環境の場合のみ実行
  (menu-bar-mode -1)               ; メニューバーを隠す
  (tool-bar-mode -1)               ; ツールバーを隠す
  (scroll-bar-mode -1))            ; スクロールバーを隠す
(column-number-mode t)             ; 列番号を表示
(global-display-line-numbers-mode t) ; 行番号を表示

;; -----------------------------------------------------------------------------
;; 3. Org-mode の基本設定
;; -----------------------------------------------------------------------------
(with-eval-after-load 'org
  (setq org-startup-folded t)       ; 起動時は折りたたんだ状態にする
  (setq org-log-done 'time)         ; TODOを完了した時刻を記録する
  (setq org-support-shift-select t)) ; Shift + 矢印での範囲選択を許可

;; -----------------------------------------------------------------------------
;; 4. パッケージ管理（最小限）
;; -----------------------------------------------------------------------------
;; Emacs 29+ なら use-package が内蔵されているため、外部インストール不要
(require 'use-package)

;; 例：補完を少しだけ便利にする（任意ですが、あると快適です）
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
