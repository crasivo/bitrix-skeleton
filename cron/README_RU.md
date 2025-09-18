Планировщик задач (cron)
===

В данной директории хранятся инструкции для запуска задач через службу [Cron](https://en.wikipedia.org/wiki/Cron).
Для каждого окружения

- `development.txt` — Dev/Test/Local
- `production.txt` — Prod/Stage/QA

> [!NOTICE]
> Указанные файлы подходят для запуска задач в окружении [BitrixVM](https://dev.1c-bitrix.ru/learning/course/?COURSE_ID=37&CHAPTER_ID=029228).
> Базовая директория проекта - `/home/bitrix/www`.

Список выполняемых задач:

1. Ежеминутное выполнение [агентов](https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=43&LESSON_ID=3436) и рассылка почты
1. Ежедневное резервное копирование через `make` команды
   - предварительная очистка старых (7d) резервных копий
   - создание дампа БД (sql.gz)
   - создание архива (tar.gz) файловой структуры проекта

Пример команд для регистрации задач на сервере (BitrixVM):

```shell
$ sudo cp -f /path/to/www/cron/development.txt /etc/cron.d/bx_cron
$ sudo systemctl restart cron.service
```
