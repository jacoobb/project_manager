'use strict';

angular.module('app.controllers').controller('AddThesisCtrl', ['$scope', '$location', '$http', '$modal', function ($scope, $location, $http, $modal) {
	$scope.firstDegree = true;
	$scope.secondDegree = true;

	$scope.change = function() {
		if($scope.firstDegree == false && $scope.secondDegree == false) {
			$scope.firstDegree = true;
			$scope.secondDegree = true;
		}
	};

	$scope.categories = [];
	$http.get('/api/categories.json').then(function(result) {
		$scope.categories = result.data;
	});

	$scope.technologies = [];
	$http.get('/api/technologies.json').then(function(result) {
		$scope.technologies = result.data;
	});

	$scope.selectedCategories = [];
	$scope.removeCategory = function(category) {
		$scope.selectedCategories.splice($scope.selectedCategories.indexOf(category), 1);
	};

	$scope.addCategory = function(category) {
		if(category instanceof Object == true) {
			if($scope.selectedCategories.indexOf(category) == -1) {
				$scope.selectedCategories.push(category);
			}
		}
	};

	$scope.selectedTechnologies = [];
	$scope.removeTechnology = function(technology) {
		$scope.selectedTechnologies.splice($scope.selectedTechnologies.indexOf(technology), 1);
	};

	$scope.addTechnology = function(technology) {
		if(technology instanceof Object == true) {
			if($scope.selectedTechnologies.indexOf(technology) == -1) {
				$scope.selectedTechnologies.push(technology);
			}
		}
	};

	$scope.add = function(topic, description) {
		var categoryIds = new Array();
		$scope.selectedCategories.forEach(function(element) {
			categoryIds.push(element.id);
		});

		var technologyIds = new Array();
		$scope.selectedTechnologies.forEach(function(element) {
			technologyIds.push(element.id);
		});

		var projectType = 'first_degree';
		if($scope.firstDegree == true && $scope.secondDegree == true) {
			projectType = 'diploma';
		} else if($scope.secondDegree == true) {
			project_type = 'second_degree';
		}


		$http.post('/api/teacher/projects', { project_proposal: { project: { name: topic, description: description, project_type: projectType }, category_ids: categoryIds, technology_ids: technologyIds }})
   			.success(function (data, status, headers, config) {
   				show('Temat pracy dyplomowej został zapisany.', 'Informacja', 'OK', '', 1);
  			}).error(function (data, status, headers, config) {
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
			$location.path('/diploma_thesis/my_thesis');
		}, function() {	
		
		});
	};
}]);
