trigger GardenTrigger on CAMPX__Garden__c (before insert, after insert) {
    Switch on Trigger.operationType{
        when BEFORE_INSERT {
            GardenTriggerHandler.handleBeforeInsert(Trigger.new);
        }
        when AFTER_INSERT {
            GardenTriggerHandler.handleAfterInsert(Trigger.new);
        }
    }
}