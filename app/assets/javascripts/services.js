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

	.service('TextService', function() {
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

		this.getProjectTypeText = function(type) {
			if(type == 'first_degree') {
				return 'Pierwszy stopień';
			} else if(type == 'second_degree') {
				return 'Drugi stopień';
			}

			return 'Projekt';
		};

		this.getActivityTypeText = function(type) {
			if(type == 'change_status') {
				return 'Zmiana statusu projektu';
			} else if(type == 'reserve_project') {
				return 'Rezerwacja projektu';
			}
		};
	});