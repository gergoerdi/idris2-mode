(defvar idris-keywords
  '("module" "namespace" "import" "class" "data" "codata"
     "instance" "where" "record" "public" "abstract" "private"
     "do" "case" "of" "let" "in" "with" "total" "partial" "dsl"
     "using" "parameters" "mutual" "if" "then" "else" "prefix"
     "infix" "infixr" "infixl" "pattern" "term" "syntax"
     "intros" "rewrite" "exact" "refine" "trivial" "focus" "try"
     "compute" "solve" "attack")
  "A list of things we consider keywords in idris.")

(defvar idris-assignment
  "\\(\\w+\\) \\(\\(\\s-*\\w\\S-*\\s-*\\)+\\) ="
  "Match assignment, capturing two groups: the variable being assigned
and the named arguments it may take.")

(defvar idris-data-declaration
  "data \\(\\w+\\)"
  "Match the name of a data type being declared.")

(defvar idris-operator
  "[-!#$%&\*\+./<=>\?@\\^|~:]+"
  "Match any of the things that count as operators in idris.")

(defvar idris-comment
  "--.*\\|{-.*-}"
  "Match eiter kind of idris comment.")

(defun idris-load-faces ()
  "Load or reload the idris-mode font-lock face customizations."
  (interactive)
  (let
    ((special (regexp-opt idris-special))
      (keywords (regexp-opt idris-keywords)))
    (setq font-lock-defaults
      `('((,idris-comment . font-lock-comment-face)
           (,keywords . font-lock-keyword-face)
           (,idris-operator . font-lock-variable-name-face)
           (,idris-data-declaration
             (1 'font-lock-function-name-face))
           (,idris-assignment
             (1 'font-lock-function-name-face)))))))
;; TODO syntax table and thence comments and their delimiters
;; TODO figure out why {- comments -} conflict with rainbow-delimiters
;; TODO figure out why argumentless definitions aren't being highlighted.
;; TODO highlight type declarations.
;; TODO highlight %assert etc.

; Make the actual mode.
(define-derived-mode idris-mode fundamental-mode "Idris"
  (idris-load-faces))

; Automatically use idris-mode for .idr files.
(push '("\\.idr$" . idris-mode) auto-mode-alist)

(provide 'idris)