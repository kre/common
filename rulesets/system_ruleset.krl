ruleset system {

  meta {
    name "System Ruleset"
    description <<

This ruleset should be registered with the RID that corresponds to the RID configured as SYSTEM_RID in the pico engine configuration. The default is 'system'.

This ruleset controls and gives access to certain system information. 

>>
    author "PJW"
    logging off
    sharing on

    provides rid_usage
    
  }

  global {
    rid_usage = function(path) {
      app:rid_usage{ path.defaultsTo([]) }
    }
  }

  rule reset_rid_usage {
    select when rid_usage_reset_requested
    pre {
      path = event:attr("path").defaultsTo([]);
    }
    always {
      clear app:rid_usage
    } 
  }

}