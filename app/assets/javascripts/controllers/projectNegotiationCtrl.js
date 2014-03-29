'use strict';

angular.module('app.controllers').controller('ProjectNegotiationCtrl', ['$scope', '$location', '$http', '$modal', 'TextService', function ($scope, $location, $http, $modal, TextService) {
	$scope.teacherId = -1;
	$scope.teachers = [];

	$scope.subjects = [];
	$http.get('/api/student/teachers.json').then(function(result) {
		$scope.teachers = result.data;
		$scope.teacherId = result.data[0].id;
		$scope.getSubjects();
	});

	$scope.getSubjects = function() {
		$http.get('/api/student/teacher/subjects.json?teacher_id=' + $scope.teacherId).then(function(result) {
			$scope.subjects = result.data;
		});
	};

	$scope.getSubjectTypeText = function(type) {
		return TextService.getSubjectTypeText(type);
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
}]);