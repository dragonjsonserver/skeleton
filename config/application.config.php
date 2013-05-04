<?php
/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2013 DragonProjects (http://dragonprojects.de/)
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
        'DragonJsonServerAlliance',
        'DragonJsonServerApiannotation',
        'DragonJsonServerAvatar',
        'DragonJsonServerAvatarmessage',
        'DragonJsonServerAvatarmuteban',
        'DragonJsonServerDevice', 
    	'DoctrineModule',
        'DoctrineORMModule',
        'DragonJsonServerDoctrine',
        'DragonJsonServerEmailaddress',
        'DragonJsonServerGameround',
        'DragonJsonServerGUI',
        'DragonJsonServerRequestlog',
        'DragonJsonServerSecuritytoken',
        'DragonJsonServerTickevent',
    ],
    'module_listener_options' => [
        'module_paths' => [
            './module',
            './vendor',
        ],
        'config_glob_paths' => [
            'config/autoload/{,*.}{global,local}.php',
        ],
    ],
];
