{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
{-# LANGUAGE RecordWildCards   #-}
module Foundation where

import Yesod.Core
import Data.IORef

data RequestCount = RequestCount
    { value :: Int}
    deriving Show

instance ToJSON RequestCount where
    toJSON RequestCount {..} = object
        [ "value" .= value]

data App = App
    { visitors :: IORef Int
    }

mkYesodData "App" $(parseRoutesFile "routes.yesodroutes")

instance Yesod App
