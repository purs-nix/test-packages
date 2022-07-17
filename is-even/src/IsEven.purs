module IsEven (isEven) where

import IsOdd (isOdd)

foreign import not :: Boolean -> Boolean

isEven :: Int -> Boolean
isEven n = not (isOdd n)
