{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module MyLib
  ( defaultMain

  -- Exposed for testing purposes
  , application
  )
  where

import Foundation
import Increment
import Reset

import Yesod.Core
import Data.IORef
import Network.Wai.Handler.Warp (run)

mkYesodDispatch "App" resourcesApp

application :: IO Application
application = do
    visitorsRef <- newIORef 0
    toWaiApp App { visitors = visitorsRef }

defaultMain :: IO ()
defaultMain = do
    app <- liftIO application
    run 8080 app
