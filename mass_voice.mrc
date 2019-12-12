alias mv {
  ; Was told to add this because some people might not know you need +o||+h to +v people.
  if (!$nick(#,$me,ho)) {
    echo -at *** You need to be either +o or +h in # to use /mv
  }
  else {
    ; Record total users
    var %a $nick(#,0)
    ; Loop through all users
    while (%a) {
      ; If the user isn't voice, add them to the list of users to be voiced
      if ($nick(#,%a) !isvoice #) var %b %b $nick(#,%a)
      ; Once the max users we can voice @ one time has been reached, send out the mode command and unvar the 'to-voice' list
      if ($numtok(%b,32) == $modespl) { mode # $+(+,$str(v,$modespl)) %b | var %b $null }
      ; Prepare to check the next user
      dec %a
    }
    ; While loop has ended, push out any remaining users in our 'to-voice' list. (if any)
    if (%b) mode # $+(+,$str(v,$numtok(%b,32))) %b
  }
}
