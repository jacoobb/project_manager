'use strict';

angular.module('app.filters', [])

	.filter('interpolate', ['version', function (version) {
		return function (text) {
			return String(text).replace(/\%VERSION\%/mg, version);
		}
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
			if(!angular.isUndefined(projects) && !angular.isUndefined(categoryName)) {
				var temp = [];

				angular.forEach(projects, function(p) {
					if(p.categories.length != 0) {
						angular.forEach(p.categories, function (c) {
							if(c.name.indexOf(categoryName) != -1) {
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