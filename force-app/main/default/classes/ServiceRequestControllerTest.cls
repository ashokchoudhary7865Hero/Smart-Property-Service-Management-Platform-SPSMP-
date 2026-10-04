@isTest
private class ServiceRequestControllerTest {
    @isTest
    static void testControllerMethods() {
        // Test Record Creation
        Service_Request__c sr = new Service_Request__c(
            Property_Name__c = 'Test Controller Property',
            Category__c = 'Plumbing',
            Status__c = 'New',
            Priority__c = 'High',
            Estimated_Cost__c = 2000,
            Actual_Cost__c = 1500
        );
        insert sr;

        Test.startTest();
        // Controller ke dono methods call kar rahe hain
        List<Service_Request__c> requests = ServiceRequestController.getOpenServiceRequests();
        Map<String, Integer> metrics = ServiceRequestController.getRequestMetrics();
        Test.stopTest();

        // Verification
        System.assert(requests.size() > 0, 'Service requests list should not be empty');
        System.assertEquals(1, metrics.get('Total'), 'Total metrics should count the inserted record');
        System.assertEquals(1, metrics.get('New'), 'New metrics should count the inserted record');
    }
}