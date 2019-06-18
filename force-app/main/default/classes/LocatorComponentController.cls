public with sharing class LocatorComponentController {
    @AuraEnabled
    public static Boolean getBranchLocationDetails(String locationCode, Decimal lat, Decimal lon, String units, Double tolerance){
        List<Account> inRange = new List<Account>();
        inRange = [SELECT Id, ShippingAddress FROM Account WHERE Location_Code__c =: locationCode];

        if (!inRange.isEmpty()) {
            // setup shipping location
            Location shippingLocation = inRange[0].ShippingAddress;
            // create new instance of Location for input user location
            Location userLocation = Location.newInstance(lat, lon);

            // check if user distance within tolerance
            if (shippingLocation.getDistance(userLocation, units) < tolerance) {
                return true;
            }
        }
        return false;
    }
}
