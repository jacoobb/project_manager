describe('LoginCtrl test', function() {
	beforeEach(module("app"));

	var $scope, $rootScope, $httpBackend, $timeout, createController;

	beforeEach(inject(function($injector) {
		$timeout = $injector.get('$timeout');
		$httpBackend = $injector.get('$httpBackend');
		$rootScope = $injector.get('$rootScope');
		$scope = $rootScope.$new();

		var $controller = $injector.get('$controller');

		createController = function() {
			return $controller('LoginCtrl', {
				'$scope': $scope
			});
		};
	}));

	it('should have a method to set user type', function() {
		var loginCtrl = createController();

		$scope.setUserType('teacher');

		expect($scope.userType).toBe('teacher');
	});

	it('should get success login', function() {
		$httpBackend.expect('POST', )
	});
})