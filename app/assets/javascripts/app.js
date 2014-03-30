'use strict';

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
			.when('/projects/add_project', {
				templateUrl: '../templates/projects/add_project.html',
				controller: "AddProjectCtrl",
				authenticate: true
			})
			.when('/diploma_thesis', {
				templateUrl: '../templates/diploma_thesis/diploma_thesis.html',
				controller: "DiplomaThesisCtrl",
				authenticate: true
			})
			.when('/diploma_thesis/my_thesis', {
				templateUrl: '../templates/diploma_thesis/my_thesis.html',
				controller: "MyThesisCtrl",
				authenticate: true
			})
			.when('/diploma_thesis/add_thesis', {
				templateUrl: '../templates/diploma_thesis/add_thesis.html',
				controller: "AddThesisCtrl",
				authenticate: true
			})
			.when('/diploma_thesis/negotiation', {
				templateUrl: '../templates/diploma_thesis/negotiation.html',
				controller: "DiplomaThesisNegotiationCtrl",
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