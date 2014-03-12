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

	.controller('ProjectsCtrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {
		$scope.$root.title = 'Projekty';

		$scope.teachers = [];
		$http.get('/api/student/teachers.json')
			.then(function(result) {
				$scope.teachers = result.data; 
		});

	}]);