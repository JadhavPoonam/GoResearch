(function () {
    'use strict';

    /**
     * Directive
     */
    angular.module('ucFeedback', ['vcRecaptcha']).directive('ucFeedback', function ($modal, $sce, CONTEXT_PATH) {
        return {
            restrict: 'E',
            replace: true,
            scope: {
                eppn: '@eppn',
                appName: '@appName',
                appEnv: '@appEnvironment',
                appVersion: '@appVersion'
            },
//            templateUrl: $sce.trustAsResourceUrl(CONTEXT_PATH + '/resources/scripts/directives/uc-feedback/uc-feedback-template.html'),
              templateUrl: $sce.trustAsResourceUrl('https://ehs.ucop.edu/ucvoice-stage/resources/scripts/directives/uc-feedback/uc-feedback-template.html'),
            controller: function ($scope) {

                $scope.startFeedback = function () {
                    var modalInstance = $modal.open({
                        templateUrl: 'modalContent.html',
                        controller: 'ModalInstanceCtrl',
                        resolve: {
                            eppn: function () {
                                return $scope.eppn;
                            },
                            appName: function () {
                                return $scope.appName;
                            },
                            appEnv: function () {
                                return $scope.appEnv;
                            },
                            appVersion: function () {
                                return $scope.appVersion;
                            }
                        },
                        backdrop: 'static'
                    });

                    modalInstance.result.then(function () {
                        // Modal closed
                    }, function () {
                        // Modal dismissed
                    });
                };
            }
        };
    });

    /**
     * Modal Controller
     */
    angular.module('ucFeedback').controller('ModalInstanceCtrl', function ($scope, $http, $modalInstance, vcRecaptchaService, UcFeedbackService, eppn, appName, appEnv, appVersion) {
        /**
         * Init
         */
        $scope.eppn = eppn;
        $scope.appName = appName;
        $scope.appEnv = appEnv;
        $scope.appVersion = appVersion;

        // Better email regex than the one used in type="email"
        $scope.emailRegex = /^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/;

        $scope.step = 1;

        $scope.feedback = {
            comment: {
                problem: '',
                question: '',
                compliment: '',
                idea: ''
            }
        };
        $scope.problemOpen = true;
        $scope.comment = '';
        $scope.cResponse = '';
        $scope.maxLength = 2000;
        $scope.remaining = function (comment) {
            return comment ? $scope.maxLength - comment.length : $scope.maxLength;
        };
        $scope.isFormValid = function () {
            return  (
                ($scope.feedbackForm.problem.$valid ||
                    $scope.feedbackForm.question.$valid ||
                    $scope.feedbackForm.compliment.$valid ||
                    $scope.feedbackForm.idea.$valid) &&
                $scope.cResponse !== ''
                );
        };

        /**
         * Actions
         */
        $scope.submit = function () {
            $scope.busy = true;
            $scope.message = messages.success;
            $scope.step += 1;

            $scope.post();
        };


        $scope.captchaResponse = function (response) {
            $scope.cResponse = response;
        };

        $scope.post = function () {
            var params = {};
            var data = {
                eppn: $scope.eppn,
                applicationEnvironment: $scope.appEnv,
                applicationVersion: $scope.appVersion,
                applicationName: $scope.appName,
                commentProblem: $scope.feedback.comment.problem,
                commentQuestion: $scope.feedback.comment.question,
                commentIdea: $scope.feedback.comment.idea,
                commentCompliment: $scope.feedback.comment.compliment,
                isAnonymous: false,
                applicationUrl: document.URL,
                browserName: getBrowser().name,
                browserVersion: getBrowser().version,
                os: getOS(),
                ipInfo: null,
                captchaResponse: $scope.cResponse
            };
            UcFeedbackService.postFeedback(params, data)
                .success(function (response) {
                    $scope.message = messages.success;
                    $scope.busy = false;
                })
                .error(function () {
                    $scope.messsage = messages.error;
                    $scope.busy = false;
                });
        };

        $scope.close = function () {
            $modalInstance.close();
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    });

    /**
     * UC Voice web service methods
     */
    angular.module('ucFeedback').config(function ($httpProvider) {
        //Enable cross domain calls
        $httpProvider.defaults.useXDomain = true;

        //Remove the header used to identify ajax call that would prevent CORS from working
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
    });
    angular.module('ucFeedback').service('UcFeedbackService', ['$http', function ($http) {
        this.postFeedback = function (params, data) {
            return $http({
                method: 'POST',
                url: 'https://ehs.ucop.edu/ucvoice-stage/secure/api/feedback/',
                params: params,
                data: data,
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        };
    }]);

    /**
     * Utilities
     */
    var messages = {
        busy: 'Submitting...',
        success: 'Thank you for your feedback!',
        error: 'There was an error in submitting your feedback. We apologize for the inconvenience.'
    };

    var operatingSystems = [
        {
            appVersion: 'Win',
            name: 'Windows'
        },
        {
            appVersion: 'Mac',
            name: 'MacOS'
        },
        {
            appVersion: 'X11',
            name: 'UNIX'
        },
        {
            appVersion: 'Linux',
            name: 'Linux'
        }
    ];

    function getBrowser() {
        var ua = navigator.userAgent, tem, M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
        if (/trident/i.test(M[1])) {
            tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
            return 'IE ' + (tem[1] || '');
        }
        if (M[1] === 'Chrome') {
            tem = ua.match(/\bOPR\/(\d+)/)
            if (tem != null) {
                return 'Opera ' + tem[1];
            }
        }
        M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
        if ((tem = ua.match(/version\/(\d+)/i)) != null) {
            M.splice(1, 1, tem[1]);
        }
        return {
            name: M[0],
            version: M[1]
        };
    }

    function getOS() {
        var appVersion = navigator.appVersion;
        var os = '';

        angular.forEach(operatingSystems, function (operatingSystem, index) {
            if (appVersion.indexOf(operatingSystem.appVersion) != -1) {
                os = operatingSystem.name;
            }
        });

        return os;
    }
}).call(this);