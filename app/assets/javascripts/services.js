'use strict';

angular.module('app.services', [])

	.service('SessionService', function() {
		this.create = function(id, userType, userName) {
			this.id = id;
			this.userType = userType;
			this.userName = userName;
			this.isAuth = true;
		};
		this.clear = function() {
			this.id = null;
			this.userType = null;
			this.userName = null;
			this.isAuth = false;
		};

		return this;
	})

	.factory('AuthService', function($http, SessionService) {
		return {
			login: function (userName, password, userType) {
				if(userType == 'student') {
					return $http
					.post('/api/student/session', { student: { matricula_number: userName, password: password } })
					.then(function(result) {
						var user = result.data;

						SessionService.create(user.data.matricula_number, 'student', 'Maciej Ogrodniczak');
					});
				} else {
					return $http
					.post('/api/teacher/session', { teacher: { email: userName, password: password } })
					.then(function(result) {
						var user = result.data;

						SessionService.create(user.id, 'teacher', user.first_name + ' ' + user.last_name);
					});
				}
			},
			logout: function() {
				if(SessionService.userType == 'student') {
					return $http
					.delete('/api/student/session/:' + SessionService.id)
					.then(function(result) {
						SessionService.clear();
					});
				} else {
					return $http
					.delete('/api/teacher/session/:' + SessionService.id)
					.then(function(result) {
						SessionService.clear();
					});
				}
			}
		}
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
			} else if(type == 'add_student_to_team') {
				return 'Dodanie członka zespołu do projektu';
			} else if(type == 'create_project_proposal') {
				return 'Zgłoszenie propozycji tematu';
			}
		};
	});