'use strict';

angular.module('app.services', [])

	.factory('SessionService', function() {
		var session = {
			isAuth: false,
			userName: '',
			userType: 'teacher'
		};

		return session;
	})

	.service('SubjectService', function() {
		this.getSubjectTypeText = function(type) {
			if(type == 'lab') {
				return 'laboratorium';
			} else if(type == 'lecture') {
				return 'wykład';
			} else if(type == 'project') {
				return 'projekt';
			}

			return 'ćwiczenia';
		};
	})

	.service('TeacherService', function() {
		this.addDiplomaThesis = function(projectType, topic, description, categories, technologies) {
			$http.post('/api/teacher/projects', { project_proposal: { project: { name: topic, description: description, project_type: projectType }, teacher_id: teacherId, subject_id: subjectId }})
    			.success(function (data, status, headers, config) {
      				return true;
      			})
      			.error(function (data, status, headers, config) {
					return false;
      		});
		}
	});