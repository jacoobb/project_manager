describe("filters.js test", function() {

	beforeEach(module("app"));

	describe('topicFilter test', function() {
		var projects = [
			{
				"id":1,
				"name":"Temat 1",
				"description":"Opis 1",
				"project_type":"second_degree",
				"approval_status":"approved",
				"reserved":false,
				"teachers":[{"id":1,"academic_title":"dr inż.","first_name":"Jan","last_name":"Kowalski"}],
				"members":[],
				"categories":[{"name":"Kategoria 1"}],
				"technologies":[{"name": "C"},{"name":"C++‎"}]
			},
			{
				"id":2,
				"name":"Temat 2",
				"description":"Opis 2",
				"project_type":"first_degree",
				"approval_status":"approved",
				"reserved":true,
				"teachers":[{"id":2,"academic_title":"dr","first_name":"Piotr","last_name":"Nowak"}],
				"members":[{"id":1,"first_name":"Maciej","last_name":"Ogrodniczak"}],
				"categories":[{"name":"Kategoria 2‎"}],
				"technologies":[{"name":"AngularJS"}]
			}
		];

		it('should be instantiable', inject(function ($filter) {
			var topicFilter = $filter('topicFilter');
			expect(topicFilter).toBeDefined();
		}));

		it('should return one item', inject(function ($filter) {
			var topicFilter = $filter('topicFilter');
			expect(topicFilter(projects, 'Temat 2').length).toBe(1);
		}));
	});
});