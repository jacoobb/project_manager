'use strict';

angular.module('app.controllers', [])

	.controller('LoginCtrl', ['$scope', '$location', '$http', 'SessionService', function ($scope, $location, $http, SessionService) {
		$scope.$root.title = 'Logowanie';

		$scope.userType = 'student';

		$scope.message = '';

		$scope.changeClass = function(userType) {
			$scope.userType = userType;
		};

		$scope.login = function(userName, password) {
			if($scope.userType == 'student') {
				$http.post('/api/student/session', { student: { matricula_number: "88456", password: "12qwaszx" } })
	      			.success(function (data, status, headers, config) {
	        			SessionService.isAuth = true;
	        			SessionService.userName = 'Maciej';
						SessionService.userType = 'student';

	        			$location.path('/');
	      			})
	      			.error(function (data, status, headers, config) {
						$scope.message = 'Nieprawidłowy numer albumu lub hasło';
      			});
	      	} else {
	      		$http.post('/api/teacher/session', { teacher: { email: "zabawa@gmail.com", password: "12qwaszx" } })
	      			.success(function (data, status, headers, config) {
	        			SessionService.isAuth = true;
	        			SessionService.userName = 'Maciej';
	        			SessionService.userType = 'teacher';

	        			$location.path('/');
	      			})
	      			.error(function (data, status, headers, config) {
						$scope.message = 'Nieprawidłowy email lub hasło';
      			});
	      	}
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

	.controller('DiplomaThesisNegotiationCtrl', ['$scope', '$location', '$http', '$modal', function ($scope, $location, $http, $modal) {


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

	