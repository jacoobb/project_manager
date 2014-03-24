'use strict';

angular.module('app.services', [])

	.factory('SessionService', function() {
		var session = {
			isAuth: false,
			userName: '',
			userType: 'teacher'
		};

		return session;
	})

	.service('SubjectService', function() {
		this.getSubjectTypeText = function(type) {
			if(type == 'lab') {
				return 'laboratorium';
			} else if(type == 'lecture') {
				return 'wykład';
			} else if(type == 'project') {
				return 'projekt';
			}

			return 'ćwiczenia';
		};
	});