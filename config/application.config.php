<?php
/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2013 DragonProjects (http://dragonprojects.de/)
 * @license http://license.dragonprojects.de/dragonjsonserver.txt New BSD License
 * @author Christoph Herrmann <developer@dragonprojects.de>
 * @package DragonJsonServerSkeleton
 */

$environment = getenv('ENVIRONMENT');
if (!$environment) {
	$environment = 'local';
}
/**
 * @return array
 */
return [
    'modules' => [   
        'DragonJsonServer',
        'DragonJsonServerAccount',
        'DragonJsonServerAccountachievement',
        'DragonJsonServerAccountloginban',
        'DragonJsonServerAchievement',
        'DragonJsonServerAlliance',
        'DragonJsonServerAllianceachievement',
        'DragonJsonServerApiannotation',
        'DragonJsonServerAvatar',
        'DragonJsonServerAvatarachievement',
        'DragonJsonServerAvatarloginban',
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
        'Test',
    ],
    'module_listener_options' => [
        'module_paths' => [
            './module',
            './vendor',
        ],
        'config_glob_paths' => [
            'config/autoload/{,*.}{global,' . $environment . '}.php',
        ],
    ],
];
