let pkg = https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/default.dhall

in pkg //
  { compiler = [0,3,8]
  , version = [0,3,9]
  , atsSource = [ "ats-src/combinatorics.dats", "ats-src/number-theory.dats", "ats-src/numerics.dats" ]
  }
