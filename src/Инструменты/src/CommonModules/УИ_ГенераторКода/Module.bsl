
#Область ПрограммныйИнтерфейс


// Стандартный заголовок сгенерированного кода.
// 
// Параметры:
//  Инструмент- Строка- Инструмент
//  ИмяФайлаИнструмента - Строка -  Имя файла
//  ИмяГенерируемойЗаписи - Строка -Имя генерируемой записи
//  ДополнительныеДанные - Соответствие из КлючИЗначение:
//  	* Ключ - Строка - Имя 
//  	* Значение - Строка - 
// Возвращаемое значение:
//  Строка
Функция СтандартныйЗаголовокСгенерированногоКода(Инструмент, ИмяФайлаИнструмента = "", ИмяГенерируемойЗаписи = "",
	ДополнительныеДанные = Неопределено) Экспорт
	ТекстДополнительныхДанных ="";
	Если ДополнительныеДанные <> Неопределено Тогда
		СтрокиДляОбъединения = Новый Массив;
		Для Каждого КлючЗначение Из ДополнительныеДанные Цикл
			СтрокиДляОбъединения.Добавить(СтрШаблон("//%1 - %2", КлючЗначение.Ключ, КлючЗначение.Значение));
		КонецЦикла;

		ТекстДополнительныхДанных = СтрСоединить(СтрокиДляОбъединения, Символы.ПС);
	КонецЕсли;
	
	Возврат СтрШаблон("//Сгенерировано с помощью инструмента ""%4"" из набора ""Универсальные инструменты 1С""
					  |//https://github.com/cpr1c/tools_ui_1c
					  |//
					  |//Дата - %1
					  |//Имя файла инструмента - %2
					  |//Имя - %3
					  |//Пользователь - %5
					  |%6
					  |",
					  ТекущаяДатаСеанса(),
					  ИмяФайлаИнструмента,
					  ИмяГенерируемойЗаписи,
					  Инструмент,
					  ИмяПользователя(),
					  ТекстДополнительныхДанных);
КонецФункции

// Значение в строку кода.
// 
// Параметры:
//  Значение - Произвольный - Значение
//  ИмяЗаполняемойПеременной - Строка -  Имя переменной при необходиости. Используется только для сложных типов, 
//  	которые нужно заполнять с отдельным объявлением переменной
// 
// Возвращаемое значение:
//  Строка - Значение в строку кода
Функция ЗначениеВСтрокуКода(Значение, ИмяЗаполняемойПеременной = "") Экспорт
	ТипЗначения = ТипЗнч(Значение);
	
	Если ТипЗначения = Тип("Булево") Тогда
		Возврат БулевоВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Число") Тогда 
		Возврат ЧислоВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Строка") Тогда 
		Возврат СтрокаВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Дата") Тогда 
		Возврат ДатаВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Неопределено") Тогда 
		Возврат НеопределеноВСтрокуКода();
	ИначеЕсли ТипЗначения = Тип("Null") Тогда 
		Возврат NullВСтрокуКода();
	ИначеЕсли ТипЗначения = Тип("УникальныйИдентификатор") Тогда 
		Возврат УникальныйИдентификаторВСтрокуКода(Значение);
//	ИначеЕсли ТипЗначения = Тип("Тип") Тогда 
//		Возврат ТипВСтокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("МоментВремени") Тогда 
		Возврат МоментВремениВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Граница") Тогда
		Возврат ГраницаВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("ДвоичныеДанные") Тогда 
		Возврат ДвоичныеДанныеВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Картинка") Тогда 
		Возврат КартинкаВСтрокуКода(Значение);
	ИначеЕсли ТипЗначения = Тип("Массив") Тогда 
		Возврат МассивВСтрокуКода(Значение, ИмяЗаполняемойПеременной);
	ИначеЕсли ТипЗначения = Тип("СписокЗначений") Тогда 
		Возврат СписокЗначенийВСтрокуКода(Значение, ИмяЗаполняемойПеременной);
	ИначеЕсли УИ_ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда 
		Возврат СсылкаВСтрокуКода(Значение);
	Иначе
		Возврат "???//Тип "+ТипЗначения+" пока не поддерживается для генерации"
	КонецЕсли;
КонецФункции

#Область ПримитивныеТипы

// Булево в строку кода.
// 
// Параметры:
//  Значение -Булево- Значение
// 
// Возвращаемое значение:
//  Строка
Функция БулевоВСтрокуКода(Значение) Экспорт
	Возврат Формат(Значение, "БЛ=Ложь; БИ=Истина;");
КонецФункции

// Число в строку кода.
// 
// Параметры:
//  Значение - Число -Значение
// 
// Возвращаемое значение:
//  Строка -  Число в строку кода
Функция ЧислоВСтрокуКода(Значение) Экспорт
	Возврат ЧислоВСтрокуБезНеразрывныхПробелов(Значение);
КонецФункции

// Строка в строку кода.
// 
// Параметры:
//  Значение -Строка -Значение
// 
// Возвращаемое значение:
//  Строка
Функция СтрокаВСтрокуКода(Значение) Экспорт
	СтрокаДляКонфигуратора = СтрЗаменить(Значение, """", """""");
	СтрокаДляКонфигуратора = СтрЗаменить(СтрокаДляКонфигуратора, Символы.ПС, Символы.ПС+"|");
	Возврат """"+СтрокаДляКонфигуратора+"""";
КонецФункции

// Неопределено в строку кода.
// 
// Возвращаемое значение:
//  Строка -  Неопределено в строку кода
Функция НеопределеноВСтрокуКода() Экспорт
	Возврат "Неопределено";	
КонецФункции

// Null в строку кода.
// 
// Возвращаемое значение:
//  Строка -  Null в строку кода
Функция NullВСтрокуКода() Экспорт
	Возврат "Null";
КонецФункции

// Дата в строку кода.
// 
// Параметры:
//  Значение - Дата - 
// 
// Возвращаемое значение:
//  Строка - Дата в строку кода
Функция ДатаВСтрокуКода(Значение) Экспорт
	Если Значение = НачалоДня(Значение) Тогда
		ФорматнаяСтрока = "ДФ=ггггММдд;";
	Иначе
		ФорматнаяСтрока = "ДФ=ггггММддЧЧммсс;";
	КонецЕсли;
	Возврат "'" + Формат(Значение, ФорматнаяСтрока) + "'";
КонецФункции

#КонецОбласти

#Область ПростыеТипы

// Уникальный идентификатор в строку кода.
// 
// Параметры:
//  Значение - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  Строка -  Уникальный идентификатор в строку кода
Функция УникальныйИдентификаторВСтрокуКода(Значение) Экспорт
	Возврат СтрШаблон("Новый УникальныйИдентификатор(%1)", СтрокаВСтрокуКода(Строка(Значение)));
КонецФункции

// Тип в стоку кода.
// 
// Параметры:
//  Значение - Тип
// 
// Возвращаемое значение:
//  Строка
//Функция ТипВСтокуКода(Значение) Экспорт
//	//TODO AHTUNG Из общего модуля неправильный тип возвращается
//	ИмяТипа = УИ_ОбщегоНазначения.ИмяТипа(Значение);
//	Возврат СтрШаблон("Тип(%1)", СтрокаВСтрокуКода(ИмяТипа));
//КонецФункции

// Момент времени в строку кода.
// 
// Параметры:
//  Значение -МоментВремени - Значение
// 
// Возвращаемое значение:
//  Строка -  Момент времени в строку кода
Функция МоментВремениВСтрокуКода(Значение) Экспорт
	Возврат СтрШаблон("Новый МоментВремени(%1, %2)",
					  ДатаВСтрокуКода(Значение.Дата),
					  ЗначениеВСтрокуКода(Значение.Ссылка));

КонецФункции

// Граница в строку кода.
// 
// Параметры:
//  Значение - Граница
// 
// Возвращаемое значение:
//  Строка -  Граница в строку кода
Функция ГраницаВСтрокуКода(Значение) Экспорт
	ВидГраницыЗначенияСтрокой = "Включая";
	Если Значение.ВидГраницы = ВидГраницы.Исключая Тогда
		ВидГраницыЗначенияСтрокой = "Исключая";
	КонецЕсли;

	Возврат СтрШаблон("Новый Граница(%1, ВидГраницы.%2)", ДатаВСтрокуКода(Значение.Значение), ВидГраницыЗначенияСтрокой);
КонецФункции

// Двоичные данные в строку кода.
// 
// Параметры:
//  Значение - ДвоичныеДанные
// 
// Возвращаемое значение:
//  Строка
Функция ДвоичныеДанныеВСтрокуКода(Значение) Экспорт
	Возврат СтрШаблон("Base64Значение(%1)",СтрокаВСтрокуКода(Base64Строка(Значение)));
КонецФункции

// Картинка в строку кода.
// 
// Параметры:
//  Значение -Картинка - Значение
// 
// Возвращаемое значение:
//  Строка
Функция КартинкаВСтрокуКода(Значение) Экспорт
	Если Значение = Новый Картинка Тогда
		Возврат "Новый Картинка";
	Иначе
		Возврат СтрШаблон("Новый Картинка(%1)", ДвоичныеДанныеВСтрокуКода(Значение.ПолучитьДвоичныеДанные()));
	КонецЕсли;
КонецФункции

#КонецОбласти

#Область КоллекцииЗначений

// Массив в строку кода.
// 
// Параметры:
//  Значение - Массив из Произвольный
//  ИмяЗаполняемойПеременной - Строка
// 
// Возвращаемое значение:
//  Строка
Функция МассивВСтрокуКода(Значение, ИмяЗаполняемойПеременной) Экспорт
	ИмяПеременнойМассива = ИмяЗаполняемойПеременной;
	Если Не ЗначениеЗаполнено(ИмяПеременнойМассива) Тогда
		ИмяПеременнойМассива = СлучайноеИмяПеременной("Массив");
	КонецЕсли;
	МассивСтрок = Новый Массив;
	
	МассивСтрок.Добавить(СтрШаблон("%1 = Новый Массив;", ИмяПеременнойМассива));
	
	
	Для ИндексЭлементаЗначения = 0 По Значение.Количество() - 1 Цикл
		ТекЭлементЗначения = Значение[ИндексЭлементаЗначения];

		НужнаОтдельнаяПеременная = СгенерированныйКодПоТипуСодержитНесколькоСтрокКода(ТипЗнч(ТекЭлементЗначения));

		Если Не НужнаОтдельнаяПеременная Тогда
			МассивСтрок.Добавить(СтрШаблон("%1.Добавить(%2);",
										   ИмяПеременнойМассива,
										   ЗначениеВСтрокуКода(ТекЭлементЗначения)));
		Иначе
			ИмяПеременнойЭлементаЗначения = ИмяПеременнойМассива
											+ "_"
											+ ЧислоВСтрокуБезНеразрывныхПробелов(ИндексЭлементаЗначения);
			МассивСтрок.Добавить(СтрШаблон("
										   |%1
										   |%2.Добавить(%3);",
										   ЗначениеВСтрокуКода(ТекЭлементЗначения, ИмяПеременнойЭлементаЗначения),
										   ИмяПеременнойМассива,
										   ИмяПеременнойЭлементаЗначения));
		КонецЕсли;
	КонецЦикла;
	
	Возврат СтрСоединить(МассивСтрок, Символы.ПС);
КонецФункции

// Список значений в строку кода.
// 
// Параметры:
//  Значение - СписокЗначений из Произвольный
//  ИмяЗаполняемойПеременной - Строка
// 
// Возвращаемое значение:
//  Строка
Функция СписокЗначенийВСтрокуКода(Значение, ИмяЗаполняемойПеременной) Экспорт
	ИмяПеременной= ИмяЗаполняемойПеременной;
	Если Не ЗначениеЗаполнено(ИмяПеременной) Тогда
		ИмяПеременной= СлучайноеИмяПеременной("СписокЗначений");
	КонецЕсли;
	
	ПустаяКартинка = Новый Картинка;
	
	МассивСтрок = Новый Массив;

	МассивСтрок.Добавить(СтрШаблон("%1 = Новый СписокЗначений;", ИмяПеременной));
	
	Для ИндексЭлементаЗначения = 0 По Значение.Количество() - 1 Цикл
		ТекЭлементЗначения = Значение[ИндексЭлементаЗначения];

		КодПредставления = "";
		Если ЗначениеЗаполнено(ТекЭлементЗначения.Представление) Тогда
			КодПредставления = СтрокаВСтрокуКода(ТекЭлементЗначения.Представление);
		КонецЕсли;
		
		КодПометки = "";
		Если ТекЭлементЗначения.Пометка Тогда
			КодПометки = БулевоВСтрокуКода(ТекЭлементЗначения.Пометка);
		КонецЕсли;

		КодКартинки = "";
		Если ТекЭлементЗначения.Картинка <> ПустаяКартинка Тогда
			КодКартинки = КартинкаВСтрокуКода(ТекЭлементЗначения.Картинка);
		КонецЕсли;

		КодДопДанныхЭлемента = "";
		Если ЗначениеЗаполнено(КодКартинки) Тогда
			КодДопДанныхЭлемента = СтрШаблон(",%1,%2,%3", КодПредставления, КодПометки, КодКартинки);
		ИначеЕсли ЗначениеЗаполнено(КодПометки) Тогда
			КодДопДанныхЭлемента = СтрШаблон(",%1,%2", КодПредставления, КодПометки);
		ИначеЕсли ЗначениеЗаполнено(КодПредставления) Тогда 
			КодДопДанныхЭлемента = ","+КодПредставления;
		КонецЕсли;
		
		НужнаОтдельнаяПеременная = СгенерированныйКодПоТипуСодержитНесколькоСтрокКода(ТипЗнч(ТекЭлементЗначения.Значение));

		Если Не НужнаОтдельнаяПеременная Тогда
			МассивСтрок.Добавить(СтрШаблон("%1.Добавить(%2%3);",
										   ИмяПеременной,
										   ЗначениеВСтрокуКода(ТекЭлементЗначения.Значение),
										   КодДопДанныхЭлемента));
		Иначе
			ИмяПеременнойЭлементаЗначения = ИмяПеременной
											+ "_"
											+ ЧислоВСтрокуБезНеразрывныхПробелов(ИндексЭлементаЗначения);
			МассивСтрок.Добавить(СтрШаблон("
										   |%1
										   |%2.Добавить(%3%4);",
										   ЗначениеВСтрокуКода(ТекЭлементЗначения, ИмяПеременнойЭлементаЗначения),
										   ИмяПеременной,
										   ИмяПеременнойЭлементаЗначения,
										   КодДопДанныхЭлемента));
		КонецЕсли;
	КонецЦикла;
	
	Возврат СтрСоединить(МассивСтрок, Символы.ПС);	
КонецФункции

#КонецОбласти

#Область Ссылочные

// Ссылка в строку кода.
// 
// Параметры:
//  Значение - ЛюбаяСсылка
// 
// Возвращаемое значение:
//  Строка
Функция СсылкаВСтрокуКода(Значение) Экспорт
	МетаданныеСсылки = Значение.Метаданные();
	
	МогутБытьПредопределенные = Истина;
	Если Метаданные.Справочники.Содержит(МетаданныеСсылки) Тогда
		ИмяМенеджера = "Справочники";
	ИначеЕсли Метаданные.Документы.Содержит(МетаданныеСсылки) Тогда 
		МогутБытьПредопределенные = Ложь;
		ИмяМенеджера = "Документы";
	ИначеЕсли Метаданные.Перечисления.Содержит(МетаданныеСсылки) Тогда 
		Менеджер = Перечисления[МетаданныеСсылки.Имя];
		ИдентификаторПеречисления = МетаданныеСсылки.ЗначенияПеречисления.Получить(Менеджер.Индекс(Значение)).Имя;
		
		Возврат СтрШаблон("%1.%2.%3", "Перечисления", МетаданныеСсылки.Имя, ИдентификаторПеречисления);
	ИначеЕсли Метаданные.ПланыВидовХарактеристик.Содержит(МетаданныеСсылки) Тогда 
		ИмяМенеджера = "ПланыВидовХарактеристик";
	ИначеЕсли Метаданные.ПланыСчетов.Содержит(МетаданныеСсылки) Тогда 
		ИмяМенеджера = "ПланыСчетов";
	ИначеЕсли Метаданные.ПланыВидовРасчета.Содержит(МетаданныеСсылки) Тогда 
		ИмяМенеджера = "ПланыВидовРасчета";
	ИначеЕсли Метаданные.БизнесПроцессы.Содержит(МетаданныеСсылки) Тогда 
		ИмяМенеджера = "БизнесПроцессы";
		МогутБытьПредопределенные = Ложь;
	ИначеЕсли Метаданные.Задачи.Содержит(МетаданныеСсылки) Тогда 
		ИмяМенеджера = "Задачи";
		МогутБытьПредопределенные = Ложь;
	ИначеЕсли Метаданные.ПланыОбмена.Содержит(МетаданныеСсылки) Тогда 
		ИмяМенеджера = "ПланыОбмена";
		МогутБытьПредопределенные = Ложь;
	Иначе
		Возврат "???//Неизвестный тип ссылки"+УИ_ОбщегоНазначения.ИмяТипа(ТипЗнч(Значение));
	КонецЕсли;
	
	Если МогутБытьПредопределенные Тогда
		Если Значение.Предопределенный Тогда
			Возврат СтрШаблон("%1.%2.%3", ИмяМенеджера, МетаданныеСсылки.Имя, Значение.ИмяПредопределенныхДанных);
		КонецЕсли;
	КонецЕсли;

	Возврат СтрШаблон("%1.%2.ПолучитьСсылку(%3)",
					  ИмяМенеджера,
					  МетаданныеСсылки.Имя,
					  УникальныйИдентификаторВСтрокуКода(Значение.УникальныйИдентификатор()))
КонецФункции

#КонецОбласти

#Область СистемныеПеречисления

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СгенерированныйКодПоТипуСодержитНесколькоСтрокКода(Тип)
	Описание = ОписаниеТиповОпределяемыхНесколькимиСтрокамиКода();
	Возврат Описание.СодержитТип(Тип);
КонецФункции

// Типы определяемые несколькими строками кода.
// 
// Возвращаемое значение:
//  ОписаниеТипов
Функция ОписаниеТиповОпределяемыхНесколькимиСтрокамиКода()
	Возврат Новый ОписаниеТипов("Массив, СписокЗначений");
КонецФункции

// Случайное имя переменной.
// 
// Параметры:
//  Префикс - Строка
// 
// Возвращаемое значение:
//  Строка
Функция СлучайноеИмяПеременной(Префикс) 
	Возврат Префикс + СтрЗаменить(Новый УникальныйИдентификатор, "-", "_");
КонецФункции

// Число в строку без неразрывных пробелов.
// 
// Параметры:
//  Значение-Число - Значение
// 
// Возвращаемое значение:
//  Строка
Функция ЧислоВСтрокуБезНеразрывныхПробелов(Значение)
	Возврат XMLСтрока(Значение);
КонецФункции

#КонецОбласти
