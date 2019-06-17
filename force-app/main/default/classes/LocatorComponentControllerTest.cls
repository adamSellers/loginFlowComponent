@isTest
private class LocatorComponentControllerTest {
    // test class for the locator component controller
    static @IsTest void testLocatorComp(){
        
        Test.startTest();
        // setup data
        Account testAccount = new Account();
        testAccount.name = 'Test1';
        testAccount.ShippingStreet = '201 Sussex St';
        testAccount.ShippingCity = 'Sydney';
        testAccount.ShippingPostalCode = '2000';
        testAccount.ShippingState = 'NSW';
        testAccount.ShippingCountry = 'Australia';
        testAccount.Location_Code__c = 'abc123';
        testAccount.ShippingLatitude = -33.872000;
        testAccount.ShippingLongitude = 151.203950; 

        // insert account
        insert testAccount;

        // call the controller
        Boolean shouldBeFalse = LocatorComponentController.getBranchLocationDetails('abc123', -34.010833399999996, 151.0690115, 'km', 2);
        Boolean shouldBeTrue = LocatorComponentController.getBranchLocationDetails('abc123', -34.010833399999996, 151.0690115, 'km', 40);
        
        // System assertions
        System.assertEquals(false, shouldBeFalse);
        System.assertEquals(true, shouldBeTrue);
        Test.stopTest();
    }
}
