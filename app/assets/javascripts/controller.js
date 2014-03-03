var app = angular.module('myApp', []);

app.controller('MainCtrl', function($scope, $http) {

    $scope.get = function() {
        $http.post("/api/student/session", {"student":{"matricula_number":"88456", "password":"12qwaszx"}}).success(function(result) {
            console.log("Success", result);
            $scope.result = result;
        }).error(function() {
            console.log("error");
        });
    };

});