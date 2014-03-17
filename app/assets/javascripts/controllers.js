'use strict';

angular.module('app.controllers', [])

	.controller('HomeCtrl', ['$scope', '$location', '$window', function ($scope, $location, $window) {
		$scope.$root.title = 'Start';

		//$scope.$on('$viewContentLoaded', function () {
		//	$window.ga('send', 'pageview', {'page': $location.path(), 'title': $scope.$root.title });
		//});
	}])

	.controller('LoginCtrl', ['$scope', '$location', '$window', '$http', 'SessionService', function ($scope, $location, $window, $http, SessionService) {
		$scope.$root.title = 'Logowanie';

		//$scope.$on('$viewContentLoaded', function () {
		//	$window.ga('send', 'pageview', {'page': $location.path(), 'title': $scope.$root.title });
		//});

		$scope.message = '';

		$scope.login = function(matriculaNumber, password) {
			$http.post('/api/student/session', { student: { matricula_number: "88456", password: "12qwaszx" } })
      			.success(function (data, status, headers, config) {
        			//$window.sessionStorage.token = data.token;
        			SessionService.isAuth = true;
        			SessionService.userName = 'Maciej';

        			$location.path('/');

      			})
      			.error(function (data, status, headers, config) {
        			//delete $window.sessionStorage.token;
					$scope.message = 'Nieprawidłowy numer albumu lub hasło';
      			});
		};

		$scope.logout = function() {
			$http.delete('/api/student/session:88456')
      			.success(function (data, status, headers, config) {
      				SessionService.isAuth = false;
        			SessionService.userName = '';

        			$location.path('/login');
      			})
      			.error(function (data, status, headers, config) {
					
      			});
		};
	}])

	.controller('MyProjectsCtrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {

		$scope.projects = [];

		$http.get('/api/student/projects.json')
			.then(function(result) {
				$scope.projects = result.data;
		});
	}])

	.controller('ProjectNegotiationCtrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {
		$scope.$root.title = 'Projekty';

		$scope.teacherId = -1;
		$scope.teachers = [];

		$scope.subjects = [];

		$http.get('/api/student/teachers.json')
			.then(function(result) {
				$scope.teachers = result.data;
				$scope.teacherId = result.data[0].id;

				$scope.getSubjects();
		});

		$scope.getSubjects = function() {
			$http.get('/api/student/teacher/subjects.json?teacher_id=' + $scope.teacherId)
				.then(function(result) {
					$scope.subjects = result.data;
			});
		};


		$scope.add = function(teacherId, subjectId, topic, description) {
			$http.post('/api/student/projects', { project_proposal: { project: { name: topic, description: description, project_type: "subject" }, teacher_id: teacherId, subject_id: subjectId }})
      			.success(function (data, status, headers, config) {
        			alert('ok');
      			})
      			.error(function (data, status, headers, config) {
					alert('dupa');
      			});
		};
	}]);