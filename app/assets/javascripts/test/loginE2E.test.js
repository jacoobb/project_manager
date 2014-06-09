describe('E2E: main page', function() {
	beforeEach(function() {
    	browser.get('http://localhost:3000/login');
  	});

  	it('should failed login', function() {
  		element(by.model('userName')).sendKeys('jan.kowalski@onet.pl');

    	element(by.model('password')).sendKeys('1234');

    	element(by.css('btn-primary')).click();

    	expect(element(by.model('message')).toEqual('Nieprawidłowy numer albumu lub hasło');
  	});

});