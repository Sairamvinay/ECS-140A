;; AN EXTRA SOLUTION TO PART 1C) SHIFT
(defun first-shift (n L)

    (do 
    
        (
            
            (lst L (cdr lst))   ; This shifts L n times forward to skip first n elements
            (i 0 (+ 1 i))       ;iterating variable
        
        )
        
        (
            (eql i n)           ;if i==n
            lst                 ;return the list after the skipping of first n elements
        )
        ; no body as lst returns the shifted half list
    )
)


(defun final-add(n L mainl)
    
    (do 
        (
            (lst L)         
            (i 0 (+ 1 i))       ;iterate through first n items of original list mainl
            (m mainl (cdr m))   ;we need to traverse through the first n items of mainl
        )
    
        (
            
            (eql i n)           ; if i==n
            lst                 ; return list after appending all the items
        )
        
        (setq lst (append lst (list (car m))))      ;append each of the first n items
    )
)



(defun shift(n L)

    ; need to first get cdr of list (remaining of the list skipping first n elements) after n iterations first
    ; then we need to append the first n elements of the list L to the list obtained in step 1
    
    (if (null L)    ;If null list, then don't do anything
        
        NIL         ;return NIL if list is null
        (final-add (rem n (list-length L)) (first-shift (rem n (list-length L)) L) L)   ;take remaining of n by list length so as to count the number of shifts
        
    )
)
