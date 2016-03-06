trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
	List<Task> listTask = new List<Task>();
	for(Opportunity opp:Trigger.new){
		if(opp.StageName == 'Closed Won'){
			Task t = new Task(Subject = 'Follow Up Test Task',WhatId = opp.Id);
			listTask.add(t);
		}
	}

	insert listTask;

}