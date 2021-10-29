{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Reset where

import Foundation
import Yesod.Core
import Data.IORef

postResetR :: Handler Value
postResetR = do 
    visitorsRef <- fmap visitors getYesod
    visitors <- liftIO $ atomicModifyIORef visitorsRef $ \_ -> (0, 0)
    returnJson $ RequestCount visitors
