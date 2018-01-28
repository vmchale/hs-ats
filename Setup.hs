import           Distribution.ATS
import           Distribution.Simple

main = defaultMainWithHooks $
    atsUserHooks [ libgmp, intinf, atsPrelude [0,3,8] ]
