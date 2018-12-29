;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Your solution goes in this file ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;NAME: SAIRAMVINAY VIJAYARAGHAVAN
;Student ID: 913603345
;ECS 140A A02 Spring Quarter 2018


; PART 1 a) element-count 
; takes an atom and a list and returns the number of occurrences of that atom in the list.
                          
(defun element-count (x L)
    (do 
        (
            (lst L (cdr lst))    ;iterate through every element through the list
            (count 0)
        ) ;;initilization
    
        (
            (null lst)  ;end test when the end of the list is reached
            count       ;and return value
        )
        
        (if (eql x (car lst))   ;if element equals to the current element searched
            
            (setq count (+ 1 count)) ;increment count by 1
        )
    
    )
    
) 


; PART 1 b) min-mean-max()
    ;takes a list of numbers (with at least one element) and returns a list of length 3 that consists of the smallest number, the mean (reduced to the simplest fraction) of all numbers and the largest number.


;It has three helper functions to compute each parameter: MIN,MEAN AND MAX
(defun minlist(L)
    
    (do 
        
        (
                
            (lst L (cdr lst))   
            (minm (car L))  ;initialize minimum of list with the starting of list
        
        )
        (
            (null lst)  
            minm    ;returns the minimum of the list
        )
        
        (if (> minm (car lst))
            
            (setq minm (car lst))    
        )
    )

)

(defun maxlist(L)
    
    (do 
        
        (
                
            (lst L (cdr lst))
            (maxm (car L))  ;initialize maximum of list with the starting of list
        
        )
        (
            (null lst)
            maxm    ;returns the maximum of the list
        )
        
        (if (< maxm (car lst))
            
            (setq maxm (car lst))    
        )
    )

)

(defun meanlist(L)

    (do 
        
        (
                
            (lst L (cdr lst))
            (mean 0)    ;initialize average by 0
        
        )
        (
            (null lst)
            (/ mean (list-length L))    ;return sum of all elements over len(L)
        )
        
        (setq mean (+ (car lst) mean))  ;calculate sum of each elements in L
    )
);; meanlist()

(defun min-mean-max(L)

   (if (null L)
        NIL                                         ;returns NIL when list of number is empty
        (list (minlist L) (meanlist L) (maxlist L))  ;; returns the list of min, mean and max
    )
)

;PART 1 c) shift()
;takes a list and an integer n as input and returns thesame list, but with the first element shift to the end of the list n times

;It has the helper functions first-shift-and-add() 
(defun first-shift-and-add (n L)

    (do 
    
        (
            
            (lst L)   ; This shifts L n times forward to skip first n elements
            (i 0 (+ 1 i))       ;iterating variable
        
        )
        
        (
            (eql i n)           ;if i==n
            lst                 ;return the list after the skipping of first n elements and adding the top each time
        )
        
        (setq K (car lst))  ;save top of list always before cdring
        (setq lst (cdr lst))    ;take rest of list
        (setq lst (append lst (list K)))    ;add the top to the cdr
    )
)


(defun shift(n L)

    ; need to first get cdr of list (remaining of the list skipping first n elements) after n iterations first
    ; then we need to append the first n elements of the list L to the list obtained in step 1
    
    (if (null L)    ;If null list, then don't do anything
        
        NIL         ;return NIL if list is null
        (first-shift-and-add n L)   ; so as to count the number of shifts and do the final adds n times
        
    )
)

; PART 1 d) pivot()

;takes a list l and a number n and splits it into two lists,one containing all the numbers in l less than n and the other containing all numbers
;in l greater than or equal to n.


; It has two helper functions left-split and right-split
; Left-split() -> return all elements of L lesser than n in same order as in L
; Right-split() -> return all elements of L greater than or equal to n in same order as in L
(defun left-split(n L)

    (do
        (
          (lst L (cdr lst))  
          (left ())             
        )
        
        (
          (null lst)    
          left
        )
        
        (if (< (car lst) n)
            (setq left  (append left (list (car lst))))     ; append the elements of L which are lesser than n
        )
    )
)

(defun right-split(n L)
    (do
        (
          (lst L (cdr lst))  
          (right ())
        )
        
        (
          (null lst)    
          right
        )
        
        (if (>= (car lst) n)
            (setq right (append right (list (car lst))))    ; append the elements of L which are greater than or equal to n
        )
    )
)
        
(defun pivot(n L)

   (if (null L)
        
        (list NIL NIL)                                  ;return list of NIL if L is empty(NIL)
        (list (left-split n L) (right-split n L))       ; combine left and right
   )
)

; PART 1 e) break-list()
;takes a list and an atom and splits the list using the atom as the delimiter
;If the array does not contain the delimiter, then it returns the entire list as it is.

; It program has three helper functions: add-yes-not(), true-split() and check-break()

(defun add-yes-not(M R)
    
    ;Check to add to M depending of emptiness of R
     (if (null R)                       ;if R is empty
        M                               ;just directly return M
        (setq M (append M (list R)))    ;else append list(R) to M
    )    

)
(defun true-split(n L)
    
    ;this function breaks L into a list of lists based on delimiter n
    (do 
        (
            (lst L (cdr lst))       ;iterate through items of L
            (M ())                  ;List to hold the final big list of lists
            (R ())                  ;List to contain a subset of elements before a delimiter is encountered
        )
        
        (
            (null lst)              ;end condition
            (add-yes-not M R)       ;a function call to add-yes-not with M (containing all the subsets of L except (possibly non-empty) last subset R)
        )
        (
            cond (                              ;cond block to check the two broad cases
                    (equal n (car lst))         ;if the curr_element is equal to n
                    (cond                       ;inner cond block to check the emptiness of list R
                        (
                            (null R)        ; if R is empty, do nothing (ignore)
                        )
                        (
                            (not (null R))                  ;if R is non-empty
                            (setq M (append M (list R)))    ;add list(R) to M
                            (setq R ())                     ;make R empty list again to make it fresh
                            
                        )
                    )
                 )
                 (
                    (not (equal n (car lst)))               ;if current element not equal to n
                    (setq R (append R (list (car lst))))    ;append the current element to R
                    R                                       ;return R with the appended element
                )
            )
        )
)
    

(defun checkbreak(n L)
    ;Check whether n is in list L
    (if (equal (element-count n L) 0)   ;if count of n is 0 (refer to 1 a) (at the top) 
        t                               ;return true
        nil                             ;return false
    )
)

(defun break-list(n L)

    (if (null L)    ;if L is nil
        NIL         ;return NIL
        (if (checkbreak n L)    ;else if L is not null but there is no element n in L
            (list L)            ;rereturn L as it is
            (true-split n L)    ;else split the list L based on the delimiter element n
        )
    )
)

; PART 1 f) quick-sort()
;It uses only one helper function act-sort
(defun act-sort (L)
    
        ;this function implements quick sort algorithm (basically recursion) to solve the sorting problem
   (if (not (null L))       ;if L is non-empty (base case)
        (progn
        
            (let (                          ; a local let block to allow usage of M and N
                 (M (left-split (car L) (cdr L)))       ;M is the result of call left-split() based on first element of L as a pivot (refer above 1d)
                 (N (right-split (car L) (cdr L)))      ;N is the result of call right-split() based on first element of L as a pivot (refer above 1d)
                 )
                 
                 (cond                  ;cond block to encounter 4 different cases
                    (
                        (and (not (null M)) (not (null N)))                     ;if M and N are non empty
                        (append (act-sort M) (cons (car L) nil) (act-sort N))   ;add elements in a list which contains results of recursively called M and pivot and recursively called N
                 
                    )
                    
                    (
                        (and (null M) (not (null N)))               ;if M is empty and N is non-empty
                        (append (cons (car L) nil) (act-sort N))    ;append car(L) and recursive call on N
                    )
                    (
                        (and (null N) (not (null M)))               ;if N is empty and M is non-empty
                        (append (act-sort M) (cons (car L) nil))    ;append recursive call on M and car(L)  
                    ) 
                    (
                        (and (null M) (null N))                 ;if both are empty
                        (cons (car L) nil)                      ;use cons to make a simple list of car(L) {pivot}
                    )
                 )
            )
        )
   )
)



(defun quicksort (L)

    (if (null L)        ;if L is empty
        NIL             ;return NIL
        (act-sort L)    ;call act-sort on L
    )
)



;PART 2 : PATTERN MATCHING

;Write a function match that compares a pattern and an assertion. When a pattern containing
;no special atoms (!,?) is compared to an assertion, the two match only if they are exactly
;the same, with each corresponding position occupied by the same atom.

(defun match(a b) ;A is a pattern and B is an assertion
    (let 
        (
         (top-a (car a))
         (top-b (car b))
         (rest-a (cdr a))
         (rest-b (cdr b))
        )
        (cond 
            (
                (and (null a) (null b))     ; if both are empty, then we return true (as they are equal)
                t
            ) 
        
            (
                (or (null a) (null b))      ;if either is nil
                nil                         ;return NIL(false) and hence no comparison
            )
            
            (
                (equal top-a top-b)        ;if the current elements match
                (match rest-a rest-b)      ; go to next item if they match (a recursive call to maintain the value and not return nil)
            )
            
            (
                (equal top-a '?)            ;if the current element of a is ?
                (match rest-a rest-b)       ;skip through these items and move through rest of both the strings
            )
            
            (
                (equal top-a '!)            ;if the current element of a is !
                    (or                     ;take or because there can any case true
                        
                       
                        (match rest-a rest-b) ;perhaps there might be an item following the ! (! -> denoting one item)
                                              ;then skip through these current items and recurse through the remaining of each list

                        (match a rest-b)      ;perhaps there may not be any item following ! (!-> denoting many items)
                                              ;then match recursively for the rest of b with a (complete string)
                    )  
            )
        )
    )
)

;;;;PART 3 : MATRIX OPERATION

; 3a) MATRIX ADD
;takes two matrices as input and outputs the sum of the two matrices.

(defun matrix-add(A B)
    (if (and (null A) (null B))     ;if both are empty matrices
    NIL                             ;return NIL
    (mapcar #'(lambda (x y) (mapcar '+ x y)) A B)   ;call mapcar with a function to compute sum of each elements for each list
    )
)



;3b) MATRIX MULTIPLICATION
;takes two matrices as input and multiplies them and outputs the resultant

;It uses two helper functions: find-sum() and compute-row()
(defun find-sum(L)
    (do                     ;computes sum of all elements in a list
        (
            (lst L (cdr lst))   ;traverse through L 
            (sum 0)             
        )
        (
            (null lst)
            sum
        )
        (setq sum (+ sum (car lst)))        ; add value of each element in L
    )
)

(defun compute-row(left right)

    (do            
        (   
            (col right (cdr col)) ;iterate through columns of the second matrix (which is in its transpose form)
            (final-row ()) ;final answer to contain row of the product matrix
            (sum 0)         ; sum variable to hold the sum of all the products in products list
            (products ())   ;list of the products of the left (current row of A) and the jth column of B for 1<=j<=dim(B)
        )
        
        (
            (null col)
            final-row
        )
        (setq sum 0)    ;need to compute sum fresh always
        (setq products (mapcar #'* left (car col))) ; gets the products array to be added up for each element of each list product to be computed
        (setq sum (find-sum products))  ;computes the sum of this array
        (setq final-row (append final-row (cons sum nil)))  ; take cons(sum) to append a simple list of sum to final-row 
    )
)


(defun matrix-multiply(A B)
    
    (if (or (null A) (null B))  ;if A or B is empty
    
        NIL                     ;return NIL 
        (progn                  
                
            (do                     ;returns the whole new product matrix
            
                (
                    (lst A (cdr lst))       ;this iterates through the rows of A
                    (result ())             ;stores the final product of A and B
                    (row ())                ;it stores the temporary current row of the product
                )
                
                (
                    (null lst)
                    result                  
                )  
                
;we take transpose (refer below 3c) of the second matrix B because it is very easy to access each column of B as rows by just traversing through it in compute-row
                (setq row (compute-row (car lst) (matrix-transpose B)))         ;call compute row with current row of A and the transpose of B (explained above)
                (setq result (append result (list row)))                    ;The answer in row is now appended to result and set to result itself
            )
        )
    )
)



;3c) MATRIX TRANSPOSE
;that takes a matrix as input, and outputs its transpose.

(defun matrix-transpose(A)
    
    (  
        if (or (null A) (null (car A)))         ;transpose only when A or atleast the items in it is not emoty
            NIL
            (progn 
                (setq L1 (mapcar #'car A))      ;get the top of each row (the current column)
                (setq L2 (mapcar #'cdr A))      ;get the remaining of each row (the remaining items excluding current column)
                (cons L1 (matrix-transpose L2)) ;call it recursively on L2 to get each element of each column (cons is to make a simple list of L1 and L2)
            )
    )
)

