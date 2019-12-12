;----------------------------------------------------------------------------
; * Name    :    Wasted Time
; * Author  :    Radien (brandon)
;                IRC: channel #damdevil in irc.damdevil.org
;                Web: http://code.google.com/p/itechnet/source/browse/trunk/mIRC%20Scripts/Radien/
; * Version :    0.1
; * Date    :    May 13th, 2011
; * Notes   :    Type /wasted in channel to display system & mirc uptime
;                as with connection time to mIRC server
;----------------------------------------------------------------------------

alias wasted { 
  me has wasted4 $uptime(system,2) on the PC, $&
    $+  7 $uptime(mirc,2) on mIRC, $&
    $+  3 $uptime(server,2) on 
}
