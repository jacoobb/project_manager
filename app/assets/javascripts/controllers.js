'use strict';

angular.module('app.controllers', [])

	.controller('LoginCtrl', ['$scope', '$location', 'AuthService', 'SessionService', function ($scope, $location, AuthService, SessionService) {
		$scope.$root.title = 'Logowanie';

		$scope.userType = 'student';

		$scope.message = '';

		$scope.setUserType = function(userType) {
			$scope.userType = userType;
		};

		$scope.login = function(userName, password) {
			if($scope.userType == 'student') {
				userName = "88457";
	      		password = "12qwaszx";
				AuthService.login(userName, password, $scope.userType).then(function() {
					$location.path('/');
				}, function () {
					$scope.message = 'Nieprawidłowy numer albumu lub hasło';
				});
	      	} else {
	      		userName = "zabawa@gmail.com";
	      		password = "12qwaszx";
	      		AuthService.login(userName, password, $scope.userType).then(function() {
					$location.path('/');
				}, function () {
					$scope.message = 'Nieprawidłowy email lub hasło';
				});
	      	}
		};
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

	