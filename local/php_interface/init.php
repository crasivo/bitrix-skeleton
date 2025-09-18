<?php
if (!defined('B_PROLOG_INCLUDED') || B_PROLOG_INCLUDED !== true) die();

// Fix server variables for CLI
isset($_SERVER['APP_ROOT']) || ($_SERVER['APP_ROOT'] = dirname(__DIR__, 3));
isset($_SERVER['DOCUMENT_ROOT']) || ($_SERVER['DOCUMENT_ROOT'] = $_SERVER['APP_ROOT'] . DIRECTORY_SEPARATOR . 'public');

// Require composer autoload
if (!defined('COMPOSER_INCLUDED')) {
    require_once dirname(__DIR__, 2) . '/vendor/autoload.php';
    @define('COMPOSER_INCLUDED', true);
}

// Register Whoops (exception handler)
if (class_exists('\\Crasivo\\Bitrix\\Whoops\\ExceptionHandlerOutput')) {
    Crasivo\Bitrix\Whoops\ExceptionHandlerOutput::register();
}
