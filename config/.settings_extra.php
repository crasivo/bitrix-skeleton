<?php
if (!defined('B_PROLOG_INCLUDED') || B_PROLOG_INCLUDED !== true) die();

// Fix directories
$_SERVER['APP_ROOT'] = $_SERVER['PROJECT_ROOT'] = dirname(__DIR__);
$_SERVER['DOCUMENT_ROOT'] = $_SERVER['APP_ROOT'] . '/public';

// Include composer autoloader
if (file_exists($_SERVER['APP_ROOT'] . '/vendor/autoload.php')) {
    require_once $_SERVER['APP_ROOT'] . '/vendor/autoload.php';
    @define('COMPOSER_INCLUDED', true);
} else {
    throw new \RuntimeException('Unable to include Composer autoloader.');
}

// Load environments from `.env`
Crasivo\Bitrix\Dotenv\EnvLocator::getInstance()->load($_SERVER['APP_ROOT']);

return [
    'cache' => [
        'value' => [
            'type' => env('CACHE_TYPE', 'files'),
            'memcache' => [
                'host' => env('MEMCACHED_HOST', '127.0.0.1'),
                'port' => env('MEMCACHED_PORT', 11211),
            ],
            'redis' => [
                'host' => env('REDIS_HOST', '127.0.0.1'),
                'port' => env('REDIS_PORT', 6379),
            ],
            'sid' => env('CACHE_SID', $_SERVER['DOCUMENT_ROOT'] . '#1'),
        ],
        'readonly' => true,
    ],
    'composer' => [
        'value' => [
            'config_path' => $_SERVER['APP_ROOT'] . '/composer.json',
        ],
        'readonly' => true,
    ],
    'connections' => [
        'value' => [
            'default' => [
                'className' => env('DB_CONNECTION_CLASS', '\\Bitrix\\Main\\DB\\MysqliConnection'),
                'host' => env('DB_HOST', 'localhost'),
                'port' => env('DB_PORT', 3306),
                'database' => env('DB_DATABASE', 'sitemanager'),
                'login' => env('DB_USERNAME', 'bitrix'),
                'password' => env('DB_PASSWORD', ''),
                'options' => 2,
            ],
        ],
        'readonly' => true,
    ],
    'console' => [
        'value' => [
            'commands' => [
                // dynamic loader (like ddd)
                ...array_map(function (string $filepath) {
                    try {
                        $list = include $filepath;
                        return is_array($list) ? $list : [];
                    } catch (Throwable $e) {
                        @trigger_error('Failed load console commands from ' . $filepath, \E_USER_NOTICE);
                        return [];
                    }
                }, glob($_SERVER['APP_ROOT'] . '/src/*/Resource/config/commands.php')),
            ],
        ],
        'readonly' => true,
    ],
    'crypto' => [
        'value' => [
            'crypto_enabled' => env('CRYPTO_ENABLED', false),
            'crypto_key' => env('CRYPTO_ENABLED'),
        ],
        'readonly' => true,
    ],
    'default_language' => [
        'value' => env('APP_DEFAULT_LANGUAGE', 'ru'),
        'readonly' => false,
    ],
    'exception_handling' => [
        'value' => [
            'debug' => env('APP_DEBUG', false),
            'handled_errors_types' => \E_ALL & ~\E_NOTICE & ~\E_WARNING & ~\E_STRICT & ~\E_USER_WARNING & ~\E_USER_NOTICE & ~\E_COMPILE_WARNING & ~\E_DEPRECATED,
            'exception_errors_types' => \E_ALL & ~\E_NOTICE & ~\E_WARNING & ~\E_STRICT & ~\E_USER_WARNING & ~\E_USER_NOTICE & ~\E_COMPILE_WARNING & ~\E_DEPRECATED,
            'ignore_silence' => false,
            'assertion_throws_exception' => true,
            'assertion_error_type' => \E_USER_ERROR,
            'log' => [
                'class_name' => Crasivo\Bitrix\Monolog\ExceptionHandlerLog::class,
            ],
        ],
        'readonly' => true,
    ],
    'routing' => [
        'value' => [
            'api.php',
            'web.php',
        ],
        'readonly' => true,
    ],
    'services' => [
        'value' => [
            // dynamic loader (like ddd)
            ...array_map(function (string $filepath) {
                try {
                    $list = include $filepath;
                    return is_array($list) ? $list : [];
                } catch (Throwable $e) {
                    @trigger_error('Failed load services from ' . $filepath, \E_USER_WARNING);
                    return [];
                }
            }, glob($_SERVER['APP_ROOT'] . '/src/*/Resource/config/services.php')),
        ],
        'readonly' => true,
    ],
    'session' => [
        'value' => [
            'mode' => env('SESSION_MODE', 'default'),
            'handlers' => [
                'general' => [
                    'type' => env('SESSION_STORAGE_TYPE', 'file'),
                    'host' => env('SESSION_STORAGE_HOST'),
                    'port' => env('SESSION_STORAGE_PORT'),
                ],
            ],
        ],
        'readonly' => true,
    ],
    'smtp' => [
        'value' => [
            'enabled' => env('APP_SMTP_ENABLED', false),
            'debug' => env('APP_SMTP_DEBUG', false),
            'log_file' => $_SERVER['DOCUMENT_ROOT'] . '/upload/logs/bx_mailer.log',
        ],
        'readonly' => true,
    ],
    'utf_mode' => [
        'value' => true,
        'readonly' => true,
    ],
];
