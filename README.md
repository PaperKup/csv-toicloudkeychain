# csv-toicloudkeychain
AppleScript that will read a CSV file containing URL, username and password data and import this to iCloud KeyChain via Safari.


![alt tag](demo.gif)

## CSV Layout
Create a CSV without headers with data in the below order.
>url,username,password

For example, import an entry for the user doggo at woof.org.
>woof.org,doggo,secretbonepass

## Accessibility Permissions
Script editor must be given permission under System Preferences - Security & Privacy - Accessibility to run. Ensure you remove this after you have finished running the script.

![alt tag](scripteditor-permissions.png)

## Описание на Русском языке
Данный скрипт импортирует пароли из CSV файла в Safari и Связку ключей iCloud.

1. Для запуска сначала нужно зайти в Системные настройки - Защита и безопасность - Универсальный доступ. Снимаем защиту (замок в левом нижнем углу), жмем плюсик и находим в поиске "Редактор скриптов". Добавляем данную программу и ставим галочку.

2. Открываем Safari и сворачиваем его.

3. В скаченном архиве запускаем файл "csv-toicloudkeychain.applescript" - откроется редактор скрипта в котором нужно нажать кнопку Play вверху.

4. Вводим пароль, соглашаемся с вылезшим окошком и идем пить чай.
