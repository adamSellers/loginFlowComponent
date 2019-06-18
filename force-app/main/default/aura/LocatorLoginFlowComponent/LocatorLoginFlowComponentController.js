({
  onInit: function(component, event, helper) {
    // on component load, get location details
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        position => {
          var lat = position.coords.latitude;
          var lon = position.coords.longitude;
          component.set("v.latitude", lat);
          component.set("v.longitude", lon);
        },
        err => {
          console.warn(err);
        }
      );
    }
  },

  handleBlur: function(component) {
    // query all the required attributes from the component
    var branchCode = component.get("v.branchCode");
    var latitude = component.get("v.latitude");
    var longitude = component.get("v.longitude");
    var tolerance = component.get("v.tolerance");
    var units = component.get("v.units");

    // get the method from the backend controller
    var action = component.get("c.getBranchLocationDetails");

    // set up parameter input
    action.setParams({
      locationCode: branchCode,
      lat: latitude,
      lon: longitude,
      units: units,
      tolerance: tolerance
    });

    // call ther server side function
    action.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        // update the allow login parameter
        console.log("in the success state: " + response.getReturnValue());
        component.set("v.allowLogin", response.getReturnValue());
      } else if (state === "ERROR") {
        console.log("in the error state");
        var errors = response.getErrors();
        if (errors) {
          if (errors[0] && errors[0].message) {
            console.log("Error message: " + errors[0].message);
          }
        } else {
          console.log("unkown error");
        }
      }
    });
    // queue the action and fire it.
    console.log("about to queue stuff");
    $A.enqueueAction(action);
  }
});
