Task scheduler (cron)
===

This directory contains instructions for running tasks through the [Cron](https://en.wikipedia.org/wiki/Cron) service.
For each environment:

- `development.txt` — Dev/Test/Local
- `production.txt` — Prod/Stage/QA

> [!NOTICE]
> These files are suitable for running tasks in the [BitrixVM](https://dev.1c-bitrix.ru/learning/course/?COURSE_ID=37&CHAPTER_ID=029228) environment.
> The base project directory is `/home/bitrix/www`.

List of tasks to be performed:

1. Every minute execution of [agents](https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=43&LESSON_ID=3436) and sending of mail
1. Daily backup via `make` commands
   - preliminary cleaning of old (7d) backups
   - creation of a DB dump (sql.gz)
   - creation of an archive (tar.gz) of the project's file structure

Example commands for registering tasks on the server (BitrixVM):

```shell
$ sudo cp -f /path/to/www/cron/development.txt /etc/cron.d/bx_cron
$ sudo systemctl restart cron.service
```
