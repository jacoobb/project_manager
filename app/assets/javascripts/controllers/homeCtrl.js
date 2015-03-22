'use strict';

angular.module('app.controllers').controller('HomeCtrl', ['$scope', '$location', '$http', 'TextService', 'SessionService', function ($scope, $location, $http, TextService, SessionService) {
	$scope.activityLogs = [];

	if(SessionService.userType == 'student') {
		$http.get('/api/student/activity_logs.json').then(function(result) {
			$scope.activityLogs = result.data;
		});
	} else {
		$http.get('/api/teacher/activity_logs.json').then(function(result) {
			$scope.activityLogs = result.data;
		});
	}

	$scope.getActivityTypeText = function(type) {
		return TextService.getActivityTypeText(type);
	};
}]);
