;;; hy==1.0a4

(defn solution [s t]
  (setv s (list s)
        t (list t))
  (while (and s (!= (get s -1) (get t -1)))
    (s.pop)
    (if s
        (s.pop)
        (return False)))
  (while t
    (setv target (t.pop))
    (while (and s (!= (get s -1) target))
      (s.pop)
      (if s (s.pop)))
    (if (not s)
        (return False)
        (s.pop)))
  True)

(setv n (int (input)))
(for [_ (range n)]
  (setv s (input)
        t (input))
  (print (if (solution s t) "yes" "no")))


;;; transcompiled python code


;; def solution(s, t):
;;     s = list(s)
;;     t = list(t)
;;     while s and s[-1] != t[-1]:
;;         s.pop()
;;         if s:
;;             _hy_anon_var_1 = s.pop()
;;         else:
;;             return False
;;             _hy_anon_var_1 = None
;;     while t:
;;         target = t.pop()
;;         while s and s[-1] != target:
;;             s.pop()
;;             s.pop() if s else None
;;         if not s:
;;             return False
;;             _hy_anon_var_2 = None
;;         else:
;;             _hy_anon_var_2 = s.pop()
;;     return True


;; n = int(input())
;; for _ in range(n):
;;     s = input()
;;     t = input()
;;     print("yes" if solution(s, t) else "no")
