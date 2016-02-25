#!/bin/bash

# Функция выбора действия (главное меню)
function mainChange(){
	# Создаем список для выбора действия и выводим его
	operation=$(zenity --list "Создать образ" "Восстановить образ" --column="" --title="Выберите действие" )
	# Если выбрали "Отмена" или закрыли окно - выходим из приложения
	if [ $? -eq 1 ] ; then 
		exit
	fi
	# Действия в соответсвии с выбором
	case $operation in
		"Создать образ") blockChange "create";; # Вызываем функцию для выбора блока с параметром для создания бэкапа
		"Восстановить образ") blockChange "restore";; # Вызываем функцию для выбора блока с параметром для восстановления из бэкапа
		*) zenity --info --text="Выберите действие" # Если ничего не выбрано - выводим окно
			mainChange # И возвращаемся в меню
			;;
	esac
}

# Функция выбора станции 
function dropChange(){
	# Проверяем, есть ли папка для блока, если нет - создаем ее
	if [ ! -d "$unit_path" ] ; then
		mkdir $unit_path
	fi
			
	case $1 in
		# Станции блоков ПТК Ovation
		1 | 2 | 6) 
			drop=$(zenity --list "DROP160" "DROP200" "DROP201" "DROP202" "DROP203" "DROP204" "DROP205" "DROP206" "DROP207" "DROP208" "DROP209" "DROP210" --column="Выберите рабочую станцию" --title="Резервная копия")
			# Если выбрали "Отмена" или закрыли окно - выходим из приложения
			if [ $? -eq 1 ] ; then 
 				exit
 			fi
			;;
		# Станции ПТК Teleperm
		3)	drop=$(zenity --list "a03spa" "a03spb" "a03p1a" "a03p1b" "a03ot1" "a03ot2" "a03ot3" "a03ot4" "a03ot5" "a03ot6" "a03ot7" "mxa03ot1" "mxa03ot2" "mxa03ot3" "mxa03ot4" "mxa03ot7" --column="Выберите рабочую станцию" --title="Резервная копия")
			# Если выбрали "Отмена" или закрыли окно - выходим из приложения
			if [ $? -eq 1 ] ; then 
 				exit
 			fi
			;;
		# Станции смешанных ПТК
		4)	drop=$(zenity --list "a04spa" "a04spb" "a04p1a" "a04p1b" "a04ot1" "a04ot2" "a04ot3" "a04ot4" "a04ot5" "mxa04ot1" "mxa04ot2" "mxa04ot3" "DROP200" "DROP201" "DROP210" "DROP211" "DROP160" --column="Выберите рабочую станцию" --title="Резервная копия")
			# Если выбрали "Отмена" или закрыли окно - выходим из приложения
			if [ $? -eq 1 ] ; then 
 				exit
 			fi
			;;
		# Станции, где нет ПТК
		*) zenity --info --text="Нет станций на этом блоке"
			blockChange "create";;	# Возврат к выбору блоков
	esac
	driveChange "create" # Выбор диска, для которого нужно делать резервную копию
}

# Функция выбора блока
function blockChange(){
	# Устанавливаем начальный путь для диска резервных копий
	unit_path="/media/backup-user/7452565952562062/"
	# Список блоков
	blocks=$(zenity --list "Блок 1" "Блок 2" "Блок 3" "Блок 4" "Блок 5" "Блок 6" "Блок 7" "Блок 8" --column="Выберите блок" --title="Резервная копия")
 	# Если выбрали "Отмена" или закрыли окно - выходим из приложения
 	if [ $? -eq 1 ] ; then 
 		exit
 	fi
	case "$blocks" in 
		"Блок 1")
			# Прописываем папку для бекапа
			unit_path+="unit1_backup/"
			case $1 in 
				"create")
					dropChange 1 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 2")
			# Прописываем папку для бекапа
			unit_path+="unit2_backup/"
			case $1 in 
				"create")
					dropChange 2 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 3")
			# Прописываем папку для бекапа
			unit_path+="unit3_backup/"
			case $1 in 
				"create")
					dropChange 3 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 4")
			# Прописываем папку для бекапа
			unit_path+="/unit4_backup/"
			case $1 in 
				"create")
					dropChange 4 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 5")
			# Прописываем папку для бекапа
			unit_path+="/unit5_backup/"
			case $1 in 
				"create")
					dropChange 5 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 6")	
			# Прописываем папку для бекапа
			unit_path+="/unit6_backup/"
			case $1 in 
				"create")
					dropChange 6 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 7")
			# Прописываем папку для бекапа
			unit_path+="/unit7_backup/"
			case $1 in 
				"create")
					dropChange 7 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		"Блок 8")
			# Прописываем папку для бекапа
			unit_path+="/unit8_backup/"
			case $1 in 
				"create")
					dropChange 8 # Если создаем копию, то выбираем станцию
					;;
				"restore")
					# Для восстановления выбираем файл образа из папки
					backupFile=$(zenity --file-selection --filename="$unit_path" --title="Выберите файл образа")
					# Если выбрали "Отмена" или закрыли окно - выходим из приложения
					if [ $? -eq 1 ] ; then 
 						exit
 					fi
 					echo $backupFile
 					# Выбираем диск на который будем разворачивать образ
					driveChange "restore" 
					;; 
			esac
		;;
		*) zenity --info --text="Выберите блок" # Если ничего не выбрано - выводим сообщение
			blockChange # Возвращаемся к выбору блоков
		;;
	esac
}

# Функция выбора диска
function driveChange(){
	# Меняем разделитель строко в массиве
	#IFS=$'\n'
	# Создаем массив для дисков
	# drives=($(lsblk -Sno NAME,SIZE,VENDOR,TYPE,MODEL))
	# zenity --info --text=$drives
	# Делаем запрос дисков в системе
	# store=$(hal-find-by-capability --capability "storage")
	#for s in $store 
	#do
		# Название диска 
	#	product=$(hal-get-property --udi ${s} --key info.product)
		# Размер диска
	#	size=$(hal-get-property --udi ${s} --key storage.size)
		# Тип диска
	#	type=$(hal-get-property --udi ${s} --key storage.drive_type)
		# Где расположен в системе
	#	device=$(hal-get-property --udi ${s} --key block.device)
		# Точка монтрования диска
	#	mountpoint=$(awk -vdev="$device" '$0~dev{print $2}' /etc/mtab)
		# Заносим все данные в массив
	#	drives+=("${device}" "${product}" "${size}" "${type}" "${mountpoint}")
	#done
	# Выводим список дисков
	drive=$(zenity --list --radiolist --text="Доступные диски" $(lsblk -Sno NAME,SIZE,VENDOR,TYPE,MODEL | awk '{print "FALSE /dev/"$1,$2,$3,$4,$5}') --column=" " --column="Расположение" --column="Размер" --column="Интерфейс" --column="Тип" --column="Модель" --title="Выберите диск" --width 520 --height 380)
	
	# Если выбрали "Отмена" или закрыли окно - выходим из приложения
	if [ $? -eq 1 ] ; then 
 		exit
 	fi
	case $1 in
		"create") # Для создании копии
			# Вводим пароль
			password=$(zenity --entry --text="Введите пароль:" --title="Пароль")
			# Подтверждаем выбор
			zenity --question --title="Подтвердите выбор" --text="Вы выбрали: $blocks, станцию $drop, диск $drive, пароль $password"
			if [ $? -eq 0 ] ; then
				# Создаем образ
				(pv -n ${drive} | gzip -c > ${unit_path}${drop}_${date}:${password}.gz) 2>&1 | zenity --title 'Идет резервное копирование диска' --text="Прогресс" --progress --width 380 --height 120 --auto-close --auto-kill 
				(( $? != 0 )) && zenity --error --text="Ошибка копирования"
				zenity --info --title="Прогресс" --text="Процесс завершен"
				mainChange
			else 
				# Возвращаемся в главное меню
				mainChange
			fi
		;;
		"restore") # Для восстановления образа
			# Подтверждаем выбор
			zenity --question --title="Подтвердите выбор" --text="Вы выбрали: $blocks, файл $backupFile, диск $drive"
			if [ $? -eq 0 ] ; then
				# Распаковываем образ на диск
				(pv ${backupFile} | gunzip > ${drive}) 2>&1 | zenity --title 'Идет восстановление диска' --text="Прогресс" --progress --width 380 --height 120 --auto-close --auto-kill 
				(( $? != 0 )) && zenity --error --text="Ошибка восстановления"
				zenity --info --title="Прогресс" --text="Процесс завершен"
				mainChange
			else 
				# Возвращаемся в главное меню
				mainChange
			fi
		;;
	esac
}

date=`date +%d.%m.%Y` # Обработка переменной для текущей даты
mainChange # Запуск главного меню
