Composer packages
===

В данной директории хранятся приватные пакеты или готовые артефакты.

Пример настройки файла `composer.json` в корне проекта:

```json
{
  "repositories": [
    {
      "type": "artifact",
      "url": "composer/artifacts/"
    },
    {
      "type": "path",
      "url": "composer/packages/*"
    }
  ]
}
```
