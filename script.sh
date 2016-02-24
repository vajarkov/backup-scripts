#!/bin/bash
clear

#Функция выбора действия (главное меню)
function mainChange(){
	# Заголовок вывода
	PS3='Выберите действие: '
	# Массив для вывода меню
	operations=("Создать образ" "Восстановить образ" "Выход")
	# Выводим действия
	select operation in "${operations[@]}"	
	do
		# Действия при выборе 
		case $operation in
			"Создать образ") blockChange "create";; # Вызываем функцию для выбора блока с параметром для создания бэкапа
			"Восстановить образ") blockChange "restore";; # Вызываем функцию для выбора блока с параметром для восстановления из бэкапа
			"Выход") exit;; #Выход из программы
			*) echo "Неправильный ввод";; #Обработка неправильного ввода
		esac
	done
}

#Функция выбора станции
function dropChange(){
	# Проверяем, есть ли папка для блока, если нет - создаем ее
	if [ ! -d "$unit_path" ] ; then
		mkdir $unit_path
	fi
	# Заголовок вывода
	PS3='Выберите станцию: '
	case $1 in 
	# Станции блоков ПТК Ovation
		1 | 2 | 6) 
			drops=("DROP160" "DROP200" "DROP201" "DROP202" "DROP203" "DROP204" "DROP205" "DROP206" "DROP207" "DROP208" "DROP209" "DROP210" "Выход");;
	# Станции ПТК Teleperm
		3) drops=("a03spa" "a03spb" "a03p1a" "a03p1b" "a03ot1" "a03ot2" "a03ot3" "a03ot4" "a03ot5" "a03ot6" "a03ot7" "mxa03ot1" "mxa03ot2" "mxa03ot3" "mxa03ot4" "mxa03ot7" "Выход");;
	# Станции смешанных ПТК
		4) drops=("a03spa" "a04spb" "a04p1a" "a04p1b" "a04ot1" "a04ot2" "a04ot3" "a04ot4" "a04ot5" "mxa04ot1" "mxa04ot2" "mxa04ot3" "DROP200" "DROP201" "DROP210" "DROP211" "DROP160" "Выход");;
	# Станции, где нет ПТК
		*) echo "Нет станций на данном блоке"
			blockChange "create" # Возврат к выбору блоков 
			;;
	esac
	select drop in "${drops[@]}"
	do 
		case $drop in
			"Выход") blockChange "create";; # Возврат к выбору блоков
			*) driveChange "create";; # Выбор диска, для которого нужно делать резервную копию
		esac
	done
					
}

function blockChange(){
	# Устанавливаем начальный путь для диска резервных копий
	unit_path="/media/backup-user/7452565952562062/"
	# Заголовок вывода
	PS3='Выберите блок: '
	# Список блоков
	blocks=("Блок 1" "Блок 2" "Блок 3" "Блок 4" "Блок 5" "Блок 6" "Блок 7" "Блок 8" "Выход")
	select block in "${blocks[@]}"
	do 
		case $block in 
		"Блок 1")
			# Прописываем папку для бекапа
			unit_path+="unit1_backup/"
			case $1 in 
				"create") dropChange 1;; # Если создаем копию, то выбираем станцию
				"restore") 
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore";; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
		;;
					
		"Блок 2")
			# Прописываем папку для бекапа
			unit_path+="unit2_backup/"
			case $1 in 
				"create") dropChange 2;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Блок 3")
			# Прописываем папку для бекапа
			unit_path+="unit3_backup/"
			case $1 in 
				"create") dropChange 3;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Блок 4")
			# Прописываем папку для бекапа
			unit_path+="unit4_backup/"
			case $1 in 
				"create") dropChange 4;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Блок 5")
			# Прописываем папку для бекапа
			unit_path+="unit5_backup/"
			case $1 in 
				"create") dropChange 5;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Блок 6")
			# Прописываем папку для бекапа
			unit_path+="unit6_backup/"
			case $1 in 
				"create") dropChange 6;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Блок 7")
			# Прописываем папку для бекапа
			unit_path+="unit7_backup/"
			case $1 in 
				"create") dropChange 7;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Блок 8")
			# Прописываем папку для бекапа
			unit_path+="unit8_backup/"
			case $1 in 
				"create") dropChange 8;; # Если создаем копию, то выбираем станцию
				"restore")
					# Для восстановления выбираем файл образа из папки
					PS3='Выберите файл: ' 
					backupFiles=($(ls ${block}*.gz)) # Заполняем массив файлов в папке
					backupFiles+=("Выход")
					
					select backupFile in "${backupFiles[@]}"
					do
						case $backupFile in
							"Выход")
								# Если выбрали выход - возвращаемся к выбору блоков
								PS3='Выберите блок: ' 
								break
								;;
							*) driveChange "restore" ;; # Выбираем диск на который будем разворачивать образ
						esac
					done
				esac
			;;
		"Выход")
			# При выходе возвращаемся в меню выбора действия
			mainChange;;
		*) echo "Неправильный ввод";; # Обработка неправильного ввода
	esac
done
}

# Функция выбора диска
function driveChange() {
	# Заголовок выбора
	PS3='Выберите диск: '
	# Меняем разделитель строко в массиве
	IFS=$'\n'
	# Создаем массив для дисков
	drives=($(lsblk -Sno NAME,MODEL,VENDOR,SIZE,TYPE))
	
	# Делаем запрос дисков в системе
	#store=$(hal-find-by-capability --capability "storage")
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
	#	drives+=("${device} ${product} ${size} ${type} ${mountpoint[@]}")
	#done
	drives+=("Выход")
	IFS=$' '
	# Выводим список дисков
	select drive in "${drives[@]}"
	do
		case $drive in
			# При выходе 
			"Выход") case $1 in
							# Возвращаемся к выбору блоков с соответствующими параметрами
							"create") blockChange "create";; 
							"restore") blockChange "restore";;
						esac
						;;
			*) case $1 in
				# Если диск выбран
					"create")
							# Для создании копии
							echo "Введите пароль"
							# Вводим пароль
							read password 
							echo "Вы выбрали: $block, станцию $drop, диск $drive, пароль $password"
							YesNo=("Да" "Нет")
							PS3="Подтвердите выбор: "
							disk=(${drive[@]})
							# Подтверждаем выбор
							select yes in "${YesNo[@]}" 
							do
									case $yes in
										"Да") # Создаем образ
												dd if=/dev/${disk[0]} | pv | gzip -c > ${unit_path}${drop}_${date}:${password}.gz
												echo "Процесс завершен"
												mainChange # Возвращаемся в главное меню
												;;
										"Нет") mainChange;; # При отказе - возвращаемся в главное меню
										*) echo "Неправильный ввод";; # Обработка некорректного ввода
									esac
							done
							;;
					"restore")
							# Для восстановления образа
							echo "Вы выбрали: $block, файл $backupFile, диск $drive"
							YesNo=("Да" "Нет")
							PS3="Подтвердите выбор: "
							disk=(${drive[@]})
							# Подтверждаем выбор
							select yes in "${YesNo[@]}" 
							do
									case $yes in
										"Да") # Распаковываем образ на диск
												gunzip -c ${backupFile} | pv | dd of=${disk[0]}
												echo "Процесс завершен"
												mainChange # Возвращаемся в главное меню
												;;
										"Нет") mainChange;; # При отказе - возвращаемся в главное меню
										*) echo "Неправильный ввод";; # Обработка некорректного ввода
									esac
							done
							;;
					esac
		esac
	done
	
}


date=`date +%d.%m.%Y` # Обработка переменной для текущей даты
mainChange # Запуск главного меню
