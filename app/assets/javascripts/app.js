'use strict';

/*
angular.module('app', ['ui.router', 'app.filters', 'app.services', 'app.directives', 'app.controllers'])

	.config(['$stateProvider', '$locationProvider', function ($stateProvider, $locationProvider) {
		$stateProvider
			.state('home', {
				url: '/',
				templateUrl: '../templates/home.html',
				controller: 'HomeCtrl'
			})
			.state('login', {
				url: '/login',
				templateUrl: '../templates/login.html',
				controller: 'LoginCtrl'
			});
			
		$locationProvider.html5Mode(true);
	}])
*/

angular.module('app', ['ngRoute', 'app.filters', 'app.services', 'app.directives', 'app.controllers', 'ui.bootstrap'])

	.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
		$locationProvider.html5Mode(true);

		$routeProvider
			.when('/', {
				templateUrl: '../templates/home.html',
				controller: 'HomeCtrl',
				authenticate: true
			})
			.when('/login', {
				templateUrl: '../templates/login.html',
				controller: "LoginCtrl",
				authenticate: false
			})
			.when('/projects', {
				templateUrl: '../templates/projects/projects.html',
				controller: "ProjectsCtrl",
				authenticate: true
			})
			.when('/projects/negotiation', {
				templateUrl: '../templates/projects/negotiation.html',
				controller: "ProjectNegotiationCtrl",
				authenticate: true
			})
			.when('/projects/my_projects', {
				templateUrl: '../templates/projects/my_projects.html',
				controller: "MyProjectsCtrl",
				authenticate: true
			})
			.when('/diploma_theses/negotiation', {
				templateUrl: '../templates/diploma_theses/negotiation.html',
				controller: "DiplomaThesesNegotiationCtrl",
				authenticate: true
			});
		
	}])

	.run(['$rootScope', '$location', 'SessionService', function ($rootScope, $location, SessionService) {
		$rootScope.$on("$routeChangeSuccess", function(scope, currentView, previousView) {
			
			//if(currentView.authenticate == true && SessionService.isAuth == false) {
			//	$location.path('/login');
			//}
		});

		$rootScope.location = $location;
	}]);