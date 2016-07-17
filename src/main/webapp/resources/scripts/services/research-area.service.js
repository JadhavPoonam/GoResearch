'use strict';

angular.module('app').factory('ResearchAreaService', function ($resource) {
    return $resource('research-area', {}, {

        getAll: { method: 'GET', url: 'research-area'}

    });
});
