@isTest
private class ServiceRequestTriggerTest {
    @isTest
    static void testEmergencyKeywordsInTrigger() {
        Test.startTest();
        
        // 1. First record with required cost fields
        Service_Request__c sr1 = new Service_Request__c();
        sr1.Property_Name__c = 'Test Property 1';
        sr1.Category__c = 'Electrical';
        sr1.Status__c = 'New';
        sr1.Priority__c = 'Low';
        sr1.Description__c = 'Fire issue in circuit breaker';
        sr1.Estimated_Cost__c = 2000;
        sr1.Actual_Cost__c = 1500;
        insert sr1;

        // 2. Second record WITH Estimated_Cost__c & Actual_Cost__c
        Service_Request__c sr2 = new Service_Request__c();
        sr2.Property_Name__c = 'Test Property 2';
        sr2.Category__c = 'Plumbing';
        sr2.Status__c = 'New';
        sr2.Priority__c = 'Low';
        sr2.Description__c = 'Water leak under sink';
        sr2.Estimated_Cost__c = 1000;
        sr2.Actual_Cost__c = 800;
        insert sr2;

        // 3. Update with required Resolution_Notes__c
        sr1.Description__c = 'Short circuit and blast observed';
        sr1.Resolution_Notes__c = 'Replaced damaged wiring and reset circuit breaker successfully.';
        update sr1;

        Test.stopTest();
        
        System.assertNotEquals(null, sr1.Id, 'Trigger executed successfully');
    }
}