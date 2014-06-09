describe('LoginCtrl test', function() {
	beforeEach(module('app'));

	var scope;

	beforeEach(inject(function($rootScope, $controller) {
		scope = $rootScope.$new();

		$controller('LoginCtrl', { $scope: scope });
	}));

	it('should have a method to set user type', function() {
		scope.setUserType('teacher');

		expect(scope.userType).toBe('teacher');
	});

	it('should get failed login', inject(function(AuthService, SessionService, $httpBackend) {
		$httpBackend.expect('POST', '/api/teacher/session')
			.respond(401);

		AuthService.login('qwerty@wp.pl', '12345', 'teacher').then(function () {
			expect(SessionService.isAuth).toBeFalsy();
		});

		$httpBackend.flush();
	}));

	it('should get success login', inject(function(AuthService, SessionService, $httpBackend) {
		$httpBackend.expect('POST', '/api/student/session')
			.respond(201, '{"student_id":2,"first_name":"Jakub","last_name":"Mikrut"}');

		AuthService.login('88457', '12qwaszx', 'student').then(function () {
			expect(SessionService.isAuth).toBeTruthy();
		});

		$httpBackend.flush();
	}));
})