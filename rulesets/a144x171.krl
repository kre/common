ruleset a144x171 {
        meta {
                name "module_key_provider"
                description <<

                >>
                author "Mark Horstmeier"
                logging off
                key a "slartibartfast"
                key b "42"
                key c {
                        "life" : "fjords",
                        "universe" : "norway",
                        "everything" : "magrathean"
                }
                key d "Module key"
                provide keys a,b,c to a144x172
        }

        dispatch {
                // domain "exampley.com"
        }

        global {

        }

        rule first_rule {
                select when pageview ".*" setting ()
                pre {

                }
                notify("Hello World", "This is a sample rule.");
        }
}
