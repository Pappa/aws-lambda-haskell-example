module User where

import GHC.Generics
import Data.Aeson
import Aws.Lambda
import Network.AWS.DynamoDB ()

import System.Environment

data App = App
    { usersTable :: String
    }

data Path = Path
  {
    uuId :: String
  } deriving (Generic)
instance FromJSON Path
instance ToJSON Path

data Event = Event
  {
    path :: Path
  } deriving (Generic)
instance FromJSON Event
instance ToJSON Event

handler :: Event -> Context -> IO (Either String String)
handler event context = do
  usersTable <- getEnv "DB_USERS_TABLE"
  return (Right (usersTable ++ uuId (path event)))
