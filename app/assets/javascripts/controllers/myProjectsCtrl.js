'use strict';

angular.module('app.controllers').controller('MyProjectsCtrl', ['$scope', '$location', '$http', 'TextService', 'SessionService', function ($scope, $location, $http, TextService, SessionService) {

	$scope.projects = [];
	
	if(SessionService.userType == 'student') {
		$http.get('/api/student/projects.json?project_type=subject').then(function(result) {
			$scope.projects = result.data;
		});
	} else {
		$http.get('/api/teacher/projects.json?project_type=subject').then(function(result) {
			$scope.projects = result.data;
		});
	}

	$scope.getSubjectTypeText = function(type) {
		return TextService.getSubjectTypeText(type);
	};

	$scope.userType = SessionService.userType;
}]);