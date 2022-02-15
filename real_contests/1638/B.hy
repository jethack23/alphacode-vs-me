;;; hy==1.0a4

(defn solve [[test-case-num -1]]
  (if (< test-case-num 0)
      (do (import os
                  sys
                  io [BytesIO IOBase])

          (setv BUFSIZE 8192)

          (defclass FastIO [IOBase]
            (setv newlines 0)
            (defn __init__ [self file]
              (setv self._file file
                    self._fd (file.fileno)
                    self.buffer (BytesIO)
                    self.writable (or (in "x" file.mode)
                                      (not (in "r" file.mode)))
                    self.write (if self.writable
                                   self.buffer.write
                                   None))
              None)

            (defn read [self]
              (while True
                (setv b (os.read self._fd (max (. (os.fstat self._fc) st_size) BUFSIZE)))
                (if (not b) (break))
                (setv ptr (self.buffer.tell))
                (self.buffer.seek 0 2)
                (self.buffer.write b)
                (self.buffer.seek ptr))
              (setv self.newlines 0)
              (self.buffer.read))

            (defn readline [self]
              (while (= self.newlines 0)
                (setv b (os.read self._fd (max (. (os.fstat self._fd) st_size) BUFSIZE))
                      self.newlines (+ (b.count b"\n") (not b))
                      ptr (self.buffer.tell))
                (self.buffer.seek 0 2)
                (self.buffer.write b)
                (self.buffer.seek ptr))
              (-= self.newlines 1)
              (self.buffer.readline))

            (defn flush [self]
              (when self.writable
                (os.write self._fd (self.buffer.getvalue))
                (self.buffer.truncate 0)
                (self.buffer.seek 0))))

          (defclass IOWrapper [IOBase]
            (defn __init__ [self file]
              (setv self.buffer (FastIO file)
                    self.flush self.buffer.flush
                    self.writable self.buffer.writable
                    self.write (fn [s] (self.buffer.write (s.encode "ascii")))
                    self.read (fn [] (.decode (self.buffer.read) "ascii"))
                    self.readline (fn [] (.decode (self.buffer.readline) "ascii")))
              None))

          (setv sys.stdin (IOWrapper sys.stdin)
                sys.stdout (IOWrapper sys.stdout)
                input (fn [] (.rstrip (sys.stdin.readline) "\r\n"))))
      (do
        (print "TESTING NOW : this-is-for-preventing-pass-first-example")
        (defn input-generator [example]
          (for [line (.split example "\n")]
            (yield line)))
        (setv ig (input-generator (get examples test-case-num))
              input (fn [] (next ig)))))
  ;; TODO: parse inputs
  ;; (int (input))
  ;; (list (map int (.split (input))))
  (setv t (int (input)))
  (for [_ (range t)]
    (setv n (int (input))
          lst (list (map int (.split (input)))))
    (print (solution n lst))))

(defn solution [n lst]
  (setv odds []
        evens [])
  (for [k lst]
    (if (% k 2)
        (odds.append k)
        (evens.append k)))
  (if (and (nondecreasing? odds)
           (nondecreasing? evens))
      "yes"
      "no"))

(defn nondecreasing? [lst]
  (for [i (range 1 (len lst))]
    (if (> (get lst (- i 1)) (get lst i))
        (return False)))
  True)

;;; TODO: copy and paste example inputs
(setv examples ["4
4
1 6 31 14
2
4 2
5
2 9 6 7 10
3
6 6 6"])

(solve 0)
