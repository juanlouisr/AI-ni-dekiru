;======================================================
; Author 1: Juan Louis Rombetasik 13519075
; Author 2: Aria Bachrul Ulum Berlian 13519115
; Author 3: Azmi Muhammad syazwana 13519151
; File: breastcancer.clp
; Date: 11/11/2021
; Description: Breast cancer Diagnostic Program
;======================================================

(deffacts mulai
    (amcp)
)
; ===================== root =====================
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
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (amcp))
)


; ===================== degree 1 =====================
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
    (printout t "Mohon masukkan nilai yang valid!" crlf)
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
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (concave-points ?cp))
)


; ===================== degree 2 =====================
(defrule ask-radius-error
    (worst-radius ?num&:(<= ?num 16.83))
    =>
    (printout t "Radius error? ")
    (assert (radius-error-input (read)))
)

(defrule radius-error-baik
    ?valid <- (radius-error-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (radius-error ?num))
)

(defrule radius-error-buruk
    ?valid <- (radius-error-input ?num&~:(numberp ?num))
    ?val <- (worst-radius ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-radius ?wr))
)

(defrule ask-mean-texture
    (worst-radius ?num&:(> ?num 16.83))
    =>
    (printout t "Mean texture? ")
    (assert (mean-texture-input (read)))
)

(defrule mean-texture-baik
    ?valid <- (mean-texture-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (mean-texture ?num))
)

(defrule mean-texture-buruk
    ?valid <- (mean-texture-input ?num&~:(numberp ?num))
    ?val <- (worst-radius ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-radius ?wr))
)


(defrule ask-worst-texture-perimeter
    (worst-perimeter ?num&:(<= ?num 114.45))
    =>
    (printout t "Worst texture? ")
    (assert (worst-texture-input (read)))
)

(defrule worst-texture-perimeter-baik
    ?valid <- (worst-texture-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (worst-texture-perimeter ?num))
)

(defrule worst-texture-perimeter-buruk
    ?valid <- (worst-texture-input ?num&~:(numberp ?num))
    ?val <- (worst-perimeter ?wp)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-perimeter ?wp))
)

(defrule worst-perimeter-over
    (worst-perimeter ?num&:(> ?num 114.45))
    =>
    (assert (hasil 0.0))
)

; ===================== degree 3 =====================
(defrule ask-worst-texture-radius
    (radius-error ?num&:(<= ?num 0.63))
    =>
    (printout t "Worst texture? ")
    (assert (worst-texture-radius-input (read)))
)

(defrule worst-texture-radius-baik
    ?valid <- (worst-texture-radius-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (worst-texture-radius ?num))
)

(defrule worst-texture-radius-buruk
    ?valid <- (worst-texture-input ?num&~:(numberp ?num))
    ?val <- (radius-error ?wp)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (radius-error ?wp))
)

(defrule ask-mean-smoothness
    (radius-error ?num&:(> ?num 0.63))
    =>
    (printout t "Mean smoothness? ")
    (assert (mean-smoothness-input (read)))
)

(defrule mean-smoothness-baik
    ?valid <- (mean-smoothness-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (mean-smoothness ?num))
)

(defrule mean-smoothness-buruk
    ?valid <- (worst-texture-input ?num&~:(numberp ?num))
    ?val <- (radius-error ?wp)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (radius-error ?wp))
)


(defrule mean-texture-below
    (mean-texture ?num&:(<= ?num 16.19))
    =>
    (assert (hasil 1.0))
)

(defrule ask-concave-points-error
    (mean-texture ?num&:(> ?num 16.19))
    =>
    (printout t "Concave points error? ")
    (assert (concave-points-error-input (read)))
)

(defrule concave-points-error-baik
    ?valid <- (concave-points-error-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (concave-points-error ?num))
)

(defrule concave-points-error-buruk
    ?valid <- (concave-points-error-input ?num&~:(numberp ?num))
    ?val <- (mean-texture ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (mean-texture ?wr))
)


(defrule ask-worst-concave-points
    (worst-texture-perimeter ?num&:(<= ?num 25.65))
    =>
    (printout t "Worst concave points? ")
    (assert (worst-concave-points-input (read)))
)

(defrule worst-concave-points-baik
    ?valid <- (worst-concave-points-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (worst-concave-points ?num))
)

(defrule worst-concave-points-buruk
    ?valid <- (worst-concave-points-input ?num&~:(numberp ?num))
    ?val <- (worst-texture-perimeter ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-texture-perimeter ?wr))
)

(defrule ask-perimeter-error
    (worst-texture-perimeter ?num&:(> ?num 25.65))
    =>
    (printout t "Perimeter error? ")
    (assert (perimeter-error-input (read)))
)

(defrule perimeter-error-baik
    ?valid <- (perimeter-error-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (perimeter-error ?num))
)

(defrule perimeter-error-buruk
    ?valid <- (perimeter-error-input ?num&~:(numberp ?num))
    ?val <- (worst-texture-perimeter ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-texture-perimeter ?wr))
)


; ===================== degree 4 =====================
(defrule worst-texture-radius-below
    (worst-texture-radius ?num&:(<= ?num 30.15))
    =>
    (assert (hasil 1.0))
)

(defrule ask-worst-area
    (worst-texture-radius ?num&:(> ?num 30.15))
    =>
    (printout t "Worst area? ")
    (assert (worst-area-input (read)))
)

(defrule worst-area-baik
    ?valid <- (worst-area-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (worst-area ?num))
)

(defrule worst-area-buruk
    ?valid <- (worst-area-input ?num&~:(numberp ?num))
    ?val <- (worst-texture-radius ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-texture-radius ?wr))
)


(defrule mean-smoothness-below
    (mean-smoothness ?num&:(<= ?num 0.09))
    =>
    (assert (hasil 1.0))
)
(defrule mean-smoothness-over
    (mean-smoothness ?num&:(> ?num 0.09))
    =>
    (assert (hasil 0.0))
)


(defrule concave-points-error-below
    (concave-points-error ?num&:(<= ?num 0.01))
    =>
    (assert (hasil 0.0))
)
(defrule concave-points-error-over
    (concave-points-error ?num&:(> ?num 0.01))
    =>
    (assert (hasil 1.0))
)


(defrule worst-concave-points-below
    (worst-concave-points ?num&:(<= ?num 0.17))
    =>
    (assert (hasil 1.0))
)
(defrule worst-concave-points-over
    (worst-concave-points ?num&:(> ?num 0.17))
    =>
    (assert (hasil 0.0))
)


(defrule ask-mean-radius
    (perimeter-error ?num&:(<= ?num 1.56))
    =>
    (printout t "Mean radius? ")
    (assert (mean-radius-input (read)))
)

(defrule mean-radius-baik
    ?valid <- (mean-radius-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (mean-radius ?num))
)

(defrule mean-radius-buruk
    ?valid <- (mean-radius-input ?num&~:(numberp ?num))
    ?val <- (perimeter-error ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (perimeter-error ?wr))
)

(defrule perimeter-error-over
    (perimeter-error ?num&:(> ?num 1.56))
    =>
    (assert (hasil 0.0))
)

; ===================== degree 5 =====================
(defrule worst-area-below
    (worst-area ?num&:(<= ?num 641.60))
    =>
    (assert (hasil 1.0))
)

(defrule ask-mean-radius-worst-area
    (worst-area ?num&:(> ?num 641.60))
    =>
    (printout t "Mean radius? ")
    (assert (mean-radius-worst-area-input (read)))
)

(defrule mean-radius-worst-area-baik
    ?valid <- (mean-radius-worst-area-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (mean-radius-worst-area ?num))
)

(defrule mean-radius-worst-area-buruk
    ?valid <- (mean-radius-input ?num&~:(numberp ?num))
    ?val <- (worst-area ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (worst-area ?wr))
)


(defrule mean-radius-below
    (mean-radius ?num&:(<= ?num 13.34))
    =>
    (assert (hasil 0.0))
)
(defrule mean-radius-over
    (mean-radius ?num&:(> ?num 13.34))
    =>
    (assert (hasil 1.0))
)

; ===================== degree 6 =====================
(defrule ask-mean-texture-mean-radius
    (mean-radius-worst-area ?num&:(<= ?num 13.45))
    =>
    (printout t "Mean texture? ")
    (assert (mean-texture-mean-radius-input (read)))
)

(defrule mean-texture-mean-radius-baik
    ?valid <- (mean-texture-mean-radius-input ?num&:(numberp ?num))
    => 
    (retract ?valid)
    (assert (mean-texture-mean-radius ?num))
)

(defrule mean-texture-mean-radius-buruk
    ?valid <- (mean-radius-input ?num&~:(numberp ?num))
    ?val <- (mean-radius-worst-area ?wr)
    => 
    (retract ?val ?valid)
    (printout t "Mohon masukkan nilai yang valid!" crlf)
    (assert (mean-radius-worst-area ?wr))
)

(defrule mean-radius-worst-area-over
    (mean-radius-worst-area ?num&:(> ?num 13.45))
    =>
    (assert (hasil 1.0))
)

; ===================== degree 7 =====================
(defrule mean-texture-mean-radius-below
    (mean-texture-mean-radius ?num&:(<= ?num 28.79))
    =>
    (assert (hasil 0.0))
)
(defrule mean-texture-mean-radius-over
    (mean-texture-mean-radius ?num&:(> ?num 28.79))
    =>
    (assert (hasil 1.0))
)
; ================================ Hasil ================================
(defrule kena-kanker
    (hasil 1.0)
    =>
    (printout t "Hasil Prediksi = Terprediksi Kanker Payudara" crlf)
)

(defrule tidak-kena-kanker
    (hasil 0.0)
    =>
    (printout t "Hasil Prediksi = Terprediksi Tidak Kanker Payudara" crlf)
)



