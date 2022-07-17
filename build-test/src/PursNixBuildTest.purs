module PursNixBuildTest where

import Prelude
import Effect (Effect)
import Effect.Console as Console

log :: Effect Unit
log = Console.log "build test"
