'use strict';

angular.module('app.controllers').controller('DivideProjectCtrl', ['$scope', '$location', '$http', '$modal', function ($scope, $location, $http, $modal) {
	$scope.projectId = -1;
	$scope.projects = [];
	
	$http.get('/api/teacher/projects.json?project_type=subject').then(function(result) {
		angular.forEach(result.data, function(p) {
			if(p.members.length == 0) {
				$scope.projects.push(p);
			}	
		});

		$scope.projectId = $scope.projects[0].id;
	});

	var p1 = { name: "", description: ""};
	var p2 = { name: "", description: ""};
	$scope.newProjects = [p1, p2];

	$scope.divide = function() {
		$http.post('/api/teacher/project/divisions', { project_id: $scope.projectId, divisions: { projects: $scope.newProjects } })
   			.success(function (data, status, headers, config) {
   			show('Temat został podzielony.', 'Informacja', 'OK', '', 1);
		}).error(function (data, status, headers, config) {
			show('Wystąpił błąd podczas podziału tematu. Spróbuj ponownie później.', 'Błąd', 'OK', '', 1);
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