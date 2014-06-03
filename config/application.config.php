<?php
/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2014 DragonProjects (http://dragonprojects.de/)
 * @license http://license.dragonprojects.de/dragonjsonserver.txt New BSD License
 * @author Christoph Herrmann <developer@dragonprojects.de>
 * @package DragonJsonServerSkeleton
 */

/**
 * @return array
 */
return [
    'modules' => [   
        'DragonJsonServer',
        'DragonJsonServerAccount',
        'DragonJsonServerAccountloginban',
        'DragonJsonServerApiannotation',
        'DragonJsonServerApiclient',
        'DragonJsonServerDevice', 
    	'DoctrineModule',
        'DoctrineORMModule',
        'DragonJsonServerDoctrine',
        'DragonJsonServerEmailaddress',
        'DragonJsonServerI18n',
        'DragonJsonServerRequestlog',
        'DragonJsonServerSecuritytoken',
        'Test',
    ],
    'module_listener_options' => [
        'module_paths' => [
            './module',
            './vendor',
        ],
        'config_glob_paths' => [
            'config/autoload/{,*.}{global,' . (getenv('ENVIRONMENT') ? getenv('ENVIRONMENT') : 'local') . '}.php',
        ],
    ],
];
