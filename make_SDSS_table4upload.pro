

data =mrdfits('dr7qso.fits',1)



;; 
;; Offset tests!!!
;;

arcsecs = 0.
;; arcsecs = 6.
;; arcsecs = 10.  ;; 12?!
;; arcsecs = 18.

print
print, ' Offset (for offset tests... in arcsecs)  ', arcsecs
print 

offset = arcsecs/3600.


openw, 10, 'SDSS_WISE_DR7Q_temp.dat'

printf, 10, '|  object          |           ra              |       dec             |'
printf, 10, '|  long            |           double          |       double          |'
for ii=0LL,   N_elements(data)-1 do begin
   printf, 10, data[ii].SDSSJ, data[ii].ra+offset, data[ii].dec, format='(3x, a, d,d)'
endfor
close, 10

close, /all

end
