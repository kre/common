ruleset countFires {
	meta {
		name "Count Fires"
		description << Count times a rule fires >>
		author "Nicholas Angell"
		sharing on
		provides getCount, cancelEvent, cancelAllEvents, getScheduledEvents, getHistory, getAllHistory
	}

	global {
		getCount = function() {
			ent:count;
		}
		cancelEvent = function(id) {
			event:delete(id);
		}
		cancelAllEvents = function() {
			allEvents = event:get_list();
			allEvents.map(function(ev) {
				event:delete(ev[0]);
			});
		}
		getScheduledEvents = function() {
			event:get_list();
		}
		getHistory = function(id) {
			event:get_history(id);
		}
		getAllHistory = function() {
			allEvents = event:get_list();
			allEvents.map(function(ev) {
				event:get_history(ev[0]);
			});
		}
	}

	rule count {
		select when do_main night_fire
		pre {
			c = ent:count + 1;
		}
		{
			send_directive("night_fire detected")
				with count = c;
		}
		fired {
			set ent:count c;
		}
	}

	rule createSchedule {
		select when begin scheduling
		pre {
			do_main = "do_main";
			c = ent:count;
		}
		{
			send_directive("night_fire scheduled")
				with count = c;
		}
		fired {
			schedule do_main event night_fire repeat "0 * * * *";
		}
	}

	rule createRepeating {
		select when begin repeating
		pre {
			do_main = "do_main";
			recurring = event:attr("recurring");
			c = ent:count;
		}
		{
			send_directive("night_fire scheduled")
				with count = c
				and frequency = recurring;
		}
		fired {
			schedule do_main event night_fire repeat recurring;
		}
	}

	rule createSingle {
		select when begin single
		pre {
			do_main = "do_main";
			time = event:attr("time").defaultsTo(time:add(time:now(),{"seconds":60}), standardError("No time was given"));
			c = ent:count;
		}
		{
			send_directive("night_fire scheduled")
				with count = c
				and clock = time;
		}
		fired {
			schedule do_main event night_fire at time;
		}
	}

	rule cancelSchedule {
		select when cancel scheduling
		pre {
			id = event:attr("id");
		}
		{
			send_directive("canceled Schedule")
				with eventID = id;
			cancelSchedule(id);
		}
		fired {
			log("Cancelled Scheduled Event");
		}
	}
}