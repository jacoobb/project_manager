'use strict';

angular.module('app.controllers').controller('MyThesisCtrl', ['$scope', '$location', '$http', 'TextService', 'SessionService', function ($scope, $location, $http, TextService, SessionService) {

	$scope.diplomaThesis = [];

	if(SessionService.userType == 'student') {
		$http.get('/api/student/projects.json?project_type=diploma').then(function(result) {
			$scope.diplomaThesis = result.data;
		});
	} else {
		$http.get('/api/teacher/projects.json?project_type=diploma').then(function(result) {
			$scope.diplomaThesis = result.data;
		});
	}

	$scope.getProjectTypeText = function(type) {
		return TextService.getProjectTypeText(type);
	};

	$scope.userType = SessionService.userType;
}]);