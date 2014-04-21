/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2014 DragonProjects (http://dragonprojects.de/)
 * @license http://license.dragonprojects.de/dragonjsonserver.txt New BSD License
 * @author Christoph Herrmann <developer@dragonprojects.de>
 * @package DragonJsonServerApiclient
 */

/**
 * AngularJS Modul für den Apiclient
 */
var dragonjsonserverapiclient = angular.module('dragonjsonserverapiclient', []);
dragonjsonserverapiclient.controller('ApiclientCtrl', ['$scope', function ($scope) {
    var query = new URI().query(true);
    $scope.server = query.server || config.server;
    var client;

    /**
     * Setzt die serverrelevanten Informationen zurück
     */
    $scope.disconnect = function () {
        $scope.connected = null;
        $scope.services = {};
        $scope.namespace = null;
        $scope.method = null;
        $scope.params = {};
    };

    /**
     * Verbindet zum JsonRPC Server und lädt die SMD
     */
    $scope.connect = function () {
        $scope.disconnect();
        client = new DragonJsonServer.Client($scope.server);
        client.smd({success : function (response) {
            $scope.connected = true;
            for (var servicename in response.services) {
                var service = response.services[servicename];
                var namespacename = servicename.substr(0, servicename.indexOf('.'));
                if (!$scope.services[namespacename]) {
                    $scope.services[namespacename] = {};
                }
                var methodname = servicename.substr(servicename.indexOf('.') + 1);
                $scope.services[namespacename][methodname] = service.parameters;
            }
            $scope.namespace = query.namespace || config.apiclient.namespace;
            $scope.method = query.method || config.apiclient.method;
            if (query.params) {
                $scope.params = JSON.parse(query.params);
            } else {
                $scope.params = {};
            }
            $scope.connectedserver = $scope.server;
            $scope.$apply();
        }});
    };

    /**
     * Sendet den ausgewählten Request zum JsonRPC Server
     */
    $scope.send = function () {
        var params = {};
        for (var key in $scope.services[$scope.namespace][$scope.method]) {
            var param = $scope.services[$scope.namespace][$scope.method][key];
            params[param.name] = $scope.params[param.name];
        }
        $scope.response = '';
        $scope.apiclienturl = new URI()
            .query({
                server : $scope.server,
                namespace : $scope.namespace,
                method : $scope.method,
                params : JSON.stringify(params)
            });
        var servicename = $scope.namespace + '.' + $scope.method;
        client.send(new DragonJsonServer.Request(servicename, params), {
            success : function (response) {
                if ('object' == typeof response.result) {
                    $.extend($scope.params, response.result);
                }
                $scope.response = JSON.stringify(response, null, 4);
                $scope.$apply();
            },
            error : function(jqXHR, textStatus, errorThrown) {
                $scope.response = errorThrown + ' ' + jqXHR.responseText + ' ' + textStatus;
                $scope.$apply();
            }
        });
    };

    /**
     * Fügt zum Array einen neuen Index hinzu
     * @param string paramname
     */
    $scope.addArray = function (paramname) {
        if ('object' != typeof $scope.params[paramname]) {
            $scope.params[paramname] = [];
        }
        $scope.params[paramname].push('');
    };

    /**
     * Entfernt einen Key vom Array
     * @param string paramname
     * @param string key
     */
    $scope.removeArray = function (paramname, key) {
        delete $scope.params[paramname][key];
    };

    $scope.connect();
}]);
