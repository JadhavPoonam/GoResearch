'use strict';

angular.module('app', ['ngRoute', 'ngResource', 'ui.bootstrap', 'ngFileUpload', 'ngFileSaver', 'angulartics', 'angulartics.google.analytics'])
    .config(function ($routeProvider, $httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];

        //$httpProvider.interceptors.push('AuthenticationInterceptor');
        $routeProvider
            .when('/', {
                templateUrl: 'resources/scripts/controllers/home.html',
                controller: 'HomeCtrl',
                controllerAs: 'ctrl'
            })
            .when('/deny',
            {
                // templateUrl: 'resources/scripts/controllers/deny/deny.html',
                // caseInsensitiveMatch: true
            })
            .otherwise({
                redirectTo: '/deny'
            });
    });
    // angular.module('app').run(function ($window, $location) {
    //     if($window.sessionStorage.getItem('originalUrl')) {
    //         $location.url($window.sessionStorage.getItem('originalUrl'));
    //         delete $window.sessionStorage.originalUrl;
    //     }
    // });
