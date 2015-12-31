public class BKSL_SyncServiceRequest
{
    public static Boolean isServiceRequestLocked{get; set;}
    
    public BKSL_SyncServiceRequest()
    {
        isServiceRequestLocked = false;
    }
    
    public void afterInsertServiceRequestHandler(BKSL2__Service_Request__c objServiceRequest){
        if(objServiceRequest.BKSL2__Service__c != null && (BKSL_SyncServiceRequest.isServiceRequestLocked == NULL || BKSL_SyncServiceRequest.isServiceRequestLocked == false))
        {
            system.debug('objServiceRequest: ' + objServiceRequest);
            Event objEvent = new Event ();
            objEvent.Service_Request_Id__c = objServiceRequest.Id;
            objEvent.StartDateTime = objServiceRequest.BKSL2__Start_Date__c;
            objEvent.EndDateTime = objServiceRequest.BKSL2__End_Date__c;
            objEvent.ActivityDateTime = objEvent.StartDateTime;
            objEvent.Subject = objServiceRequest.Name;
            objEvent.WhoId = objServiceRequest.BKSL2__Contact__c;
            if(objServiceRequest.Request_Owner_Id__c != NULL)
                objEvent.OwnerId = objServiceRequest.Request_Owner_Id__c;
            insert objEvent;
        }
    }
    
    public void afterUpdateServiceRequestHandler(BKSL2__Service_Request__c objServiceRequest){
        if(objServiceRequest.BKSL2__Service__c != null && (BKSL_SyncServiceRequest.isServiceRequestLocked == NULL || BKSL_SyncServiceRequest.isServiceRequestLocked == false))
        {
            list<Event> lstEvent = [Select Id, WhoId, StartDateTime, EndDateTime, Subject from Event where Service_Request_Id__c = :objServiceRequest.Id];
            for(Event objEvent: lstEvent){
                objEvent.Service_Request_Id__c = objServiceRequest.Id;
                objEvent.StartDateTime = objServiceRequest.BKSL2__Start_Date__c;
                objEvent.EndDateTime = objServiceRequest.BKSL2__End_Date__c;
                objEvent.ActivityDateTime = objEvent.StartDateTime;
                objEvent.Subject = objServiceRequest.Name;
                objEvent.WhoId = objServiceRequest.BKSL2__Contact__c;
                if(objServiceRequest.Request_Owner_Id__c != NULL)
                    objEvent.OwnerId = objServiceRequest.Request_Owner_Id__c;
            }
            BKSL_SyncServiceRequest.isServiceRequestLocked = true;
            update lstEvent;
        }
    }
}