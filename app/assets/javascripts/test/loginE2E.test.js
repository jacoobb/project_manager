describe('login E2E', function() {
	var userName = element(by.model('userName'));
	var password = element(by.model('password'));
	var loginBtn = element(by.id('loginBtn'));

  	it('should get failed login', function() {
  		browser.get('http://localhost:3000/login');

  		userName.clear();
  		password.clear();

  		userName.sendKeys('88123');

    	password.sendKeys('Auto1234');

    	loginBtn.click();

    	var message = element(by.css('.text-danger'));

    	expect(message.getText()).toEqual('Nieprawidłowy numer albumu lub hasło');
  	});
  	
  	it('should get success login', function() {
  		userName.clear();
  		password.clear();

  		userName.sendKeys('88457');

    	password.sendKeys('12qwaszx');

    	loginBtn.click();

    	expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/');
  	});

  	it('should come back to login page', function() {
		var logout = $('a[href="/logout"]');

		logout.click();

  		expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/login');
  	});
});