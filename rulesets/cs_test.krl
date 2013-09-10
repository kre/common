ruleset cs_test {
    meta {
        name "CS Test 1"
        author "Phil Windley"
        description <<
Ruleset that the eval servers use for self testing (cs.t)     
>>
        logging off    
        key errorstack "192345"
        key googleanalytics  "fg593940"
        key twitter {
          "consumer_key": 5837874827498274939,
          "consumer_secret" : "3HNb7NfdadadadahdajdhgajlkjakldaMtLahvkMt6Std5SO0"
        }

    }
    dispatch {
        domain "www.google.com"
        domain "www.yahoo.com" -> "cs_test_1"
        domain "www.live.com"
    }
    global {
        dataset public_timeline <- "http://www.google.com/calendar/feeds/developer-calendar@google.com/public/full?alt=json&max-results=5&singleevents=true";        
        dataset cached_timeline <- "http://www.google.com/calendar/feeds/developer-calendar@google.com/public/full?alt=json&max-results=5&singleevents=true" cachable;
        emit <<
var foobar = 5;                >>
;    }
    rule test_rule_1 is active {
        select using "/([^/]+)/bar.html" setting (x)

        replace("#kynetx_12", "/kynetx/google_ad.inc");
    }
    rule test_rule_2 is active {
        select using "/foo/bazz.html" setting ()

        pre {
        }
        if referer:search_engine_referer()
        then
            every {
                float("absolute", "top: 10px", "right: 10px", ("http://frag.kobj.net/widgets/weather.pl?zip=" + (zip + ("&city=" + (city + ("&state=" + state))))))
                with
                        delay = 0 and
                        draggable = true and
                        effect = "appear";
                float("kynetx_12", "/kynetx/google_ad.inc");
            }
        
    }
    rule test_rule_3 is inactive {
        select using "/foo/bazz.html" setting()

        pre {
        }
        if referer:search_engine_referer()
        then
            every {
                float("absolute", "top: 10px", "right: 10px", ("http://frag.kobj.net/widgets/weather.pl?zip=" + (zip + ("&city=" + (city + ("&state=" + state))))))
                with
                        delay = 0 and
                        draggable = true and
                        effect = "appear";
                float("kynetx_12", "/kynetx/google_ad.inc");
            }
        
    }
    
    // should fire rule in cs_test_1
    rule test_rule_4 is active {
      select when pageview "/fizzer/fuzzer.html"
      noop();
      always {
        raise explicit event fuzzer for cs_test_1 
           with foo = "bar" 
            and fop = "bop"
      }
    }
    
    // should fire full in cs_test_1 under Sky
    rule test_rule_5 is active {
      select when pageview "/test_rule_5"
      noop();
      always {
        raise explicit event fuzzer 
           with foo = "bar" 
            and fop = "bop"
      }
    }
    
    // should fire test_rule_7 in this ruleset AND test_rule_other_7 in cs_test_1
    rule test_rule_6 is active {
      select when pageview "/test_rule_6"
      noop();
      always {
        raise explicit event test_rule_7 
          with foo = "bar" 
           and fop = "bop"
      }
   }

   rule test_rule_7 is active {
     select when explicit test_rule_7
     noop();
  }
  
  // should only fire test_rule_7 from this ruleset, not any others
  rule test_rule_8 is active {
      select when pageview "/test_rule_8"
      noop();
      always {
        raise explicit event test_rule_7 for cs_test
      }
  }

  // should only fire test_rule_7 from this ruleset, not any others
rule test_rule_9 is active {
    select when pageview "/test_rule_9"
    noop();
    always {
      raise explicit event test_rule_7 for meta:rid()
    }
}

rule test_error_1 {
    select when system error
    pre {}
   noop();
  }

  rule test_error_2 {
  select when system error genus "operator"
  pre {}
 noop();
}

  rule test_rule_over_1 is active {
    select when explicit test_rule_over_1
    append("#over", "Over")
    always {
      raise explicit event test_rule_out_1
    }
  }

}

