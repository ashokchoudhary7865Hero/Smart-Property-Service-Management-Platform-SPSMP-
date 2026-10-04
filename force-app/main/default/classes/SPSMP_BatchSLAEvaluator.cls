/**
 * @description Batch Apex to evaluate and mark SLA breached Service Requests daily.
 * @author Ashok kumar
 */
public class SPSMP_BatchSLAEvaluator implements Database.Batchable<sObject>, Schedulable {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        DateTime thresholdTime = System.now().addHours(-48);
        return Database.getQueryLocator([
            SELECT Id, Status__c, Priority__c, CreatedDate 
            FROM Service_Request__c 
            WHERE Status__c NOT IN ('Resolved', 'Closed') 
            AND CreatedDate <= :thresholdTime
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Service_Request__c> scope) {
        List<Service_Request__c> requestsToUpdate = new List<Service_Request__c>();
        
        for (Service_Request__c req : scope) {
            req.Priority__c = 'Urgent';
            requestsToUpdate.add(req);
        }
        
        if (!requestsToUpdate.isEmpty()) {
            update requestsToUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('SPSMP SLA Evaluation Batch Job Completed Successfully.');
    }

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new SPSMP_BatchSLAEvaluator(), 200);
    }
}