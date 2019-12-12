;----------------------------------------------------------------------------
; * Name    :    Anope Services Alias
; * Author  :    Radien (brandon)
;                IRC: channel #damdevil in irc.damdevil.org
;                Web: http://code.google.com/p/itechnet/source/browse/trunk/mIRC%20Scripts/Radien/
; * Version :    0.1
; * Date    :    May 13th, 2011
; * Notes   :    You type /vop, /chop, /aop, /sop and then The Nick
;----------------------------------------------------------------------------

alias vop {
  cs vop $active add $$1
  if ($1 ison $active) { cs sync $active }
  else { halt }
}
alias chop {
  cs hop $active add $$1
  if ($1 ison $active) { cs sync $active }
  else { halt }
}
alias sop {
  cs sop $active add $$1
  if ($1 ison $active) { cs sync $active }
  else { halt }
}
alias aop {
  cs aop $active add $$1
  if ($1 ison $active) { cs sync $active }
  else { halt }
}
