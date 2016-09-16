;+
;
; Some really simple code for picking out ones favorite BOSS dataset
; e.g. quasar targets, LRGs, or ``pilot'' WISE-selected objects 
; from either the DR9 (v5_4_45) or later (v5_5_0) spAll file. 
;
; v0.9   17 March 2012   NPR
;
;-

;;
;;  READ-IN THE spAll file
;;
;; From the BOSS/data/spAll directory from 8th Jan 2012
;data =mrdfits ('/cos_pc19a_npr/BOSS/data/spall/mini-spAll-v5_4_45.fits',1)
;data =mrdfits ('/cos_pc19a_npr/BOSS/data/spall/mini-spAll-v5_5_0.fits',1)

;; From the BOSS/bossqsomask/trunk/data/spAll directory from 8th March 2012
;data=mrdfits('/cos_pc19a_npr/BOSS/bossqsomask/trunk/data/spall/mini-spAll-v5_4_45.fits',1)

;readcol, '/cos_pc19a_npr/BOSS/papers/QSO/DR9Q/Lists/CoordQSO_AllList.dat', $
;PK, THINGID, ZBEST, RA, DECL, format='(i,i,d,d,d)'

data_release = 7
;data_release = 9

print
print, 'data_release = ', data_release 
print 
if data_release eq 7 then data = mrdfits('/cos_pc19a_npr/data/SDSS/DR7Q/dr7qso.fits',1)
if data_release eq 9 then data = mrdfits('/cos_pc19a_npr/data/BOSS/DR9Q/DR9Q.fits',1) 


ra         = data.ra
Decl       = data.Dec


;; DR7Q
if data_release eq 7 then begin
   platestr   = string(data.plate,format='(i4.4)')
   mjdstr     = string(data.smjd,format='(i5.5)')
   fiberidstr = string(data.fiber,format='(i4.4)')
endif

;; DR9Q
if data_release eq 9 then begin
   platestr   = string(data.plate,format='(i4.4)')
   mjdstr     = string(data.mjd,format='(i5.5)')
   fiberidstr = string(data.fiberid,format='(i4.4)')
endif


name =  platestr + '-' + mjdstr + '-' + fiberidstr




N_full_DR9 = n_elements(ra)

print
print
print, 'N_full_DR9', N_full_DR9
print
print

;; 
;; Offset tests!!!
;;
;arcsecs = 0.
;arcsecs = sqrt(2.)  ;; => total offset is sqrt((sqrt(2)^2 + sqrt(2)^2)) = 2.00...
;arcsecs = sqrt(18.)  ;; => total offset is sqrt((sqrt(18)^2 + sqrt(18)^2)) = 6.00...
arcsecs = sqrt(1800.)  ;; => total offset is sqrt((sqrt(18)^2 + sqrt(18)^2)) = 60.0 ...

print
print, ' Offset (for offset tests... in arcsecs)  ', sqrt((arcsecs^2 + arcsecs^2)) 
print 

offset = arcsecs/3600.

openw, 10, 'SDSS_WISE_DR7Q_temp.tbl'

printf, 10, '\fixlen=T' 
printf, 10, '| object           | ra              | dec                      |' 
printf, 10, '|char              | double          | double                   |' 

for ii=0LL,    N_full_DR9 -1 do begin
;   printf, 10, PK[ii], RA[ii], Decl[ii], format='(2x, i8, 2x,d,2x, d)'
   printf, 10, name[ii], RA[ii]+offset, Decl[ii]+offset, format='(2x, a15, 2x,d15.8, 2x,d15.8)'
endfor
close, 10

close, /all
;;
;; NPR comment: This works a treat... :-) 
;;


end

