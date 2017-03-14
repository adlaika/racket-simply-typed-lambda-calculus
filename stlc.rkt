#lang turnstile

(provide #%module-begin #%top #%datum
         (type-out Integer)
         (type-out ->)
         λ)

; Simply Typed Lambda Calculus
; 1. "literals": all integer literals have type Integer
; 2. "function": lambdas have type (-> A B)
; 3. "application": a function of type (-> A B) can be applied to a value of type A to produce a value of type B
; 4. "annotation": a value annotated with type T must have type T

(define-base-type Integer)
(define-type-constructor -> #:arity = 2)

(define-typed-syntax (#%datum . n:integer) ≫
  ; Rule 1
  ; (⊢): type statement follows
  ; (---): "then"
  ; (≫): "expands into"
  ; (⇒): "infer type"
  
  ; inputs
  ----------------------------------------
  ; outputs
  [⊢ (#%datum- . n) ⇒ Integer]
  )

(define-typed-syntax (λ [x:id : t_in:type] e:expr) ≫
  ; Rule 2
  [[x ≫ x- : t_in] ⊢ e ≫ e- ⇒ t_out]
  ; given (x expands into typeless x and it has type t_in),
  ; if (e expands into typeless e which is inferred to have type t_out)
  --------------------------------------------
  ; then
  [⊢ (λ- (x-) e-) ⇒ (-> t_in t_out)]
  ; typeless lambda called with typeless x and typeless e is inferred to have type (t_in -> t_out)
  )
