O9250 (DYNAMIC ROTATION CALC)
(AUTHOR PAUL SITES)
(DATE 2024.04.10)
(PURPOSE Rotate about a specified axis given an initial work offset)
(and rotation amount in degrees from an origin of rotation) 

; A 1 = ROTATION AXIS X 1, Y 2, Z 3
; C 3 = C_ROT OFFSET
; I 4 = INITIAL OFFSET
; S 19 = RESULT OFFSET
; R 18 = ROTATION FROM INITIAL IN DEG
IF [#1 EQ #0] THEN #3000=1(NEED ROTATION AXIS)
IF [#4 EQ #0] THEN #3000=1(NEED INITIAL OFFSET)
IF [#19 EQ #0] THEN #3000=1(NEED DESTINATION OFFSET)
IF [#18 EQ #0] THEN #3000=1(NEED ROTATION ANGLE)

#101 = 0  ; Center of rotation X
#102 = 0  ; Center of rotation Y
#103 = 0  ; Center of rotation Z
#104 = 0  ; Initial work offset X
#105 = 0  ; Initial work offset Y
#106 = 0  ; Initial work offset Z
#107 = 0  ; Initial work offset THETA
#108 = #1  ; Rotation Axis (A)
#109 = #18 ; Rotation angle in degrees (R)

N50
; Set center of rotation based on C
IF [#3 EQ #0] GOTO59
#150=51
#156=#3
GOTO900
N51
#101 = #[#151]
#102 = #[#152]
#103 = #[#153]
N59

N60
; Set initial work offset based on I
#150=61
#156=#4
GOTO900
N61
#104 = #[#151]
#105 = #[#152]
#106 = #[#153]
#107 = #[#154]

N70  ; Rotation calculations
IF [#108 EQ 1] GOTO 100
IF [#108 EQ 2] GOTO 200
IF [#108 EQ 3] GOTO 300
GOTO 999

N100  ; Rotation about X-axis
#110 = #105 - #102  ; Relative Y
#111 = #106 - #103  ; Relative Z
#112 = #104  ; X remains unchanged
#113 = #110 * COS[#109] - #111 * SIN[#109] + #102  ; New Y
#114 = #110 * SIN[#109] + #111 * COS[#109] + #103  ; New Z
#115 = #107  ; COPY ROTATION OFFSET
GOTO 400

N200  ; Rotation about Y-axis
#110 = #104 - #101  ; Relative X
#111 = #106 - #103  ; Relative Z
#112 = #110 * COS[#109] + #111 * SIN[#109] + #101  ; New X
#113 = #105  ; Y remains unchanged
#114 = -#110 * SIN[#109] + #111 * COS[#109] + #103  ; New Z
#115 = #107  ; COPY ROTATION OFFSET
GOTO 400

N300  ; Rotation about Z-axis
#110 = #104 - #101  ; Relative X
#111 = #105 - #102  ; Relative Y
#112 = #110 * COS[#109] - #111 * SIN[#109] + #101  ; New X
#113 = #110 * SIN[#109] + #111 * COS[#109] + #102  ; New Y
#114 = #106  ; Z remains unchanged
#115 = #107  ; COPY ROTATAION OFFSET

N400  ; SAVE RESULT TO OFFSET
; Set initial work offset based on I
#150=700
#156=#19
GOTO900
N700
#[#151] = #112
#[#152] = #113
#[#153] = #114
#[#154] = #115

;SKIP OVER SUPPORT FUNCTIONS
GOTO999

N900  ; CONVERT OFFSET
IF [#156 GT 100] GOTO 902
IF [#156 LT 7] GOTO 901
#156 = #156 - 53.
N901
IF [#156 LT 1] THEN #3000=1(ILLEGAL OFFSET)
IF [#156 GT 6] THEN #3000=1(ILLEGAL OFFSET)
#151 = [#156 * 20 + 5201]
#152 = [#156 * 20 + 5202]
#153 = [#156 * 20 + 5203]
#154 = [#156 * 20 + 5204]
GOTO 910
N902
#156 = #156 - 100.
IF [#156 LT 1.] THEN #3000=1(ILLEGAL OFFSET)
IF [#156 GT 48.] THEN #3000=1(ILLEGAL OFFSET)
#151 = [#156 * 20 + 6981]
#152 = [#156 * 20 + 6982]
#153 = [#156 * 20 + 6983]
#154 = [#156 * 20 + 6984]
N910
GOTO#150

N999
M99
