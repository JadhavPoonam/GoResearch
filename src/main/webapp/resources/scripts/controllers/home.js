'use strict';

angular.module('app').controller('HomeCtrl', function (ResearchAreaService) {
    
     var ctrl = this;

    ctrl.init = function() {
        ResearchAreaService.getAll().$promise
            .then(function(response){
                ctrl.data = response;
            });
    }
});
