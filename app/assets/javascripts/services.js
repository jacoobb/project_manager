'use strict';

angular.module('app.services', [])

	.factory('SessionService', function() {
		var session = {
			isAuth: false,
			userName: ''
		};

		return session;
	});