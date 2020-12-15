module EncodePanda.OverloadedLabels where


import GHC.OverloadedLabels (IsLabel (..))
import EncodePanda.Lens2

-- start snippet islabel
instance IsLabel "encodepanda" Speaker where
  fromLabel = Speaker
    { name = Name "Pawel" "Szulc"
    , slidesReady = False
    }
-- end snippet islabel

-- start snippet pawel
pawel :: Speaker
pawel = fromLabel @"encodepanda"
-- end snippet pawel
