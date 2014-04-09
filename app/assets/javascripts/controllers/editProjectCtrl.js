'use strict';

angular.module('app.controllers').controller('EditProjectCtrl', ['$scope', '$location', '$http', '$routeParams', '$modal', 'TextService', 'SessionService', function ($scope, $location, $http, $routeParams, $modal, TextService, SessionService) {

	$scope.topic = null;
	$scope.description = null;

	$http.get('/api/teacher/projects/' + $routeParams.id + '.json').then(function(result) {
		$scope.topic = result.data.name;
		$scope.description = result.data.description;
	});

	$scope.save = function(topic, description) {
		$http.put('/api/teacher/projects/' + $routeParams.id, { project_proposal: { project: { name: topic, description: description }}}).success(function (data, status, headers, config) {
  			show('Zmiany zostały zapisane.', 'Informacja', 'OK', '', 1);
		}).error(function (data, status, headers, config) {
			show('Wystąpił błąd podczas zapisywania zmian. Spróbuj ponownie później.', 'Błąd', 'OK', '', 1);
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
	
}]);