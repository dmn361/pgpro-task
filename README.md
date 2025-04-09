### Требования:

- Подложенные SSH-ключи пользователю root на двух серверах: Debian и AlmaLinux.
- У исполнителя есть закрытая часть ключа.
- Порядок ввода IP-адресов или имён серверов не важен, главное - без пробела после запятой
- На целевых системах не установлен PostgreSQL
- Установленные библиотеки python3 и python3-venv

### Использование:

```sh
git clone https://github.com/dmn361/pgpro-task.git
cd pgpro-task
./start.sh <ip1>,<ip2>
```

### Вопросы по ТЗ

Не указано, что считать под загруженостью системы, поэтому за основу был взят минутный **Load Average** (в случае одинаковых LA - ставит на Debian)

Конкретных версий дистрибутивов и PostgreSQL не указано, поэтому были выбраны:
- Debian 12.10 (Bookworm)
- AlmaLinux 9.5 (Teal Serval)
- PostgreSQL 15

### Дополнительно

Все пункты ТЗ учтены

Приложение выполняет проверку работы БД, выполняя SQL запрос `SELECT 1`
(Из пункта "Будет плюсом")

Задание было интересным, буду ждать обратной связи, спасибо!)
