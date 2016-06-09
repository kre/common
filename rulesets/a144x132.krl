ruleset a144x132 {
	meta {
                name "EventEx after"
                description <<

                >>
                author "Mark Horstmeier"
                logging off
        }

        dispatch {
                // domain "exampley.com"
        }

        global {
        mod = "change to flush cache";
        }
    
        rule test_rule_first is active {
    	    select when pageview "first.html"
            notify("Event 1", "first page");
        }
    
        rule test_rule_second is active {
    	    select when pageview "second.html"
            notify("Event 2", "Second page");
	}

	rule test_rule_then is active {
             select when pageview "(second).html"  setting (foo)
	            after  pageview "(first).html" setting (bar)

                notify("Test Rule After", foo + " after " + bar);
       }
}
