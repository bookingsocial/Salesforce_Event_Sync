trigger syncEvent on BKSL2__Service_Request__c (after insert, after update) {

	BKSL_SyncServiceRequest handlerClass = new BKSL_SyncServiceRequest();
	if(Trigger.isInsert)
    {
		for(BKSL2__Service_Request__c objServiceRequest : Trigger.new )
        {
			handlerClass.afterInsertServiceRequestHandler(objServiceRequest);
		}
	}
	if(Trigger.isUpdate)
    {
		for(BKSL2__Service_Request__c objServiceRequest : Trigger.new )
        {
			handlerClass.afterUpdateServiceRequestHandler(objServiceRequest);
		}
	}
}