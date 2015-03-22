'use strict';

angular.module('app.controllers').controller('AddProjectCtrl', ['$scope', '$location', '$http', '$modal', 'TextService', function ($scope, $location, $http, $modal, TextService) {
	$scope.subjectId = -1;
	$scope.subjects = [];
	$http.get('/api/teacher/subjects.json').then(function(result) {
		$scope.subjects = result.data;
		$scope.subjectId = result.data[0].id;
	});

	$scope.categories = [];
	$http.get('/api/categories.json').then(function(result) {
		$scope.categories = result.data;
	});

	$scope.technologies = [];
	$http.get('/api/technologies.json').then(function(result) {
		$scope.technologies = result.data;
	});

	$scope.getSubjectTypeText = function(type) {
		return TextService.getSubjectTypeText(type);
	};

	$scope.selectedCategories = [];
	$scope.removeCategory = function(category) {
		$scope.selectedCategories.splice($scope.selectedCategories.indexOf(category), 1);
	};

	$scope.addCategory = function(category) {
		if($scope.selectedCategories.indexOf(category) == -1) {
			$scope.selectedCategories.push(category);
		}
	};

	$scope.selectedTechnologies = [];
	$scope.removeTechnology = function(technology) {
		$scope.selectedTechnologies.splice($scope.selectedTechnologies.indexOf(technology), 1);
	};

	$scope.addTechnology = function(technology) {
		if($scope.selectedTechnologies.indexOf(technology) == -1) {
			$scope.selectedTechnologies.push(technology);
		}
	};

	$scope.add = function(teacherId, subjectId, topic, description) {
		var categoryIds = new Array();
		$scope.selectedCategories.forEach(function(element) {
			categoryIds.push(element.id);
		});

		var technologyIds = new Array();
		$scope.selectedTechnologies.forEach(function(element) {
			technologyIds.push(element.id);
		});

		$http.post('/api/teacher/projects', { project_proposal: { project: { name: topic, description: description, project_type: 'subject' }, category_ids: categoryIds, technology_ids: technologyIds, subject_id: subjectId }})
   			.success(function (data, status, headers, config) {
   				show('Temat projektu został dodany.', 'Informacja', 'OK', '', 1);
		}).error(function (data, status, headers, config) {
				show('Wystąpił błąd podczas dodawania projektu. Spróbuj ponownie później.', 'Błąd', 'OK', '', 1);
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