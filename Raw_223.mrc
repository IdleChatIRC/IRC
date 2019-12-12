;----------------------------------------------------------------------------
; * Name    : Remove G:Lines Fast
; * Author  : Radien (brandon)
;        IRC: channel #damdevil in irc.damdevil.org
;        Web: http://code.google.com/p/itechnet/source/browse/trunk/mIRC%20Scripts/Radien/
; * Version :    0.1
; * Date    :    Nov 11th, 2011
; * Notes   :   this is a use at your own risk script. after loading type 
;                {/stats G} to remove any g:lines on your network/server
;----------------------------------------------------------------------------
;
;raw 223:*: { gline $+(-,$3) | gzline $+(-,$3) | zline $+(-,$3) }
