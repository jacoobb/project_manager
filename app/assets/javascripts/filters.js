'use strict';

angular.module('app.filters', [])

	.filter('interpolate', ['version', function (version) {
		return function (text) {
			return String(text).replace(/\%VERSION\%/mg, version);
		}
	}])

	.filter('topicFilter', [function () {
		return function (projects, topic) {
			if(!angular.isUndefined(projects) && !angular.isUndefined(topic)) {
				var temp = [];

				angular.forEach(projects, function(p) {
					if(p.name.indexOf(topic) != -1) {
						temp.push(p);
					}	
				});

				return temp;
			} else {
				return projects;
			}
		};
	}])

	.filter('teacherFilter', [function () {
		return function (projects, name) {
			if(!angular.isUndefined(projects) && !angular.isUndefined(name)) {
				var temp = [];

				angular.forEach(projects, function(p) {
					if(p.teachers.length != 0) {
						angular.forEach(p.teachers, function (t) {
							if(t.first_name.indexOf(name) != -1) {
								temp.push(p);
							}
						});
					}
				});

				return temp;
			} else {
				return projects;
			}
		};
	}])

	.filter('categoryFilter', [function () {
		return function (projects, categoryName) {
			if(!angular.isUndefined(projects) && !angular.isUndefined(categoryName) && categoryName != 'Brak') {
				var temp = [];

				angular.forEach(projects, function(p) {
					if(p.categories.length != 0) {
						angular.forEach(p.categories, function (c) {
							if(c.name == categoryName) {
								temp.push(p);
							}
						});
					}
				});

				return temp;
			} else {
				return projects;
			}
		};
	}])

	.filter('technologyFilter', [function () {
		return function (projects, technologyName) {
			if(!angular.isUndefined(projects) && !angular.isUndefined(technologyName) && technologyName != 'Brak') {
				var temp = [];

				angular.forEach(projects, function(p) {
					if(p.technologies.length != 0) {
						angular.forEach(p.technologies, function (t) {
							if(t.name == technologyName) {
								temp.push(p);
							}
						});
					}
				});

				return temp;
			} else {
				return projects;
			}
		};
	}]);