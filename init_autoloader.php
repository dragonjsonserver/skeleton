<?php
/**
 * @link http://dragonjsonserver.de/
 * @copyright Copyright (c) 2012-2013 DragonProjects (http://dragonprojects.de/)
 * @license http://license.dragonprojects.de/dragonjsonserver.txt New BSD License
 * @author Christoph Herrmann <developer@dragonprojects.de>
 * @package DragonJsonServerSkeleton
 */

if (is_file('vendor/autoload.php')) {
    $loader = include 'vendor/autoload.php';
}
$zf2Path = null;
if (is_dir('vendor/ZF2/library')) {
    $zf2Path = 'vendor/ZF2/library';
} elseif (getenv('ZF2_PATH')) {
    $zf2Path = getenv('ZF2_PATH');
} elseif (get_cfg_var('zf2_path')) {
    $zf2Path = get_cfg_var('zf2_path');
}
if ($zf2Path) {
    if (isset($loader)) {
        $loader->add('Zend', $zf2Path);
    } else {
        require $zf2Path . '/Zend/Loader/AutoloaderFactory.php';
        Zend\Loader\AutoloaderFactory::factory(array(
            'Zend\Loader\StandardAutoloader' => array(
                'autoregister_zf' => true,
            ),
        ));
    }
}
if (!class_exists('Zend\Loader\AutoloaderFactory')) {
    throw new \RuntimeException('unable to load Zend Framework 2. Run "php composer.phar install" or define a ZF2_PATH environment variable');
}
