trigger syncServiceRequest on Event (after insert, after update) {
	BKSL_SyncEvent handlerClass = new BKSL_SyncEvent();
	
	if(Trigger.isInsert)
    {
		for(Event objEvent : Trigger.new )
        {
			handlerClass.afterInsertEventHandler(objEvent);
		}
	}
	if(Trigger.isUpdate)
    {
		for(Event objEvent : Trigger.new )
        {
			handlerClass.afterUpdateEventHandler(objEvent);
		}
	}
}