on *:NOTICE:*:*: {
  set %ln. [ $+ [ $network ] ]  $nick
}

alias rp {
  notice %ln. [ $+ [ $network ] ] $$1-
  .unset %ln. [ $+ [ $network ] ]
}
