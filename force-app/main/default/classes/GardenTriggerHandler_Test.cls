@isTest private class GardenTriggerHandler_Test {
    
    @TestSetup
    static void makeData(){
        List<CAMPX__Garden__c> testGardens = new List<CAMPX__Garden__c>();

        CAMPX__Garden__c testGarden1 = new CAMPX__Garden__c();
        testGarden1.CAMPX__Manager__c = System.UserInfo.getUserId();
        testGardens.add(testGarden1);

        CAMPX__Garden__c testGarden2 = new CAMPX__Garden__c();
        testGarden2.CAMPX__Irrigation_System__c = 'Drip';
        testGardens.add(testGarden2);

        CAMPX__Garden__c testGarden3 = new CAMPX__Garden__c();
        testGarden3.CAMPX__Type__c = 'Backyard';
        testGardens.add(testGarden3);

        insert testGardens;
    }

    @isTest static void confirmFieldsUpdated(){

        //Query gardens and relevant fields
        List<CAMPX__Garden__c> gardens = [SELECT Id, CAMPX__Irrigation_System__c, CAMPX__Type__c, CAMPX__Sun_Exposure__c
                                          FROM CAMPX__Garden__c];

        //Assert first garden had all 3 fields updated (from null)
        Assert.areEqual('Manual', gardens[0].CAMPX__Irrigation_System__c);
        Assert.areEqual('Indoor', gardens[0].CAMPX__Type__c);
        Assert.areEqual('Partial Sun', gardens[0].CAMPX__Sun_Exposure__c);

        //Assert second garden Irrigation System field NOT updated
        Assert.areEqual('Drip', gardens[1].CAMPX__Irrigation_System__c);

        //Assert third garden Type field NOT updated
        Assert.areEqual('Backyard', gardens[2].CAMPX__Type__c);

        //Pull any tasks that were created
        List<Task> newTasks = [SELECT Id FROM Task];

        //Assert that 1 task was created since garden[0] has a manager Id
        Assert.areEqual(1, newTasks.size());
    }

    @isTest static void confirmTasksCreated(){

        //Pull any tasks that were created
        List<Task> newTasks = [SELECT Id FROM Task];

        //Assert that 1 task was created since CAMPX__Manager__c on testGarden1 is not null
        Assert.areEqual(1, newTasks.size());
    }
}