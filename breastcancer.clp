;======================================================
; Author 1: Juan Louis Rombetasik
; Author 2: Aria Bachrul Ulum Berlian
; Author 3: Azmi Muhammad syazwana
; File: breastcancer.clp
; Date: 11/11/2021
; Description: Breast cancer Diagnostic Program
;======================================================

(deffacts mulai
    (amcp)
)

(defrule ask-mean-concave-points
    ?val <- (amcp)
    =>
    (retract ?val)
    (printout t "Mean concave points? ")
    (assert (concave-points-input (read)))
)

(defrule mean-concave-points-baik
    ?valid <- (concave-points-input ?num&:(numberp ?num))
    =>
    (retract ?valid)
    (assert (concave-points ?num))
)

(defrule mean-concave-points-buruk
    ?valid <- (concave-points-input ?num&~:(numberp ?num))
    => 
    (retract ?valid)
    (assert (amcp))
)

(defrule ask-worst-radius
    (concave-points ?num&:(<= ?num 0.05))
    =>
    (printout t "Worst radius? ")
    (assert (worst-radius-input (read)))
)

(defrule worst-radius-baik
    ?valid <- (worst-radius-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (worst-radius ?num))
)

(defrule worst-radius-buruk
    ?valid <- (worst-radius-input ?num&~:(numberp ?num))
    ?val <- (concave-points ?cp)
    => 
    (retract ?val ?valid)
    (assert (concave-points ?cp))
)


(defrule ask-worst-perimeter
    (concave-points ?num&:(> ?num 0.05))
    =>
    (printout t "Worst perimeter? ")
    (assert (worst-perimeter-input (read)))
)

(defrule worst-perimeter-baik
    ?valid <- (worst-perimeter-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (worst-perimeter ?num))
)

(defrule worst-perimeter-buruk
    ?valid <- (worst-perimeter-input ?num&~:(numberp ?num))
    ?val <- (concave-points ?cp)
    => 
    (retract ?val ?valid)
    (assert (concave-points ?cp))
)
