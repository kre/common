ruleset a144x157 {
    meta {
	name "send_raw_text_plain"
	description <<
		
	>>
	author "Mark Horstmeier"
	logging off
}

dispatch {
	// domain "exampley.com"
}

global {
    xtime = time:httptime(time:now());
    full = <<
    If the foo sits, wear it #{xtime}
    >>;
}

rule first_rule {
	select when pageview ".*" setting ()
	pre {
	
	}
    {
    	send_raw("text/plain") 
            with content = full
            and headers = {
                'Cache-Control' : 'max-age=5',
                'Last-Modified' : xtime
            };
    }
  }
  
rule scheduled_event_response {
    select when notification slartibartfast
    pre {
        
    }
    {
        send_raw("text/plain") 
            with content = full
            and headers = {
                'Cache-Control' : 'max-age=5',
                'Last-Modified' : xtime
            };

    }
}

rule post_checker {
    select when notification agrajag
    pre {
     myhash = event:attrs();
     json = myhash.encode();
     blob = <<foo#{json}off>>;
    }
    {
        send_raw("text/plain") 
            with content = blob;  
    }
}
}