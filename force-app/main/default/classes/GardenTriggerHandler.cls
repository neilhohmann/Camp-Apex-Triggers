public with sharing class GardenTriggerHandler {
    
    public static void handleBeforeInsert(List<CAMPX__Garden__c> newGardens){
        for(CAMPX__Garden__c garden : newGardens){
            if(garden.CAMPX__Irrigation_System__c == null){
                garden.CAMPX__Irrigation_System__c = 'Manual';
            }
            if(garden.CAMPX__Type__c == null){
                garden.CAMPX__Type__c = 'Indoor';
            }
            if(garden.CAMPX__Sun_Exposure__c == null){
                garden.CAMPX__Sun_Exposure__c = 'Partial Sun';
            }  
        }
    }

    public static void handleAfterInsert(List<CAMPX__Garden__c> newGardens){
        //Empty list to hold tasks
        List<Task> tasksToInsert = new List<Task>();

        for(CAMPX__Garden__c garden : newGardens){
            //Check to see if the manager field is populated
            if(garden.CAMPX__Manager__c != null){
                //Create a task
                Task newTask = new Task();
                newTask.Subject = 'Acquire Plants';
                newTask.WhatId = garden.Id;
                //Add task to list
                tasksToInsert.add(newTask);
            }
        }
        insert tasksToInsert;
    }
}