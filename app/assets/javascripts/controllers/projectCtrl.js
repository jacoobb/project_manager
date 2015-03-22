'use strict';

angular.module('app.controllers').controller('ProjectCtrl', ['$scope', '$location', '$http', '$route', '$routeParams', '$modal', 'TextService', 'SessionService', function ($scope, $location, $http, $route, $routeParams, $modal, TextService, SessionService) {
	$scope.project = null;
	$scope.students = [];
	
	if(SessionService.userType == 'student') {
		$http.get('/api/student/projects/' + $routeParams.id + '.json').then(function(result) {
			$scope.project = result.data;
		});

		$http.get('/api/students.json').then(function(result) {
			result.data.forEach(function (element) {
				var s = new Object();
				s.name = element.first_name + ' ' + element.last_name;
				s.id = element.id;

				$scope.students.push(s);
			});
		});
	} else {
		$http.get('/api/teacher/projects/' + $routeParams.id + '.json').then(function(result) {
			$scope.project = result.data;
		});
	}

	$scope.addMember = function(student) {
		if(student instanceof Object == true) {
			var studentIds = new Array();
			studentIds.push(student.id);

			$http.post('/api/student/project/team_members', { project_id: $routeParams.id, team_members: { ids: studentIds } }).success(function (data, status, headers, config) {
   				show('Dodano studenta do projektu.', 'Informacja', 'OK', '', 1);
			}).error(function (data, status, headers, config) {
				show('Wystąpił błąd podczas dodawania studenta. Spróbuj ponownie później.', 'Błąd', 'OK', '', 1);
   			});
		}
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
			$route.reload();
		}, function() {	
		
		});
	};

}]);
