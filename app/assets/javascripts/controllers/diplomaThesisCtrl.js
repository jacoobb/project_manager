'use strict';

angular.module('app.controllers').controller('DiplomaThesisCtrl', ['$scope', '$location', '$http', '$modal', 'TextService', 'SessionService', function ($scope, $location, $http, $modal, TextService, SessionService) {
	$scope.isCollapsed = [];

	$scope.diplomaThesis = [];
	$http.get('/api/diploma_projects.json').then(function(result) {
		$scope.diplomaThesis = result.data;

		for(var i=0; i<result.data.length; i++) {
			$scope.isCollapsed[i] = true;
		}
	});

	$scope.getProjectTypeText = function(type) {
		return TextService.getProjectTypeText(type);
	};

	$scope.userType = SessionService.userType;

	$scope.diplomaThesisId = -1;
	$scope.confirm = function(diplomaThesisId) {
		$scope.diplomaThesisId = diplomaThesisId;

   		show('Czy napewno chcesz zarezerwować temat pracy dyplomowej?', 'Uwaga', 'Tak', 'Nie', 2);
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
						cancelBtnText: cancelBtnText,
						numberOfBtns: numberOfBtns
					}
					return i;
				}	
			}
		});

		modalInstance.result.then(function (response) {
			if($scope.diplomaThesisId != -1) {
				$http.post('/api/student/project_reservations', { id: $scope.diplomaThesisId }).success(function (data, status, headers, config) {
   					$scope.diplomaThesisId = -1;
   					show('Temat pracy dyplomowej został zarezerwowany.', 'Informacja', 'OK', '', 1);
  				}).error(function (data, status, headers, config) {
					$scope.diplomaThesisId = -1;
					show('Wystąpił błąd podczas rezerwacji tematu. Spróbuj ponownie później.', 'Błąd', 'OK', '', 1);
   				});
			} else {
				$location.path('/diploma_thesis');
			}
		}, function() {	
		});
	};

}]);