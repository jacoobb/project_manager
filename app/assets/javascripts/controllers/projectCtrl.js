'use strict';

angular.module('app.controllers').controller('ProjectCtrl', ['$scope', '$location', '$http', '$routeParams', 'TextService', 'SessionService', function ($scope, $location, $http, $routeParams, TextService, SessionService) {
	$scope.project = null;
	$scope.students = [];
	
	if(SessionService.userType == 'student') {
		$http.get('/api/student/projects/' + $routeParams.id + '.json').then(function(result) {
			$scope.project = result.data;
		});

		$http.get('/api/students.json').then(function(result) {
			$scope.students = result.data;
		});
	} else {
		$http.get('/api/teacher/projects/' + $routeParams.id + '.json').then(function(result) {
			$scope.project = result.data;
		});
	}

	$scope.addMember = function(student) {
		var studentIds = new Array();
		studentIds.push(student.id);

		$http.post('/api/student/project/team_members', { project_id: $routeParams.id, team_members: { ids: studentIds } })
   			.success(function (data, status, headers, config) {
   				alert('DODANO');
		}).error(function (data, status, headers, config) {
				alert('NIE DODANO');
   		});		
	};	
	
}]);
