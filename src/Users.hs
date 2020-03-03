module Users where

import GHC.Generics
import Data.Aeson
import Aws.Lambda
import Network.AWS.DynamoDB ( getItem, giKey )
import Control.Monad.Trans.AWS ( send )

import Data.HashMap.Strict ( fromList )
import Control.Lens ((<&>), (^.), (.~), (&), set)
import System.Environment ( getEnv )
import Data.Text ( pack, unpack )

data App = App
    { usersTable :: String
    }

data Path = Path
  {
    userId :: String
  } deriving (Generic)
instance FromJSON Path
instance ToJSON Path

data Event = Event
  {
    path :: Path
  } deriving (Generic)
instance FromJSON Event
instance ToJSON Event

read :: Event -> Context -> IO (Either String String)
read event context = do
  usersTable <- pack $ getEnv "DB_USERS_TABLE"
  let q = fromList [("userId", (userId $ path event))]
  result <- send $ getItem usersTable & giKey .~ q
  print result
  return (Right ((unpack usersTable) ++ userId (path event)))
