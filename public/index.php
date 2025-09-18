<?php

// force redirect
foreach (['bitrixsetup.php', 'restore.php'] as $script) {
    if (file_exists(__DIR__ . '/' . $script)) {
        header('Location: /' . $script);
        die(0);
    }
}

echo phpinfo();
