;;; lsp-kusto.el --- Kusto support for lsp-mode -*- lexical-binding: t -*-

;; Copyright (C) 2020 Tatu Lahtela <lahtela@iki.fi>

;; URL: https://github.com/ration/lsp-kusto

;;; Code:
(require 'lsp-mode)

(defvar
  kuskus-server-location "/home/lahtela/git/github/kuskus/kusto-language-server/server/out/server.js"
  "Kuskus (https://github.com/rosshamish/kuskus) lsp server location. Needs to be compiled, run npm run compile in kusto-language-server directory.")

(defcustom lsp-kusto-server-args
  '()
  "Extra arguments for the kusto-stdio language server"
  :group 'lsp-kusto
  :risky t
  :type '(repeat string))

(defun lsp-kusto--ls-command ()
  "Generate the language server startup command."
  `("node" ,kuskus-server-installation-location ,@lsp-kusto-server-args))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection (lsp-kusto--ls-command))
                  :major-modes '(kusto-mode)
                  :priority -1
                  :initialized-fn nil
                  :server-id 'kusto))

(provide 'lsp-kusto)
