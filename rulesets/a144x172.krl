ruleset a144x172 {
        meta {
                name "module_key_user"
                description <<

                >>
                author "Mark Horstmeier"
                logging off
                use module a144x171
                key d "local key"
        }

        dispatch {
                // domain "exampley.com"
        }

        global {
                a_me = keys:a();
                c_me = keys:c();
        }

        rule first_rule {
                select when pageview ".*" setting ()
                pre {
                        b_me = keys:b();
                }
                notify("Hello World", "This is a sample rule.");
        }

        rule event_send_raw {
                select when explicit foostorm
                pre {
                        b_me = keys:b();
                        struct = {
                                'a' : a_me,
                                'b' : b_me,
                                'c' : c_me,
                                'd' : keys:d(),
                                'other' : keys:c("universe"),
                                'b2' : keys:b()
                        };
                        textp = struct.encode();
                }
                {
                        send_raw("text/plain") 
                                with content = textp;
                }
        }
}
