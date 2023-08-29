/system script
add dont-require-permissions=yes name=SmsTelegram-3.0 owner=abbio90 policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="{\r\
    \n\r\
    \n\r\
    \n#----------------------------------------\r\
    \n\r\
    \n# SMS TO TELEGRAM BY foisfabio.it\r\
    \n\r\
    \n# \r\
    \n\r\
    \n# Script:  Sms to Telegram\r\
    \n\r\
    \n# Version: 3.0\r\
    \n\r\
    \n# RouterOS v.7.11\r\
    \n\r\
    \n# Created: 22/04/2023\r\
    \n\r\
    \n# Updated: 26/08/2023\r\
    \n\r\
    \n# Author: Fois Fabio\r\
    \n\r\
    \n# Editor: Fois Fabio\r\
    \n\r\
    \n# Website: https://foisfabio.it\r\
    \n\r\
    \n# Email: consulenza@foisfabio.it\r\
    \n\r\
    \n#\r\
    \n\r\
    \n#----------------------------------------\r\
    \n\r\
    \n#inserire qui il botID\r\
    \n\r\
    \n:local tgBot \"5278245041:AAE5KCZM1mVmCDNI5dB6TEirrsq3CwKyVlU\"\r\
    \n\r\
    \n#----------------------------------------\r\
    \n\r\
    \n#inserire qui il chatID1 (es: \"123456789\")\r\
    \n\r\
    \n:local tgChatID1 \"758066527\"\r\
    \n\r\
    \n#----------------------------------------\r\
    \n\r\
    \n#inserire nome azienda\r\
    \n\r\
    \n:local azienda \"Fabio Fois\"\r\
    \n\r\
    \n#----------------------------------------\r\
    \n\r\
    \n#inserire qui uno slogan pubblicitario\r\
    \n\r\
    \n:local slogan \"\\F0\\9F\\92\\BB Sistema di alert by foisfabio.it\"\r\
    \n\r\
    \n\r\
    \n#----------NO MODIFY THIS SECTION----------\r\
    \n\r\
    \n\r\
    \n\r\
    \n\r\
    \n#----------------------------------------\r\
    \n\r\
    \n\r\
    \n\r\
    \n:local scheduleName \"SmsTelegram-3.0\"\r\
    \n:local myRunTime 00:30:00\r\
    \n\r\
    \n:if ([:len [/system scheduler find name=\"\$scheduleName\"]] = 0) do={\r\
    \n\r\
    \n    /log error \"[SmsTelegram-3.0] Alert : lo Scheduler non esiste.\"\r\
    \n\r\
    \n\r\
    \n\r\
    \n    /system scheduler add name=\$scheduleName interval=\$myRunTime start-date=Jan/01/1970 start-time=startup on-event=\"syste\
    m script run SmsTelegram-3.0\"\r\
    \n\r\
    \n\r\
    \n\r\
    \n    /log warning \"[SmsTelegram-3.0] Alert : Scheduler creato .\"\r\
    \n\r\
    \n}\r\
    \n\r\
    \n\r\
    \n#--------------------------------\r\
    \n:local date ([system clock get date])\r\
    \n:local time ([/system clock get time])\r\
    \n:local tgPrefix \"Cliente: \$azienda \\r\\nDispositivo: MikroTik \$[/system resource get board-name]\\r\\nIdentita': \$[/syst\
    em identity get name]\\r\\n\$date \$time \\r\\n\"\r\
    \n:local smsPhone; \r\r\
    \n:local smsTimeStamp; \r\r\
    \n:local smsMessage; \r\r\
    \n:local smsContent;\r\
    \n:local i;\r\r\
    \n:log info \"SMS to Telegram script started\"; \r\r\
    \n/tool sms set receive-enabled=yes; delay 2\r\r\
    \n :foreach i in=[/tool sms inbox find] do={ \r\r\
    \n:set \$smsPhone [/tool sms inbox get \$i phone]; \r\r\
    \n:set \$smsTimeStamp [/tool sms inbox get \$i timestamp]; \r\r\
    \n:set \$smsMessage [/tool sms inbox get \$i message];\r\r\
    \n :set \$smsContent \"\$tgPrefix\\nMittente:\$smsPhone\\nData e Ora: \$smsTimeStamp\\nMessage: \$smsMessage \\r\\n \\r\\n\$slo\
    gan\"; \r\r\
    \n:log info \$smsContent;\r\
    \n:local date ([system clock get date])\r\
    \n:local time ([/system clock get time])\r\
    \n\r\
    \n\r\
    \n#---------------------------------\r\
    \n#INSERIRE QUI IL TESTO DELLA NOTIFICA\r\
    \n:local notify \"\$smsContent\"\r\
    \n#--------------------------------\r\
    \n\r\
    \n:local textMessage \"\$notify \"\r\
    \n\r\
    \n\r\
    \n\r\
    \n:local requestUrl \"https://api.telegram.org/bot\$tgBot/sendMessage\";\r\
    \n :local httpData \"{\\\"chat_id\\\": \\\"\$tgChatID1\\\", \\\"text\\\": \\\"\$textMessage\\\"}\";\r\
    \n  /tool fetch url=\$requestUrl http-data=\$httpData http-header-field=content-type:application/json http-method=post  keep-re\
    sult=no\r\
    \n\r\
    \n\r\
    \n\r\
    \n/tool sms inbox remove \$i; delay 10; } \r\r\
    \n/tool sms set receive-enabled=no; \r\r\
    \n:log info \"SMS to Telegram script complete\"; \r\
    \n\r\
    \n}\r\
    \n\r\
    \n\r\
    \n"
