'use strict';

angular.module('app.controllers').controller('ProjectCtrl', ['$scope', '$location', '$http', '$routeParams', 'TextService', 'SessionService', function ($scope, $location, $http, $routeParams, TextService, SessionService) {
	$scope.project = null;

	if(SessionService.userType == 'student') {
		$http.get('/api/student/projects/' + $routeParams.id + '.json').then(function(result) {
			$scope.project = result.data;
		});
	} else {
		$http.get('/api/teacher/projects/' + $routeParams.id + '.json').then(function(result) {
			$scope.project = result.data;
		});
	}
}]);
