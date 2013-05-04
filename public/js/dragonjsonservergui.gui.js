/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2013 DragonProjects (http://dragonprojects.de/)
 * @license http://license.dragonprojects.de/dragonjsonserver.txt New BSD License
 * @author Christoph Herrmann <developer@dragonprojects.de>
 * @package DragonJsonServerGUI
 */

if ('undefined' == typeof DragonJsonServerGUI) {
	DragonJsonServerGUI = {};
}

/**
 * Erstellt eine neue GUI Steuerung mit dem übergebenen Client
 * @param DragonJsonServer.Client client
 * @constructor
 */
DragonJsonServerGUI.GUI = function (client)
{
	var client = client;
    var namespaces = {};
    var defaultdata = {};

    /**
     * Gibt die eingegebenen Daten der Eingabefelder zurück
     * @return object
     */
    var getData = function ()
    {
        var data = {};
        $("#arguments input[type='text']").each(function (index, element) {
        	element = $(element);
        	var value = element.val();
            if ('' != value) {
            	var parametername = element.attr('data-parametername');
            	if (undefined != parametername) {
            		var keyname = element.attr('data-keyname');
            		if (undefined != keyname) {
                		if (undefined == data[parametername]) {
                			data[parametername] = {};
                		}
                		data[parametername][keyname] = value;
            		} else {
                		if (undefined == data[parametername]) {
                			data[parametername] = [];
                		}
                		data[parametername].push(value);
            		}
            	} else {
            		data[element.attr('name')] = value;
            	}
            }
        });
        $("#arguments input[type='checkbox']").each(function (index, element) {
			element = $(element);
        	data[element.attr('name')] = 'checked' == element.attr('checked');
        });
        return data;
    };
    
    /**
     * Aktualisiert die URI für den direkten Link auf die aktuelle Eingabe
     * @return GUI
     */
    var updateUri = function (namespace, method, data)
    {
    	if (!namespace) {
    		namespace = $('#namespace').val();
    	}
    	if (!method) {
    		method = $('#method').val();
    	}
    	if (!data) {
    		data = getData();
    	}
    	$('#uri').val(
    		new URI()
		    	.query({
		    		namespace : namespace,
		    		method : method,
		    		data : JSON.stringify(data),
		    	})
		    + ''
		);
    	return this;
    }

    /**
     * Selektiert einen anderen Namespace und baut die GUI entsprechend um
     * @param object query
     * @return GUI
     */
    this.selectNamespace = function (query)
    {
    	if (query && undefined != query.namespace) {
	        $('#namespace').val(query.namespace);
    	}
        var namespace = $('#namespace').val();
        var select = $('#method').html('');
        $.each(namespaces[namespace], function(method, parameters) {
            $('<option></option>')
                .html(method)
                .appendTo(select);
        });
        this.selectMethod(true, query);
        return this;
    };

    var self = this;
    /**
     * Selektiert eine andere Methode und baut die GUI entsprechend um
     * @param boolean clearresponse
     * @param object query
     * @return GUI
     */
    this.selectMethod = function (clearresponse, query)
    {
    	if (clearresponse) {
    		$('#response').html('<pre>Antwort</pre>');
    	}
    	if (query && undefined != query.method) {
	        $('#method').val(query.method);
    	}
        $.extend(defaultdata, getData());
        var namespace = $('#namespace').val();
        var method = $('#method').val();
        var div = $('#arguments');
        if (namespaces[namespace][method].length) {
        	div.html('');
            $.each(namespaces[namespace][method], function(index, parameter) {
                var controlgroup = 
                	$('<div class="control-group"></div>')
                    	.appendTo(div)
                    	.append($('<label class="control-label" for="' + parameter.name + '"></label>')
                            .html(parameter.name + ':'));
                var controls = $('<div class="controls"></div>')
                    .appendTo(controlgroup);
                
                var value = undefined;
                if (parameter.optional) {
                	value = parameter.default;
                }
                if (undefined != defaultdata[parameter.name]) {
                	value = defaultdata[parameter.name];
                }
                
                switch (parameter.type) {
	            	case 'array':
	                	if (undefined == value) {
	                		value = [''];
	                	}
                    	$.each(value, function(subindex, subvalue) {
                    		var subindex = controls.children().length;
                            controls
                            	.attr('id', 'controls_' + parameter.name)
                            	.append($('<input>')
					                .attr({'type' : 'text', 'data-parametername' : parameter.name})
					                .change(function() { updateUri(); })
					                .val(subvalue));
                    	});
                    	var a = $('<a class="btn"></a>');
                    	controls
                    		.append(a
	                    		.append($('<i class="icon-plus-sign"></i>'))
	                    		.click(function(element) {
	                    			var subindex = controls.children().length - 2;
	                    			a.before($('<input>')
						                .attr({'type' : 'text', 'data-parametername' : parameter.name})
						                .change(function() { updateUri(); }));
	                    		}))
	                    	.append($('<a class="btn"><i class="icon-refresh"></i></a>')
                    			.click(function(element) {
                    				self.selectMethod();
	                    		}));
                    	break;
	            	case 'boolean':
                    	if (undefined == value) {
                    		value = false;
                    	}
                    	controls
    	            		.append($('<input>')
    			                .attr({'type' : 'checkbox', 'id' : parameter.name, 'name' : parameter.name, 'checked' : value})
				                .change(function() { updateUri(); }));
                    	break;
                	case 'object':
                    	if (undefined == value) {
                    		value = {'':''};
                    	}
                    	$.each(value, function(subindex, subvalue) {
                            var subcontrolgroup = 
                            	$('<div class="control-group"></div>')
                                	.appendTo(controls)
                                	.append($('<label class="control-label" for="' + parameter.name + '_' + subindex + '"></label>')
                                        .html(subindex + ':'));
                            $('<div class="controls"></div>')
                            	.appendTo(subcontrolgroup)
    	                		.append($('<input>')
					                .attr({'type' : 'text', 'id' : parameter.name + '_' + subindex, 'name' : parameter.name + '_' + subindex, 'data-parametername' : parameter.name, 'data-keyname' : subindex})
					                .change(function() { updateUri(); })
					                .val(subvalue));
                    	});
                		break;
                	default:
                    	if (undefined == value) {
                    		value = '';
                    	}
                    	controls
    	            		.append($('<input>')
    			                .attr({'type' : 'text', 'id' : parameter.name, 'name' : parameter.name})
				                .change(function() { updateUri(); })
    			                .val(value));
                    	break;
                }
            });
        } else {
        	div.html('Keine Argumente benötigt');
        }
        updateUri(namespace, method, {});
        return this;
    };

    /**
     * Sendet und verarbeitet einen Json Request mit den eingegebenen Parametern
     * @return GUI
     */
    this.send = function ()
    {
    	var namespace = $('#namespace').val();
    	var method = $('#method').val();
    	var data = getData();
    	updateUri(namespace, method, data);
    	client.send(
            new DragonJsonServer.Request(
                namespace + '.' + method,
                data
            ),
            {
                async : false,
                success : function (json) {
	            	$('#response').html('<pre>' + $('<div/>').text(JSON.stringify(json, null, 4)).html() + '</pre>');
	                    if (undefined != json.result) {
	                    	defaultdata = $.extend(json.result, defaultdata);
	                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    $('#response').html('<pre>' + errorThrown + ' ' + jqXHR.responseText + ' ' + textStatus + '</pre>');
                },
            }
        );
        return this;
    };

    client.smd({
        async : false,
        success : function(json) {
        	namespaces = {};
            $.each(json.services, function(servicename, service) {
                var namespace = servicename.substr(0, servicename.lastIndexOf('.'));
                if ('undefined' == typeof(namespaces[namespace])) {
                	namespaces[namespace] = {};
                }
                var method = servicename.substr(servicename.lastIndexOf('.') + 1);
                namespaces[namespace][method] = service.parameters;
            });
        },
        error : function(jqXHR, textStatus, errorThrown) {
            $('#dragonjsonservergui').html('<p>Fehler beim Laden der SMD</p><br /><pre>' + errorThrown + ' ' + jqXHR.responseText + ' ' + textStatus + '</pre>');
        },
    });
    var select = $('#namespace');
    $.each(namespaces, function(namespace, methods) {
        $('<option></option>')
            .html(namespace)
            .appendTo(select);
    });
    var query = new URI().query(true);
    if (query.data) {
    	$.extend(defaultdata, $.parseJSON(query.data));
    }
    this.selectNamespace(query);
};
