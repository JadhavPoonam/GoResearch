'use strict';

angular.module('app').directive('sidemenu',['$document', function($document){

return {
  template: '<div class="sidebar" ng-transclude></div>',
  replace: true,
  transclude: true,
  restrict: 'E',
  link: function(scope, element, attr){
    scope.sideMenu = false;

    $document.bind('click', function(event){
      var isMenuClicked = event.target.classList.contains('hamburger');
      if (isMenuClicked){
        scope.sideMenu = !scope.sideMenu;
      }
      else{
        scope.sideMenu = false;
      }
      scope.$apply();
    });
  }
};
}]);
