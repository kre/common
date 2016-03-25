ruleset a16x132 {
	meta {
		name "Test Notifications"
		description <<
Puts up a form to gather data for user events and raises the correct notification events. 			
		>>
		author "Phil Windley"
		logging on
	}

	dispatch {
		domain "digitalme.kynetx.com"
        domain "exampley.com"
	}

	global {

	}

	rule show_notification_form {
		select when pageview ".*"
		pre {
            form = <<
<div id="notification_test">
<form id="notify_form" action="javascript:function(){return false;}">
<table style="color: white" border=0>
<tr>
<td>Application:</td><td><input type="text" name="application" value="Test Form"  /></td>
</tr>
<tr>
<td>Subject:</td><td><input type="text" name="subject" value="" />  </td>
</tr>
<tr>
<td>Priority:</td><td> 
<select name="priority">
  <option value="-2">-2</option>
  <option value="-1">-1</option>
  <option value="0" selected="selected">0</option>
  <option value="1">1</option>
  <option value="2">2</option>
</select></td>
</tr>
<tr>
<td>Description:</td><td></td></tr>
</tr>
<tr>
<td colspan=2><textarea name="desc" rows="8" cols="33"></textarea></td>
</tr>
<tr>
<td></td><td align="right"><input type="submit" name="Send Notification" value="Send Notification" id="h" /></td>
</tr>
</table>
</form>
<ul id="notify_data">
</ul>
</div>
>>;
		
		}
	{
      notify("Test System Notifications", form)
        with sticky=true and
             width = "290px";
      watch("#notify_form", "submit");
	}
   }
   
   rule respond_submit is active {
     select when web submit "#notify_form"
     pre {
        priority = event:attr("priority");
        application = event:attr("application");
        subject = event:attr("subject");
        desc = event:attr("desc");
        text = "<li>Application #{application}: #{subject} (#{priority}) says #{desc}</li>";
     }
     {
       append("#notify_data", text);
     }
     always {
         raise notification event status with
           priority = priority and
           application = application and
           subject = subject and
           description = desc and
           _api = "sky" 
     }
   } 
}
