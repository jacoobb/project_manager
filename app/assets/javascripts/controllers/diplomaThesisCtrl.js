'use strict';

angular.module('app.controllers').controller('DiplomaThesisCtrl', ['$scope', '$location', '$http', '$modal', 'TextService', function ($scope, $location, $http, $modal, TextService) {
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

}]);