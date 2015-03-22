describe('login E2E', function() {
    var userName = element(by.model('userName'));
    var password = element(by.model('password'));
    var loginBtn = element(by.id('loginBtn'));

  	it('should get success login', function() {
      browser.get('http://localhost:3000/login');

  		userName.clear();
  		password.clear();

  		userName.sendKeys('88457');

    	password.sendKeys('12qwaszx');

    	loginBtn.click();

    	expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/');
  	});

  	it('should go to projects page', function() {
  		element(by.id('projects')).click();

  		var projects = $('.dropdown-menu a[href="/projects"]');

		  projects.click();

  		expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/projects');
  	});

  	it('should go to project negotiation page', function() {
  		var negotiation = $('.btn');

		  negotiation.click();

  		expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/projects/negotiation');
  	});

  	it('should start project negotiation', function() {
  		element(by.css('#teacher option[value="2"]')).click();

  		element(by.css('#subject option[value="3"]')).click();

  		element(by.model('topic')).sendKeys("Temat projektu");

  		element(by.model('description')).sendKeys("Opis projektu");

  		$('.btn').click();

  		$('.modal-footer button .btn-primary').click();

  		expect(browser.getCurrentUrl()).toEqual('http://localhost:3000/projects');
  	});
});