;----------------------------------------------------------------------------
; * Name    :    Ban 6 Users
; * Author  :    Radien (brandon)
;                IRC: channel #damdevil in irc.damdevil.org
;                Web: http://code.google.com/p/itechnet/source/browse/trunk/mIRC%20Scripts/Radien/
; * Version :    0.1
; * Date    :    May 13th, 2011
; * Notes   :    type /bansix to ban the top 6 users of a channel.
;----------------------------------------------------------------------------

alias bansix { 
  var %x = $chan(0) 
  while (%x) { 
    mode $chan(%x) $$1 $+ bbbbbb $$2-
    dec %x 
  } 
}
