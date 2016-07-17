'use strict';

/**
 * Directive
 */
angular.module('app').directive('profile', function($modal, $sce, $templateCache) {
    // Templates
    $templateCache.put('profileLink.html', '<a href class="{{linkClasses}}" ng-click="openProfile()">{{linkText}}</a>');
    $templateCache.put('profileModal.html', '<style>.modal-dialog{width: 35%; min-width: 300px; max-width: 500px; padding: 0; overflow-y: hidden;}.modal-content{border: 0;}.modal-header{height: 65px;}.modal-body{padding: 0; height:70vh;}@media screen and (max-width: 768px){.modal-body{padding: 0; height:100vh;}}iframe{border: 0; width: 100%; min-height: 100%; z-index: 1;}.error{position: absolute; top: 1em; left: 1em;}</style> <div class="modal-header"> <h3 class="modal-title pull-left" style="font-weight: 100;">{{profileModalCtrl.options.modalTitle}}</h3> <button type="button" class="close" data-dismiss="modal" aria-label="Close" ng-click="profileModalCtrl.dismiss()"> <span style="font-weight: 100;" aria-hidden="true">&times;</span> </button> </div><div class="modal-body"> <iframe id="profile-frame" ng-src="{{profileModalCtrl.profileUrl}}" ng-show="profileModalCtrl.ok"></iframe> <div class="error" ng-hide="profileModalCtrl.ok"> <p> There has been an error. </p><p ng-show="profileModalCtrl.errorMessage">{{profileModalCtrl.errorMessage}}</p></div></div>');

    return {
        restrict: 'E',
        replace: true,
        scope: {
            options: '@options',
            groupId: '@groupId',
            onClose: '&onClose',
            onDismiss: '&onDismiss'
        },
        template: $templateCache.get('profileLink.html'),
        controller: function($scope) {
            // Options
            var options = JSON.parse($scope.options);
            $scope.linkText = options.linkText;
            if(!options.hasOwnProperty('modalTitle')) {
                options.modalTitle = options.linkText;
            }
            $scope.linkClasses = options.linkClasses;

            // Modal control
            $scope.openProfile = function() {
                var modalInstance = $modal.open({
                    template: $templateCache.get('profileModal.html'),
                    controller: 'ProfileModalCtrl',
                    controllerAs: 'profileModalCtrl',
                    resolve: {
                        options: function() {
                            return options;
                        },
                        groupId: function() {
                            return $scope.groupId;
                        }
                    },
                    backdrop: 'static',
                    windowClass: 'app-modal-window'
                });

                modalInstance.result.then(function (data) {
                    $scope.onClose({data: data});
                }, function () {
                    $scope.onDismiss();
                });
            };
        }
    };
});

/**
 * Modal Controller
 */
angular.module('app').controller('ProfileModalCtrl', function ($route, $window, $modalInstance, $sce, options, groupId, PROFILE_URL, ENV, CLIENT_KEY) {
    var ctrl = this;

    /**
     * Init
     */
    ctrl.ok = true;
    ctrl.options = options;
    ctrl.validateOptions = function() {
        var requiredFields = ['eppn', 'linkText'];
        var missingFields = [];

        requiredFields.map(function(field) {
            if(!ctrl.options.hasOwnProperty(field)) {
                missingFields.push(field);
            }
        });

        ctrl.ok = missingFields.length < 1;

        if(!ctrl.ok && ENV !== 'Production' && ENV !== 'Stage') {
            ctrl.errorMessage = 'Missing required fields: ' + missingFields.join(', ');
        }

        return ctrl.ok;
    };

    if(ctrl.validateOptions()) {
        // Set up modal
        var baseUrl = PROFILE_URL + '/secure-modal/';
        var switchOrCreateUrl = '';
        //baseUrl + CLIENT_KEY + '#/' + ctrl.options.eppn + '/wizard/path/b/'; // Create bundle
        if(ctrl.options.eppn == 'ahpilla@ucdavis.edu' || ctrl.options.eppn == 'mrbennin@ucdavis.edu') {
            switchOrCreateUrl = baseUrl + CLIENT_KEY + '#/?switchprofile';
        } else {
            switchOrCreateUrl = baseUrl + CLIENT_KEY + '#/' + ctrl.options.eppn + '/wizard/path/b/'; // Create bundle
        }

        var url = groupId ?
        baseUrl + '#/?groupid=' + groupId : switchOrCreateUrl; // Edit bundle
        ctrl.profileUrl = $sce.trustAsResourceUrl(url);

        // Register post message event listener
        var a = document.createElement('a');
        a.href = PROFILE_URL;
        var validOrigin = a.protocol + '//' + a.hostname;
        $window.addEventListener('message', function(event) {
            if (validOrigin !== event.origin || !event.data.hasOwnProperty('groupId')) {
                return;
            }

            ctrl.close(event.data);
        });
    }

    /**
     * Actions
     */
    ctrl.close = function(data) {
        $modalInstance.close(data);
    };

    ctrl.dismiss = function() {
        $modalInstance.dismiss();
    };

});