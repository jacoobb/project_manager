'use strict';

angular.module('app.controllers', [])

	.controller('HomeCtrl', ['$scope', '$location', function ($scope, $location) {
		$scope.$root.title = 'Start';
	}])

	.controller('LoginCtrl', ['$scope', '$location', '$http', 'SessionService', function ($scope, $location, $http, SessionService) {
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

	}])

	.controller('MyProjectsCtrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {

		$scope.projects = [];

		$http.get('/api/student/projects.json')
			.then(function(result) {
				$scope.projects = result.data;
		});
	}])

	.controller('ProjectNegotiationCtrl', ['$scope', '$location', '$http', '$modal', function ($scope, $location, $http, $modal) {
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
      				show('Propozycja tematu została zapisana.', 'Informacja', 'OK', '', 1);
      			})
      			.error(function (data, status, headers, config) {
					show('Wystąpił błąd podczas zapisu tematu. Spróbuj ponownie później.', 'Błąd', 'OK', '', 1);
      			});
		};

		var show = function(m, t, okBtnText, cancelBtnText, numberOfBtns) {
			var modalInstance = $modal.open({
				templateUrl: '../templates/modal.html',
				controller: 'ModalCtrl',
				resolve: {
					items: function () {
						var i = {
							message: m,
							title: t,
							okBtnText: okBtnText,
							cancelBtnText: cancelBtnText
						}
						return i;
					}	
				}
			});

			modalInstance.result.then(function (response) {
				$location.path('/projects/my_projects');
			}, function() {	
			
			});
		};
	}])
	
	.controller('DiplomaThesesNegotiationCtrl', ['$scope', '$location', '$http', '$modal', function ($scope, $location, $http, $modal) {


	}])

	.controller('ModalCtrl', ['$scope', '$modalInstance', 'items', function ($scope, $modalInstance, items) {

		$scope.message = items.message;
		$scope.title = items.title;

		$scope.okBtnText = items.okBtnText;
		$scope.cancelBtnText = items.cancelBtnText;

		$scope.numberOfBtns = items.numberOfBtns;

		$scope.ok = function () {
			$modalInstance.close();
		};

		$scope.cancel = function () {
			$modalInstance.dismiss('cancel');
		};

	}]);

	