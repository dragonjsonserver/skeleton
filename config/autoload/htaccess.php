<?php
/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2014 DragonProjects (http://dragonprojects.de/)
 * @license http://license.dragonprojects.de/dragonjsonserver.txt New BSD License
 * @author Christoph Herrmann <developer@dragonprojects.de>
 * @package DragonJsonServerSkeleton
 */

/**
 * @example
    SetEnv ENVIRONMENT htaccess
    SetEnv DATABASE_HOST host
    SetEnv DATABASE_PORT port
    SetEnv DATABASE_USER user
    SetEnv DATABASE_PASSWORD password
    SetEnv DATABASE_DBNAME dbname
 * @return array
 */
return [
    'doctrine' => [
        'connection' => [
            'orm_default' => [
                'params' => [
                    'host'     => getenv('DATABASE_HOST'),
                    'port'     => getenv('DATABASE_PORT'),
                    'user'     => getenv('DATABASE_USER'),
                    'password' => getenv('DATABASE_PASSWORD'),
                    'dbname'   => getenv('DATABASE_DBNAME'),
                ],
            ],
        ],
    ],
];
