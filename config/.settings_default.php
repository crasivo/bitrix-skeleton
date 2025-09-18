<?php
if (!defined('B_PROLOG_INCLUDED') || B_PROLOG_INCLUDED !== true) die();

return [
    'cache' => [
        'value' => [
            'type' => 'files',
            'sid' => $_SERVER['DOCUMENT_ROOT'] . '#01',
        ],
        'readonly' => false,
    ],
    'composer' => [
        'value' => [
            'config_path' => dirname(__DIR__) . '/composer.json',
        ],
        'readonly' => false,
    ],
    'crypto' => [
        'value' => [
            'crypto_enabled' => false, // configuration is declared, but not enabled
            'crypto_key' => getenv('APP_CRYPTO_KEY'), // bin2hex(random_bytes(16))
        ],
        'readonly' => false,
    ],
    'default_language' => [
        'value' => 'ru',
        'readonly' => false,
    ],
    'exception_handling' => [
        'value' => [
            'debug' => true, // permanent (replace in extra)
            'handled_errors_types' => \E_ALL & ~\E_NOTICE & ~\E_STRICT & ~\E_USER_NOTICE,
            'exception_errors_types' => \E_ALL & ~\E_NOTICE & ~\E_WARNING & ~\E_STRICT & ~\E_USER_WARNING & ~\E_USER_NOTICE & ~\E_COMPILE_WARNING & ~\E_DEPRECATED,
            'ignore_silence' => false,
            'assertion_throws_exception' => true,
            'assertion_error_type' => \E_USER_ERROR,
            'log' => [
                'settings' => [
                    'file' => $_SERVER['DOCUMENT_ROOT'] . '/upload/logs/bx_exception.log',
                    'log_size' => 1000000,
                ],
            ],
        ],
        'readonly' => false,
    ],
    'routing' => [
        'value' => [
            'api.php',
            'web.php',
        ],
        'readonly' => false,
    ],
    'session' => [
        'value' => [
            'mode' => 'default',
            'handlers' => [
                'general' => [
                    'type' => 'file',
                ],
            ]
        ],
        'readonly' => false,
    ],
    'smtp' => [
        'value' => [
            'enabled' => false,
            'debug' => true,
            'log_file' => $_SERVER['DOCUMENT_ROOT'] . '/upload/logs/bx_mailer.log',
        ],
        'readonly' => false,
    ],
    'utf_mode' => [
        'value' => true, // permanent
        'readonly' => true,
    ],
];
