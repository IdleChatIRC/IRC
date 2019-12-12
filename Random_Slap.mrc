;----------------------------------------------------------------------------
; * Name    :    Random Slap
; * Author  :    Radien (brandon)
;                IRC: channel #damdevil in irc.damdevil.org
;                Web: http://code.google.com/p/itechnet/source/browse/trunk/mIRC%20Scripts/Radien/
; * Version :    0.1
; * Date    :    May 13th, 2011
; * Notes   :    Place in Aliases and press Shift F11 to random slap 
;                After you click a nick in the nicklist
;----------------------------------------------------------------------------

sF11 { set %slap $rand(1,9) 
  if (%slap == 1) /me slaps $$1 around a bit with a large trout 
  if (%slap == 2) /me slaps $$1 around a bit with a large penis
  if (%slap == 3) /me slaps $$1 around a bit of used condom
  if (%slap == 4) /me slaps $$1 around with a dirty hoe
  if (%slap == 5) /me stabs $$1 with a rusty fork
  if (%slap == 6) /me shoots $$1 with an AK-47
  if (%slap == 7) /me throws random stuff at $$1
  if (%slap == 8) /me kicks $$1 in the ass
  if (%slap == 9) /me whips $$1 with my handy dandy whip
}
