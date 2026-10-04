/**
 * @description Controller for LWC Service Dashboard.
 * @author Ashok kumar
 */
public with sharing class ServiceRequestController {

    @AuraEnabled(cacheable=true)
    public static List<Service_Request__c> getOpenServiceRequests() {
        return [
            SELECT Id, Name, Property_Name__c, Category__c, Status__c, Priority__c, Estimated_Cost__c, CreatedDate 
            FROM Service_Request__c 
            ORDER BY CreatedDate DESC 
            LIMIT 100
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getRequestMetrics() {
        Map<String, Integer> metrics = new Map<String, Integer>{
            'Total' => 0,
            'New' => 0,
            'InProgress' => 0,
            'Resolved' => 0
        };

        for (AggregateResult ar : [SELECT Status__c st, COUNT(Id) cnt FROM Service_Request__c GROUP BY Status__c]) {
            String statusVal = (String)ar.get('st');
            Integer countVal = (Integer)ar.get('cnt');
            
            metrics.put('Total', metrics.get('Total') + countVal);
            if (statusVal == 'New') metrics.put('New', countVal);
            if (statusVal == 'In Progress') metrics.put('InProgress', countVal);
            if (statusVal == 'Resolved') metrics.put('Resolved', countVal);
        }
        return metrics;
    }
}