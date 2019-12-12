;Sentinel mIRC Script 0.9
;Copyright wh1tel1te 2005
;Last updated 28/2/2006
;Contact: irc.linuxniche.net #chat   scripts\sentineltheme.ini
;;
;;
;;; Edited by Radien
;;; Last Updated 10/18/2011
;;; Contact: irc://irc.damdevil.org -j #damdevil
;;; 

;This script is used to change the way mIRC looks easily and effectively, set away status with various options,
;and set various auto settings, such as auto nickserv identify. To use, right click on a channel and use the popups to change settings.
; -- DISCLAIMER --
;You may redistribute copies of this script to others as long as the copyright and this disclaimer remain intact
;You may edit this script for your own and others' use as long as the copyright and this disclaimer remain intact
;You may use portions of this script as the basis of your own scripts, as long as you credit the author and do not sell the script
;You may not sell this script, by itself or as a package, without permission
;You may not use this script as a whole in a script package/as part of your own script without permission
;this script may not be found on any website with exception to the following list: wh1tel1te.randumb.org
;If you have any questions, comments or suggestions, please contact the author, wh1tel1te, at irc.linuxniche.net #chat.
;This disclaimer may change without notice. Please view the current version at http://wh1tel1te.randumb.org/disclaimer.php
; -- END DISCLAIMER --

; -- CREDITS --
;b3h1ndu - beta testing/ideas
;Minx/Yodee - beta testing/ideas
;ARcanUSNUMquam - scripting help/IAL Update script
;Fenris_Wolf - scripting help
;Nimbus - IAL Update script
;StRaNdEd - ideas

;Script initialisation
on *:load: {
  set %stheme.version 0.8
  if (!%stheme.pcolour) {
    set %stheme.pcolour $?="Enter primary theme colour character number, 0 to 15"
    if (%stheme.pcolour < 10) set %stheme.pcolour $+(0, %stheme.pcolour)
    set %stheme.scolour $?="Enter secondary theme colour character number, 0 to 15"
    if (%stheme.scolour < 10) set %stheme.scolour $+(0, %stheme.scolour)
    set %stheme.owntextcolour
    set %stheme.showaway off
    set %stheme.leftnickchar <
    set %stheme.rightnickchar >
    set %stheme.tstampleft [
    set %stheme.tstampright ]
    set %stheme.miscleft [
    set %stheme.miscright ]
    set %stheme.fontface fixedsys
    set %stheme.fontsize 9
    set %stheme.fontbold off
    set %stheme.actioncolour 4
    set %stheme.initheme $readini(mirc.ini, text, theme)
    scid -at1 timestamp -f $+(, %stheme.pcolour, %stheme.tstampleft, , %stheme.scolour, hh, %stheme.pcolour, :, %stheme.scolour, nn, %stheme.pcolour, :, %stheme.scolour, ss tt, %stheme.pcolour, %stheme.tstampright, )
    var %prefix = $?!="Would you like mode prefixes to be attached to users' nicks?"
    if (%prefix == $true) set %stheme.nickprefix on
    else set %stheme.nickprefix off
    echo -ti2la Script load complete. Right click a channel to change theme settings and have fun - wh1tel1te
  }
  else echo -ti2la Script load complete. Using settings saved from last load.
}

;Popup commands for channel
menu channel,query {
  -
  Theme Settings
  .$iif(%stheme.themeon, Deactivate Theme System, Activate Theme System): $iif(%stheme.themeon, unset %stheme.themeon, set %stheme.themeon on)
  .Characters
  ..Nicks
  ...Left Nick Char(s) - Currently %stheme.leftnickchar: var %temp = $?="Enter the character(s) you would like displayed to the left of a person's nick" | if (%temp) .set %stheme.leftnickchar %temp
  ...Right Nick Char(s) - Currently %stheme.rightnickchar: var %temp = $?="Enter the character(s) you would like displayed to the right of a person's nick" | if (%temp) .set %stheme.rightnickchar %temp
  ..Timestamp
  ...Left Timestamp Char(s) - Currently %stheme.tstampleft: .set %stheme.tstampleft $?="Enter the character(s) you would like displayed to the left of the timestamp"
  ...Right Timestamp Char(s) - Currently %stheme.tstampright: .set %stheme.tstampright $?="Enter the character(s) you would like displayed to the left of the timestamp"
  ..Miscellaneous (mode change, etc)
  ...Left Misc Char(s) - Currently %stheme.miscleft: .set %stheme.miscleft $?="Enter the character(s) you would like displayed to the left of miscellaneous output"
  ...Right Misc Char(s) - Currently %stheme.miscright: .set %stheme.miscright $?="Enter the character(s) you would like displayed to the right of miscellaneous output"
  .Colours
  ..Primary - Currently %stheme.pcolour: .set %stheme.pcolour $?="Enter primary theme colour character number, 0 to 15" | if (%stheme.pcolour < 10) { set %stheme.pcolour 0 $+ %stheme.pcolour } | scid -at1 timestamp -f $+(, %stheme.pcolour, %stheme.tstampleft, , %stheme.scolour, hh, %stheme.pcolour, :, %stheme.scolour, nn, %stheme.pcolour, :, %stheme.scolour, ss tt, %stheme.pcolour, %stheme.tstampright, )
  ..Secondary - Currently %stheme.scolour: .set %stheme.scolour $?="Enter secondary theme colour character number, 0 to 15" | if (%stheme.scolour < 10) { set %stheme.scolour 0 $+ %stheme.scolour } | scid -at1 timestamp -f $+(, %stheme.pcolour, %stheme.tstampleft, , %stheme.scolour, hh, %stheme.pcolour, :, %stheme.scolour, nn, %stheme.pcolour, :, %stheme.scolour, ss tt, %stheme.pcolour, %stheme.tstampright, )
  ..Nicks
  ...Self $iif(%stheme.selfnickcolour, - Currently %stheme.selfnickcolour, ): .set %stheme.selfnickcolour $?="Enter colour for your own nick display" | scid -at1 colourallnicklists
  ...No Mode $iif(%stheme.nomodenickcolour, - Currently %stheme.nomodenickcolour, ): .set %stheme.nomodenickcolour $?="Enter colour for nicks with no mode" | scid -at1 colourallnicklists
  ...Voice $iif(%stheme.voicenickcolour, - Currently %stheme.voicenickcolour, ): .set %stheme.voicenickcolour $?="Enter colour for voiced (+) nicks" | scid -at1 colourallnicklists
  ...Halfop $iif(%stheme.halfopnickcolour, - Currently %stheme.halfopnickcolour, ): .set %stheme.halfopnickcolour $?="Enter colour for halfopped (%) nicks" | scid -at1 colourallnicklists
  ...Op $iif(%stheme.opnickcolour, - Currently %stheme.opnickcolour, ): .set %stheme.opnickcolour $?="Enter colour for opped (@) nicks" | scid -at1 colourallnicklists
  ...Admin $iif(%stheme.adminnickcolour, - Currently %stheme.adminnickcolour, ): .set %stheme.adminnickcolour $?="Enter colour for admined (&) nicks" | scid -at1 colourallnicklists
  ...Owner $iif(%stheme.ownernickcolour, - Currently %stheme.ownernickcolour, ): .set %stheme.ownernickcolour $?="Enter colour for ownered (~) nicks" | scid -at1 colourallnicklists
  ...Friends $iif(%stheme.friendnickcolour, - Currently %stheme.friendnickcolour, ): .set %stheme.friendnickcolour $?="Enter colour for your friends' nicks" | scid -at1 colourallnicklists
  ..Channels
  ...Background $iif(%stheme.backgroundcolour, - Currently %stheme.backgroundcolour, ): .set %stheme.backgroundcolour $?="Enter colour for channel/status window/query backgrounds" | color background %stheme.backgroundcolour | color editbox %stheme.backgroundcolour | color nicklist %stheme.backgroundcolour
  ...Normal Text $iif(%stheme.normaltextcolour, - Currently %stheme.normaltextcolour, ): .set %stheme.normaltextcolour $?="Enter colour for channel/status window/query text colour" | color normal text %stheme.normaltextcolour | color editbox text %stheme.normaltextcolour
  ...Own Text $iif(%stheme.owntextcolour, - Currently %stheme.owntextcolour, ): .set %stheme.owntextcolour $?="Enter colour for your own channel text colour" | color own text %stheme.ownextcolour
  ...Action Text $iif(%stheme.actiontextcolour, - Currently %stheme.actiontextcolour, ): .set %stheme.actiontextcolour $?="Enter colour for channel/status window/query action colour" | color action text %stheme.actiontextcolour
  .Display
  ..Change Font Face - Currently %stheme.fontface: set %stheme.fontface $?="Enter the font face you would like" | font $iif(%stheme.fontbold == yes, -asgbdz, -asgdz) %stheme.fontsize %stheme.fontface
  ..Change Font Size - Currently %stheme.fontsize: set %stheme.fontsize $?="Enter the font size you would like" | font $iif(%stheme.fontbold == yes, -asgbdz, -asgdz) %stheme.fontsize %stheme.fontface
  ..$iif(%stheme.fontbold == on,$style(1),) Make Font Bold: $iif(%stheme.fontbold == on, set %stheme.fontbold off, set %stheme.fontbold on) | font $iif(%stheme.fontbold == on, -asgbdz, -asgdz) %stheme.fontsize %stheme.fontface
  ..$iif(%stheme.nickprefix == on,$style(1),) Show Nick Prefixes: $iif(%stheme.nickprefix == on, set %stheme.nickprefix off, set %stheme.nickprefix on)
  ..$iif(%stheme.showusercount == on,$style(1),) Show User Count On Join/Part: $iif(%stheme.showusercount == on, set %stheme.showusercount off, set %stheme.showusercount on)
  Away System
  .$iif($away != $true, Set Away	/away <reason>, Return From Away	/away): if ($away == $true) away | else { var %temp = $?="Enter away message" | if (%temp) away %temp }
  .$iif(%stheme.awaynick, Change Away Nick - Currently %stheme.awaynick, Set Away Nick): set %stheme.awaynick $?="Enter the nick you would like to change to on away"
  .$iif(!%stheme.awaynick, $style(2),) Unset Away Nick: unset %stheme.awaynick
  .$iif(%stheme.showaway == on,$style(1),) Message All Channels On Away: $iif(%stheme.showaway == on, set %stheme.showaway off, set %stheme.showaway on)
  .$iif(%stheme.showaway == off, $style(2),) $iif(%stheme.awayend, Change Message To End Of Away, Add Message To End Of Away): set %stheme.awayend $?="Enter message you would like attached to the end of your away messages"
  .$iif(%stheme.awaylog == on,$style(1),) Log Messages While Away: $iif(%stheme.awaylog == on, set %stheme.awaylog off, set %stheme.awaylog on)
  Auto Settings
  .$iif($active isin % [ $+ stheme. $+ [ $network ] $+ .joinchans ],Delete $chan From Auto-Join List For $network,Add $chan To Auto-Join List For $network): if ($active isin % [ $+ stheme. $+ [ $network ] $+ .joinchans ]) set % [ $+ stheme. $+ [ $network ] $+ .joinchans ] $remove(% [ $+ stheme. $+ [ $network ] $+ .joinchans ], $chan) | else set % [ $+ stheme. $+ [ $network ] $+ .joinchans ] % [ $+ stheme. $+ [ $network ] $+ .joinchans ] $chan | if (% [ $+ stheme. $+ [ $network ] $+ .joinchans ] == $null) unset % [ $+ stheme. $+ [ $network ] $+ .joinchans ]
  .$iif($network isin %stheme.netautojoin,Delete $network From Server Connect List,Add $network To Server Connect List): if ($server isin %stheme.netautojoin) set %stheme.netautojoin $remove(%stheme.netautojoin, $server $+ $chr(58) $+ $port) | else set %stheme.netautojoin %stheme.netautojoin $server $+ $chr(58) $+ $port | if (%stheme.netautojoin == $null) unset %stheme.netautojoin
  .$iif(% [ $+ stheme. $+ [ $network ] $+ .nsidpass ], Change Nickserv Identify Password For $network, Set Nickserv Identify Password For $network): set % [ $+ stheme. $+ [ $network ] $+ .nsidpass ] $?="Enter your nickserv identify password"
  .$iif(% [ $+ stheme. $+ [ $network ] $+ .olineid ], Change O-line Name For $network, Set O-line Name For $network): set % [ $+ stheme. $+ [ $network ] $+ .olineid ] $?="Enter your o-line name"
  .$iif(% [ $+ stheme. $+ [ $network ] $+ .olinepass ], Change O-line Password For $network, Set O-line Password For $network): set % [ $+ stheme. $+ [ $network ] $+ .olinepass ] $?="Enter your o-line password"
  .$iif((% [ $+ stheme. $+ [ $network ] $+ .olineid ]) && (% [ $+ stheme. $+ [ $network ] $+ .olinepass ]), ,$style(2)) $iif(% [ $+ stheme. $+ [ $network ] $+ .autooper ],$style(1),) Auto Oper On Connect For $network $iif((% [ $+ stheme. $+ [ $network ] $+ .olineid ]) && (% [ $+ stheme. $+ [ $network ] $+ .olinepass ]), , - set name and password first): $iif(% [ $+ stheme. $+ [ $network ] $+ .autooper ], unset % [ $+ stheme. $+ [ $network ] $+ .autooper ], set % [ $+ stheme. $+ [ $network ] $+ .autooper ] on)
  Fun Stuff
  .$iif(%stheme.retaliation == on,$style(1),) Retaliation On Action: $iif(%stheme.retaliation == on, set %stheme.retaliation off, set %stheme.retaliation on)
  .Add Nick To Retaliation List: set %stheme.retalnicks %stheme.retalnicks $?="Enter nick to add to retaliation list"
  .IRC Stats	/showircstats: showircstats
  Unload Script
  .Unload Script - Keep Settings: unload -rs sentineltheme.mrc
  .Unload Script - Delete Settings: unset %stheme.* | unload -rs sentineltheme.mrc
  -
}

;Popup commands for nicklist/nicks
menu nicklist {
  $iif($address($$1, 3) isin %stheme.friendlist,Delete From Friends List,Add To Friends List): $iif($address($$1, 3) isin %stheme.friendlist, set %stheme.friendlist $remove(%stheme.friendlist, $address($$1, 3)), set %stheme.friendlist %stheme.friendlist $address($$1, 3)) | scid -at1 colourallnicklists
}

;Popup for status window
menu status {
  -
  $iif(%stheme.netautojoin,,$style(2)) Connect To Networks On Server Join List: var %counter = 1 | var %numtoks = $numtok(%stheme.netautojoin, 32) | while (%counter <= %numtoks) { if (!%donefirst) { var %donefirst = 1 | server $gettok(%stheme.netautojoin, %counter, 32) } | else server -m $gettok(%stheme.netautojoin, %counter, 32) | inc %counter }
  -
}

on 1:sockopen:checkupdate: {
  if ($sockerr > 0) return
  sockwrite -n checkupdate $eval(GET http://wh1tel1te.randumb.org HTTP/1.0,0)
  sockwrite -n checkupdate
}

on 1:sockread:checkupdate: {
  if ($sockerr > 0) return
  var %temp | sockread %temp
  if ($sockbr == 0) return
  if (current version %stheme.version isin %temp) { timerupdate off | echo -a You are running the current version of Sentinel Script. }
}
;alias for colouring single channel nick list
alias colournicklist {
  var %counter = 1
  while (%counter <= $nick($1, 0)) {
    var %cnick = $nick($1, %counter)
    var %prefix = $left($nick($1, %counter).pnick, 1)
    if (%prefix == ~) cline %stheme.ownernickcolour $1 %cnick
    else if (%prefix == &) cline %stheme.adminnickcolour $1 %cnick
    else if (%prefix == @) cline %stheme.opnickcolour $1 %cnick
    else if (%prefix == %) cline %stheme.halfopnickcolour $1 %cnick
    else if (%prefix == +) cline %stheme.voicenickcolour $1 %cnick
    else cline %stheme.nomodenickcolour $1 %cnick
    if (%cnick == $me) cline %stheme.selfnickcolour $1 %cnick
    if ($address(%cnick, 4) isin %stheme.friendlist) cline %stheme.friendnickcolour $1 %cnick
    inc %counter
  }
}

;alias for colouring every channel nick list on a network
alias colourallnicklists {
  var %counter = 1
  while (%counter <= $chan(0)) {
    colournicklist $chan(%counter)
    inc %counter
  }
}

;alias for user friendly $duration
alias duration2 return $replace($duration($1), wk,  week, day,  day, hr,  hour, min,  minute, sec,  second)

;alias for stats
alias ircstats {
  var %x = 0
  var %counter = 1
  if ($1 == chans) {
    while (%counter <= $scon(0)) {
      scon %counter
      inc %x $chan(0)
      inc %counter
    }
  }
  if ($1 == servers) inc %x $scon(0)
  if ($1 == owners) {
    while (%counter <= $scon(0)) {
      scon %counter
      var %counter2 = 1
      while (%counter2 <= $chan(0)) {
        var %cchan = $chan(%counter2)
        if ($left($nick(%cchan,$me).pnick,1) == ~) inc %x
        inc %counter2
      }
      inc %counter
    }
  }
  if ($1 == admins) {
    while (%counter <= $scon(0)) {
      scon %counter
      set %counter2 1
      while (%counter2 <= $chan(0)) {
        var %cchan = $chan(%counter2)
        if ($left($nick(%cchan,$me).pnick,1) == &) inc %x
        inc %counter2
      }
      inc %counter
    }
  }
  if ($1 == ops) {
    while (%counter <= $scon(0)) {
      scon %counter
      var %counter2 = 1
      while (%counter2 <= $chan(0)) {
        if ($me isop $chan(%counter2)) {
          if (($left($nick($chan(%counter2),$me).pnick,1) != &) && ($left($nick($chan(%counter2),$me).pnick,1) != ~)) inc %x
        }
        inc %counter2
      }
      inc %counter
    }
  }
  if ($1 == halfops) {
    while (%counter <= $scon(0)) {
      scon %counter
      var %counter2 = 1
      while (%counter2 <= $chan(0)) {
        if ($me ishelp $chan(%counter2)) inc %x
        inc %counter2
      }
      inc %counter
    }
  }
  if ($1 == voices) {
    while (%counter <= $scon(0)) {
      scon %counter
      var %counter2 1
      while (%counter2 <= $chan(0)) {
        if ($me isvoice $chan(%counter2)) inc %x
        inc %counter2
      }
      inc %counter
    }
  }
  if ($1 == netadmins) {
    while (%counter <= $scon(0)) {
      scon %counter
      if (N isincs $usermode) inc %x
      inc %counter
    }
  }
  if ($1 == globals) {
    while (%counter <= $scon(0)) {
      scon %counter
      if (o isincs $usermode) inc %x
      inc %counter
    }
  }
  return %x
}

;alias for showing irc stats
alias showircstats {
  msg $active  $+ %stheme.pcolour $+ %stheme.miscleft $+  $+ IRC Stats $+  $+ %stheme.pcolour $+ %stheme.miscright
  msg $active  $+ %stheme.pcolour $+ %stheme.miscleft $+  $+ %stheme.scolour $+ Networks: $ircstats(servers) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Netadmin Status On: $ircstats(netadmins) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Global Oper Status On: $ircstats(globals) $+  $+ %stheme.pcolour $+ %stheme.miscright
  msg $active  $+ %stheme.pcolour $+ %stheme.miscleft $+  $+ %stheme.scolour $+ Channels: $ircstats(chans) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Owners: $ircstats(owners) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Admins: $ircstats(admins) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Ops: $ircstats(ops) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Halfops: $ircstats(halfops) $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Voices: $ircstats(voices) $+  $+ %stheme.pcolour $+ %stheme.miscright
  msg $active  $+ %stheme.pcolour $+ %stheme.miscleft $+  $+ %stheme.scolour $+ Words Spoken: %stheme.words $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Sentences Spoken: %stheme.sentences $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Actions: %stheme.actions $+  $+ %stheme.pcolour $+ %stheme.miscright
  msg $active  $+ %stheme.pcolour $+ %stheme.miscleft $+  $+ %stheme.scolour $+ Kicked: $iif(%stheme.kicked,%stheme.kicked,0) times $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Kicks: $iif(%stheme.kicks,%stheme.kicks,0) people $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Banned: $iif(%stheme.banned,%stheme.banned,0) times $+  $+ %stheme.pcolour $+ %stheme.miscright %stheme.miscleft $+  $+ %stheme.scolour $+ Bans: $iif(%stheme.bans,%stheme.bans,0) people $+  $+ %stheme.pcolour $+ %stheme.miscright
}

;timestamp formatting/auto stuff
on 1:connect: {
  timestamp -f $+(, %stheme.pcolour, %stheme.tstampleft, , %stheme.scolour, hh, %stheme.pcolour, :, %stheme.scolour, nn, %stheme.pcolour, :, %stheme.scolour, ss tt, %stheme.pcolour, %stheme.tstampright, )
  if (% [ $+ stheme. $+ [ $network ] $+ .nsidpass ]) msg nickserv identify % [ $+ stheme. $+ [ $network ] $+ .nsidpass ]
  if ((% [ $+ stheme. $+ [ $network ] $+ .olineid ]) && (% [ $+ stheme. $+ [ $network ] $+ .olinepass ]) && (% [ $+ stheme. $+ [ $network ] $+ .autooper ])) oper % [ $+ stheme. $+ [ $network ] $+ .olineid ] % [ $+ stheme. $+ [ $network ] $+ .olinepass ]
  var %jchans = % [ $+ stheme. $+ [ $network ] $+ .joinchans ]
  if ((%opername) && (%operpass)) oper %opername %operpass
  if (%jchans) {
    var %counter = 1
    var %numtoks = $numtok(%jchans, 32)
    while (%counter <= %numtoks) {
      join $gettok(%jchans, %counter, 32)
      inc %counter
    }
  }
}

;connection raws
raw 1:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 2:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 3:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 4:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }  
raw 5:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 6:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 7:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
;rawr 8 found elsewhere
raw 200:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 201:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 202:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 203:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 204:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 205:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 206:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 207:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 208:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 209:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 210:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 211:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 212:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 213:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 214:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 215:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 216:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 217:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 218:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 219:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $3 $4 , %stheme.pcolour, $5 $2  ) | haltdef }
raw 220:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
;221 is found elsewhere
raw 222:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 223:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 224:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 225:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 226:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 227:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 228:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 229:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 230:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 240:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 241:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 242:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 243:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 244:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 245:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 246:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 247:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 248:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 249:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 250:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 251:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 252:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 253:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 254:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 255:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 256:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 257:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 258:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 259:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 265:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 266:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 230:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 231:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 232:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 300:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
;raw 301 found elsewhere
raw 302:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 303:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 304:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 305:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 306:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
;raw 307 fund elsewhere
raw 308:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 309:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
;raw 310 found elsewhere
;raw 311 found elsewhere
raw 340:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 351:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - Version $+ : , %stheme.acolour, $2- ) | haltdef }
;raw 352 found elsewhere
;raw 353 found elsewhere
raw 372:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 375:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 376:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 377:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
;raw 378 is found elsewhere
raw 381:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 382:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 403:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 422:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 

;channel join output
raw 324:*: if (%stheme.themeon) { if (!%stheme.topicoutput) { echo -ti2l $2 $+(, %stheme.pcolour, - Channel modes:, %stheme.scolour $3-) } | haltdef }
raw 329:*: if (%stheme.themeon) { if (!%stheme.topicoutput) { echo -ti2l $2 $+(, %stheme.pcolour, - Channel creation date:, %stheme.scolour $asctime($3)) | set %stheme.topicoutput 1 | timer 1 5 unset %stheme.topicoutput } | haltdef }
raw 332:*: if (%stheme.themeon) { echo -ti2l $2 $+(, %stheme.pcolour, - Channel topic:, %stheme.scolour $3-) | haltdef }
raw 333:*: if (%stheme.themeon) { echo -ti2l $2 $+(, %stheme.pcolour, - Set by, %stheme.pcolour $3 on , %stheme.pcolour, $asctime($4)) | haltdef }
raw 353:*: if (%stheme.themeon) { halt | haltdef }
raw 366:*: if (%stheme.themeon) { halt | haltdef }
;raw 353:*: if (%stheme.themeon) { echo -ti2l $+(, %stheme.pcolour, - Users on , %stheme.scolour, $3, , : , %stheme.pcolour, $replace($4-, ~, $+(, %stheme.scolour, ~, %stheme.pcolour), &, $+(, %stheme.scolour, &, %stheme.pcolour), @, $+(, %stheme.scolour, @, %stheme.pcolour), $chr(37), $+(, %stheme.scolour, $chr(37), , %stheme.pcolour), +, $+(, %stheme.scolour, +, %stheme.pcolour))) | haltdef }
;raw 366:*: if (%stheme.themeon) { echo -ti2l $+(, %stheme.pcolour, - End of , %stheme.scolour, /names) | haltdef }
raw 405:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot join channel, you have joined the limit for this network) | haltdef }
raw 439:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Target change to fast. please wait a bit) | haltdef }
raw 471:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot join channel, user limit reached [+l]) | haltdef }
raw 473:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot join channel [ $2 ], invite only [+i]) | haltdef }
raw 474:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot join [ $2 ], you have been banned [+b]) | haltdef }
raw 475:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot join [ $2 ], you do not have proper key [+k]) | haltdef }
raw 477:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot Message/join $2 $+ , auth to services [+r]) | haltdef }
raw 479:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - Cannot join channel, [Access denied]) | haltdef }


;whois output
raw 310:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - Available for help: , %stheme.pcolour, Yes) | haltdef }
raw 311:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, -) | echo -a $timestamp $+(, %stheme.pcolour, - Whois for , %stheme.pcolour, $2, , %stheme.scolour, !, %stheme.pcolour, $3, , %stheme.scolour, @, %stheme.pcolour, $replace($4, ., $+(, %stheme.scolour, ., , %stheme.pcolour)) , %stheme.scolour, *, %stheme.pcolour $6-) | haltdef }
raw 379:*: if (%stheme.themeon) { var %usermodes = $replace($6, +, $+(, %stheme.scolour, +, %stheme.pcolour)) | if (!%usermodes) var %usermodes = None | var %snomasks = $replace($7, +, $+(, %stheme.scolour, +, %stheme.pcolour)) | if (!%snomasks) var %snomasks = None | echo -a $timestamp $+(, %stheme.pcolour, - Usermodes:, %stheme.pcolour %usermodes) | echo -a $timestamp $+(, %stheme.pcolour, - Snomasks:, %stheme.scolour %snomasks) | haltdef }
raw 378:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - $2-5 , %stheme.scolour, $replace($6, ., $+(, %stheme.pcolour, ., , %stheme.scolour)), , %stheme.pcolour $replace($7, ., $+(, %stheme.scolour, ., , %stheme.pcolour))) | haltdef }
raw 307:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Registered nick: , %stheme.pcolour, Yes) | haltdef }
raw 319:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Channels:, %stheme.pcolour) $replace($3-, ~, $+(, %stheme.scolour, ~, %stheme.pcolour), &, $+(, %stheme.scolour, &, %stheme.pcolour), @, $+(, %stheme.scolour, @, %stheme.pcolour), $chr(37), $+(, %stheme.scolour, $chr(37), , %stheme.pcolour), +, $+(, %stheme.scolour, +, %stheme.pcolour)) | haltdef }
raw 312:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Server: , %stheme.pcolour, $3 Description, %stheme.pcolour $4-) | haltdef }
raw 301:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Away Reason: , %stheme.pcolour, $3-) | haltdef }
raw 313:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Status: , %stheme.pcolour, $5-) | haltdef }
raw 330:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - User:, %stheme.pcolour) $2 $4 $5 $6 $7 $3 | haltdef }
raw 335:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - , %stheme.pcolour, $2 $+  is signed on as a bot: , %stheme.pcolour, Yes ) | haltdef }
raw 338:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - , %stheme.pcolour, $2 $+  is $4- , %stheme.pcolour, $3 ) | haltdef }
raw 671:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Secure Connection: , %stheme.pcolour, Yes) | haltdef }
raw 320:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - $2 , %stheme.pcolour, $3-6 ,) | haltdef }
raw 317:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - Idle time:, %stheme.pcolour) $duration($3) $+(, %stheme.scolour, - Time Online:, %stheme.pcolour) $duration($calc($ctime - $4)) | haltdef }
raw 318:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - End of /whois)  | haltdef }
raw 401:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - User, %stheme.pcolour $2 not found) | haltdef } 
raw 402:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - $2 Is not connected to the server) | haltdef }
raw 640:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - $2 $3 $4 $5 $6 $7 $8 7 $+ $9 $10 $11 $12 $13 $14 )  | haltdef }

;notice output
raw 404:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 407:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 411:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 412:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 413:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 414:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 
raw 439:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.scolour, - $2-) | haltdef } 

;whowas output
raw 314:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - $2 was , %stheme.pcolour, $3, @, $4 , %stheme.scolour, $5 , %stheme.pcolour, $6) | haltdef }
raw 369:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - End of whowas ) | haltdef }
raw 406:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - $1 we found no such nickname as $2 ) | haltdef }
raw 431:*: if (%stheme.themeon) { echo -a $timestamp $+(, %stheme.pcolour, - We ran /whowas but you forgot a Nickname) | haltdef }

;who output
;raw 315:*: if (%stheme.themeon) { echo -a $+(, %stheme.pcolour, - End of /who list ) | haltdef }
raw 352:*: if (%stheme.themeon) { echo -a $+(, %stheme.scolour, - $6 , %stheme.pcolour, $2 , %stheme.scolour, $3 $+ , %stheme.pcolour, @ $+ , %stheme.scolour,  $4 , %stheme.pcolour, $5 ,) | haltdef }
raw 354:*: if (%stheme.themeon) { echo -a $+(, %stheme.pcolour, - $1 $2 $3 $4 $5 ) | haltdef }
raw 315:*: if (%stheme.themeon) { echo -a $+(, %stheme.pcolour, - $3-) | haltdef }
raw 416:*: if (%stheme.themeon) { echo -a $+(, %stheme.pcolour, - Too many lines in the output, restrict your query ) | haltdef }

;mode output
raw 8:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 221:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 324:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 329:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 367:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 368:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 369:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 441:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 442:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 461:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 467:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 472:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 478:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 482:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 483:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 485:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 501:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }
raw 502:*: if (%stheme.themeon) { echo -s $timestamp $+(, %stheme.scolour, - $2-) | haltdef }

;ban stats counter
on *:ban:#: {
  if ($banmask iswm $address($me, 5)) inc %stheme.banned
  if ($nick == $me) inc %stheme.bans
}

; Channel text output
on ^*:text:*:#: {
  if (%stheme.themeon) {
    haltdef
    if (%stheme.nickprefix == on) var %prefix = $left($nick($chan, $nick).pnick, 1) | if (%prefix != ~) && (%prefix != &) && (%prefix != @) && (%prefix != %) && (%prefix != +) unset %prefix
    if (%prefix == +) var %nickcolour = %stheme.voicenickcolour
    else if (%prefix == %) var %nickcolour = %stheme.halfopnickcolour
    else if (%prefix == @) var %nickcolour = %stheme.opnickcolour
    else if (%prefix == &) var %nickcolour = %stheme.adminnickcolour
    else if (%prefix == ~) var %nickcolour = %stheme.ownernickcolour
    else var %nickcolour = %stheme.nomodenickcolour
    if ($address($nick, 4) isin %stheme.friendlist) var %nickcolour = %stheme.friendnickcolour
    var %message = $replace($1-, $me,  $+ $me $+ )
    echo -ti2bflm # $+(, %stheme.pcolour, %stheme.leftnickchar, , %stheme.scolour, %prefix, , %nickcolour, $nick, , %stheme.pcolour, %stheme.rightnickchar,  %message)
    if (($away == $true) && ($me isin $1-)) {
      if (!$read(sthemeawaylog.txt, 2, $+(*, $nick, *))) notice $nick $+(, %stheme.pcolour, -- One time response to $me, : I am currently away: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $awaymsg, , %stheme.pcolour, %stheme.miscright - , Duration: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $duration2($awaytime), , %stheme.pcolour, %stheme.miscright - Current Time: , %stheme.pcolour, %stheme.miscleft, $remove($timestamp, %stheme.tstampleft, %stheme.tstampright), , %stheme.pcolour, %stheme.miscright)
      if (%stheme.awaylog == on) write sthemeawaylog.txt $+($timestamp 7, $nick, 14@7, $chan, 14@7, $network,  $1-)
    }
    colournicklist $chan
  }
}

;on *:text:*:?: {
;if (%stheme.themeon) {
;  haltdef
;  echo -tm $+(, %stheme.pcolour, %stheme.leftnickchar, , %stheme.scolour, %prefix, , %nickcolour, $nick, , %stheme.pcolour, %stheme.rightnickchar,  %message)
;}
;}


; Own text output for pvts
on *:input:#: {
  if (%stheme.themeon) {
    if ($left($1, 1) != /) {
      haltdef
      var %counter = 1
      while (%counter <= $0) {
        var %current = $ [ $+ [ %counter ] ]
        if (($left(%current, 1) == <) && ($right(%current, 1) == 3)) var %current = 4 $+ %current $+ 
        if (($left(%current, 1) == :) && ($right(%current, 1) == D)) var %current = 4 $+ %current $+ 
        if (($left(%current, 1) == :) && ($right(%current, 1) == P)) var %current = 12 $+ %current $+ 
        if (($left(%current, 1) == :) && ($right(%current, 1) == X)) var %current = 3 $+ %current $+ 
        var %message = %message %current
        inc %counter
      }
      var %message = $replace(%message, -.-, ¬.¬, -_-, ¬_¬)
      var %ownmessage = $replace(%message, -.-, ¬.¬, -_-, ¬_¬)
      .msg # %message
      if (%stheme.nickprefix == on) {
        var %prefix = $left($nick($chan, $me).pnick, 1)
        if (%prefix != ~) && (%prefix != &) && (%prefix != @) && (%prefix != %) && (%prefix != +) unset %prefix
      }
      echo -ti2bflm # $+(, %stheme.pcolour, %stheme.leftnickchar, , %stheme.scolour, %prefix, , %stheme.selfnickcolour, $me, , %stheme.pcolour, %stheme.rightnickchar, , $iif(%stheme.owntextcolour , %stheme.owntextcolour,  ), %ownmessage)
      inc %stheme.words $0
      inc %stheme.sentences 1
    }
    else {
      if ($1 == /me) {
        var %message = $replace($2-, -.-, ¬.¬, -_-, ¬_¬)
        describe $active %message
        inc %stheme.words $0
        inc %stheme.actions 1
        haltdef
      }
      else {
        if ($ctrlenter == $true) {
          haltdef
          var %counter = 1
          while (%counter <= $0) {
            var %current = $ [ $+ [ %counter ] ]
            if (($left(%current, 1) == <) && ($right(%current, 1) == 3)) var %current = 4 $+ %current $+ 
            var %message = %message %current
            inc %counter
          }
          ; var %message = $1-
          var %message = $replace(%message, -.-, ¬.¬, -_-, ¬_¬)
          var %ownmessage = $replace(%message, -.-, ¬.¬, -_-, ¬_¬)
          .msg $active %message
          if (%stheme.nickprefix == on) {
            var %prefix = $left($nick($chan, $me).pnick, 1)
            if (%prefix != ~) && (%prefix != &) && (%prefix != @) && (%prefix != %) && (%prefix != +) unset %prefix
          }
          echo -ti2bflm # $+(, %stheme.pcolour, %stheme.leftnickchar, , %stheme.scolour, %prefix, , %stheme.selfnickcolour, $me, , %stheme.pcolour, %stheme.rightnickchar, , $iif(%stheme.owntextcolour , %stheme.owntextcolour,  ), %ownmessage)
          inc %stheme.words $0
          inc %stheme.sentences 1
        }
      }
    }
    colournicklist $active
  }
}

; Colour nicklist on action/retaliation
on *:action:*:#: {
  if (%stheme.themeon) {
    if (($away == $true) && ($me isin $1-)) notice $nick $+(, %stheme.pcolour, -- I am currently away: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $awaymsg, , %stheme.pcolour, %stheme.miscright - , Duration: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $duration2($awaytime), , %stheme.pcolour, %stheme.miscright - Current Time: , %stheme.pcolour, %stheme.miscleft, $remove($timestamp, %stheme.tstampleft, %stheme.tstampright), , %stheme.pcolour, %stheme.miscright)
    colournicklist $chan
  }
  var %numtoks = $numtok(%stheme.retalnicks, 32)
  var %counter = 1
  var %retaliation = $1-
  var %nick = $left($nick, 3) $+  $+ $remove($nick, $left($nick, 3))
  while (%counter <= %numtoks) {
    var %current = $gettok(%stheme.retalnicks, %counter, 32)
    if (%current isin %retaliation) {
      %retaliation = $replace(%retaliation, %current, %nick)
      var %foundretal = 1
    }
    inc %counter
  }
  if ((($me isin $1-) || (%foundretal == 1)) && (%stheme.retaliation == on)) {
    %retaliation = $replace(%retaliation, $me, %nick)
    %retaliation.list = $replace(%retaliation, %nick, $me)
    ;describe $chan %retaliation
    write retaliation.txt in $chan on $network $nick did == %retaliation.list

  }
}

; Channel mode change output
on ^*:mode:#: {
  if (%stheme.themeon) {
    echo -ti2l # $+(, %stheme.pcolour, -- $nick sets mode , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $1-, , %stheme.pcolour, %stheme.miscright)
    haltdef
  }
}

; Raw mode change output
on ^*:rawmode:#: {
  if (%stheme.themeon) {
    if ($2 != $null) {
      echo -ti2l # $+(, %stheme.pcolour, -- $nick sets mode , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $1, , %stheme.pcolour, %stheme.miscright %stheme.miscleft, , %stheme.scolour, $2-, , %stheme.pcolour, %stheme.miscright)
      haltdef
    }
    colournicklist $chan
  }
}

; Parting channel output
on ^*:part:#: {
  if (%stheme.themeon) {
    if ($nick != $me) {
      var %numpeople = $calc($nick($chan, 0) - 1)
      echo -ti2l # $+(, %stheme.pcolour, -- Parts: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $address($nick, 5-), , %stheme.pcolour, %stheme.miscright , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, With Reason: $1- , , %stheme.pcolour, %stheme.miscright $iif($1, %stheme.miscleft $+  $+ %stheme.scolour $+ From $chan $+  $+ %stheme.pcolour $+ %stheme.miscright, )) $iif(%stheme.showusercount == on, - $+ %stheme.pcolour %stheme.miscleft $+  $+ %stheme.scolour $+ %numpeople people $+  $+ %stheme.pcolour $+ %stheme.miscright, )
      haltdef
    }
  }
}

; Joining channel output
on ^*:join:#: {
  if (%stheme.themeon) {
    if ($nick != $me) {
      var %numpeople = $nick($chan, 0)
      echo -ti2l # $+(, %stheme.pcolour, -- Joins: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $address($nick, 5), , %stheme.pcolour, %stheme.miscright) $iif(%stheme.showusercount == on, - $+ %stheme.pcolour %stheme.miscleft $+  $+ %stheme.scolour $+ %numpeople people $+  $+ %stheme.pcolour $+ %stheme.miscright, )
      haltdef
      colournicklist $chan
    }
    else colournicklist $active
  }
}

; Quit output
on ^*:quit: {
  if (%stheme.themeon) {
    var %counter = 1
    while (%counter <= $comchan($nick, 0)) {
      var %numpeople = $calc($nick($comchan($nick, %counter), 0) - 1)
      var %chan = 
      echo -ti2l $comchan($nick, %counter) $+(, %stheme.pcolour, -- Quits: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $iif($address($nick, 5), $address($nick, 5), $nick), , %stheme.pcolour, %stheme.miscright %stheme.miscleft, , %stheme.scolour, $1-, , %stheme.pcolour, %stheme.miscright) $iif(%stheme.showusercount == on, - $+ %stheme.pcolour %stheme.miscleft $+  $+ %stheme.scolour $+ %numpeople people $+  $+ %stheme.pcolour $+ %stheme.miscright, )
      inc %counter
    }
    unset % [ $+ stheme. $+ [ $nick ] $+ .joinchans ]
    haltdef
  }
}

; Nick change output
on ^*:nick: {
  if (%stheme.themeon) {
    haltdef 
    var %counter = 1
    while (%counter <= $comchan($newnick, 0)) {
      var %chan = $comchan($newnick, %counter)
      echo -ti2l $comchan($newnick, %counter) $+(, %stheme.pcolour, -- Nick change: , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $nick, , %stheme.pcolour, %stheme.miscright,  to , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $newnick, , %stheme.pcolour, %stheme.miscright)
      inc %counter
    }
    haltdef
  }
}

; Kick output
on ^*:kick:#: {
  if (%stheme.themeon) {
    haltdef
    if ($knick != $me) {
      var %numpeople = $calc($nick($chan, 0) - 1)
      echo -ti2l # $+(, %stheme.pcolour, --, %stheme.pcolour %stheme.miscleft, , %stheme.scolour, $knick, , %stheme.pcolour, %stheme.miscright,  kicked by, %stheme.pcolour %stheme.miscleft, , %stheme.scolour, $nick, , %stheme.pcolour, %stheme.miscright,  - , %stheme.pcolour, %stheme.miscleft, , %stheme.scolour, $1-, , %stheme.pcolour, %stheme.miscright) $iif(%stheme.showusercount == on, - $+ %stheme.pcolour %stheme.miscleft $+  $+ %stheme.scolour $+ %numpeople people $+  $+ %stheme.pcolour $+ %stheme.miscright, )
      if ($nick == $me) inc %stheme.kicks
    }
    else {
      echo -ti2l # $+(, %stheme.pcolour, -- You were kicked by, %stheme.pcolour %stheme.miscleft, , %stheme.scolour, $nick, , %stheme.pcolour, %stheme.miscright,  -, %stheme.scolour From, %stheme.pcolour %stheme.miscleft, , %stheme.scolour $+ $chan $+ , %stheme.pcolour, %stheme.miscright, , %stheme.pcolour %stheme.miscleft, , %stheme.scolour $+ $1- $+ , %stheme.pcolour, %stheme.miscright, ,)
      inc %stheme.kicked
    }
  }
}

; IAL Update script by Nimbus/ARcanUSNUMquam
;on *:START: unset %ial.*
;on *:JOIN:#: if ($nick == $me) who $chan | set %ial. [ $+ [ $chan ] ] $true
;raw 352:*: if (%ial. [ $+ [ $2 ] ] == $true) { haltdef }
;raw 315:*: if (%ial. [ $+ [ $2 ] ] == $true) { haltdef | unset %ial. [ $+ [ $2 ] ] }
;on *:EXIT: unset %ial.*
