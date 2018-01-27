let pkg = https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/default.dhall

in pkg //
  { compiler = [0,3,8]
  , version = [0,3,9]
  , dependencies = [ https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/atscntrb-hx-intinf-1.0.6.dhall
                   , https://raw.githubusercontent.com/vmchale/atspkg/master/pkgs/atscntrb-libgmp-1.0.4.dhall
                   ]
  , atsSource = [ "ats-src/combinatorics.dats", "ats-src/number-theory.dats", "ats-src/numerics.dats" ]
  , cDir = "cbits"
  }
