module EncodePanda.Lens where

import Data.Function ((&))

-- start snippet conference-datatype
data Conference = Conference
  { organizer :: Organizer
  , speakers  :: [Speaker]
  } deriving Show
-- end snippet conference-datatype

-- start snippet organizer-datatype
data Organizer = Organizer
  { name    :: Name
  , contact :: Contact
  } deriving Show
-- end snippet organizer-datatype

-- start snippet speaker-datatype
data Speaker = Speaker
  { slidesReady :: Bool
  } deriving Show
-- end snippet speaker-datatype

-- start snippet name-datatype
data Name = Name
  { firstName :: String
  , lastName  :: String
  } deriving Show
-- end snippet name-datatype

-- start snippet contact-datatype
data Contact = Contact
  { address :: Address
  , email   :: String
  } deriving Show
-- end snippet contact-datatype

-- start snippet address-datatype
data Address = Address
  { street  :: String
  , city    :: String
  , country :: String
  } deriving Show
-- end snippet address-datatype

-- start snippet oli
oli :: Organizer
oli = Organizer
  { name = Name "Oli" "Makhasoeva"
  , contact = classified
  }
-- end snippet oli

classified :: Contact
classified = Contact
  { address = Address "Class" "ified" "Classified"
  , email = "oli@haskell.love"
  }

-- start snippet organizerCountry
organizerCountry :: Conference -> String
organizerCountry conf =
  conf & organizer
       & contact
       & address
       & country
-- end snippet organizerCountry
