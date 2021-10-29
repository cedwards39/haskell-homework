{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE ViewPatterns         #-}
--{-# LANGUAGE RecordWildCards      #-}
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

--data RequestCount = RequestCount
--    { value :: Int}
--    deriving Show

--instance ToJSON RequestCount where
--    toJSON RequestCount {..} = object
--        [ "value" .= value]

--postResetR :: Handler Value
--postResetR = do 
--    visitorsRef <- fmap visitors getYesod
--    visitors <- liftIO $ atomicModifyIORef visitorsRef $ \_ -> (0, 0)
--    returnJson $ RequestCount visitors

--getRequestsR :: Handler Value
--getRequestsR = do
--    visitorsRef <- fmap visitors getYesod
--    visitors <-
--        liftIO $ atomicModifyIORef visitorsRef $ \i ->
--        (i + 1, i + 1)
--    returnJson $ RequestCount visitors

application :: IO Application
application = do
    visitorsRef <- newIORef 0
    toWaiApp App { visitors = visitorsRef }

defaultMain :: IO ()
defaultMain = do
    app <- liftIO application
    run 8080 app
