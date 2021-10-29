{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Increment where

import Foundation
import Yesod.Core
import Data.IORef

getRequestsR :: Handler Value
getRequestsR = do
    visitorsRef <- fmap visitors getYesod
    visitors <-
        liftIO $ atomicModifyIORef visitorsRef $ \i ->
        (i + 1, i + 1)
    returnJson $ RequestCount visitors