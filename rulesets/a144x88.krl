ruleset a144x88 {
  meta {
    name "composed notify"
    description <<
      Trivial example of composed action
    >>
    configure using dflt = "Default Composed Header"
    provide nartify
  }

  dispatch {
  }

  global {
    nartify = defaction (x,y) {
      configure using w=" Nartify Config "
      every {
        notify(dflt + x, y + w);
      }
    }
  }

}
