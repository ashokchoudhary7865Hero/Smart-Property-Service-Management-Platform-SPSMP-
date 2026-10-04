trigger ServiceRequestTrigger on Service_Request__c (before insert, before update) {for (Service_Request__c req : Trigger.new) {
        if (req.Description__c != null) {
            String descLower = req.Description__c.toLowerCase();
            
            // Emergency Keyword Check for Plumbing and Electrical Categories
            if ((req.Category__c == 'Plumbing' || req.Category__c == 'Electrical') &&
                (descLower.contains('leak') || descLower.contains('fire') || 
                 descLower.contains('short circuit') || descLower.contains('emergency') || 
                 descLower.contains('blast'))) {
                
                req.Priority__c = 'Urgent';
            }
        }
    }

}