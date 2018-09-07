﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеКаталогСкриншотовЯУказываюПутьКОтносительномуКаталогу(Парам01)","ВПолеКаталогСкриншотовЯУказываюПутьКОтносительномуКаталогу","И     в поле каталог скриншотов я указываю путь к относительному каталогу ""tools\ScreenShots""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВКаталогеСкриншотовПоявилсяХотяБыОдинСкриншот()","ВКаталогеСкриншотовПоявилсяХотяБыОдинСкриншот","И в каталоге скриншотов появился хотя бы один скриншот");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И     в поле каталог скриншотов я указываю путь к относительному каталогу "tools\ScreenShots"
//@ВПолеКаталогСкриншотовЯУказываюПутьКОтносительномуКаталогу(Парам01)
Процедура ВПолеКаталогСкриншотовЯУказываюПутьКОтносительномуКаталогу(ЧастьПути) Экспорт
	Каталог = Ванесса.Объект.КаталогИнструментов + "\" + ЧастьПути;
	
	Если НЕ Ванесса.ФайлСуществуетКомандаСистемы(Каталог) Тогда
		Ванесса.СоздатьКаталогКомандаСистемы(Каталог);
	Иначе
		Ванесса.УдалитьКаталогКомандаСистемы(Каталог);
		Ванесса.СоздатьКаталогКомандаСистемы(Каталог);
	КонецЕсли;	 
	
	Контекст.Вставить("КаталогСкриншотов",Каталог);
	Ванесса.Шаг("И В открытой форме в поле с именем ""КаталогOutputСкриншоты"" я ввожу текст """ + Каталог + """");
КонецПроцедуры


&НаКлиенте
//И в каталоге скриншотов появился хотя бы один скриншот
//@ВКаталогеСкриншотовПоявилсяХотяБыОдинСкриншот()
Процедура ВКаталогеСкриншотовПоявилсяХотяБыОдинСкриншот() Экспорт
	//Ванесса.ЗапретитьВыполнениеШагов();
	ЛогФайл = ПолучитьИмяВременногоФайла("txt");
	Команда = "DIR " + Контекст.КаталогСкриншотов + " > """ + ЛогФайл + """";
	
	КомандаСистемы(Команда);
	
	Текст = Новый ЧтениеТекста;
	Текст.Открыть(ЛогФайл,"UTF-8");
	
	БылФайлСкриншота = Ложь;
	Пока Истина Цикл
		Стр = Текст.ПрочитатьСтроку();
		Если Стр = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Если Найти(Стр,"attachment") > 0 Тогда
			БылФайлСкриншота = Истина;
			Прервать;
		КонецЕсли;	 
	КонецЦикла;	
	
	Текст.Закрыть();
	
	Если Не БылФайлСкриншота Тогда
		ВызватьИсключение "В каталоге " + Контекст.КаталогСкриншотов + " не найдено ни одного файла скриншотов!";
	КонецЕсли;	 
	
КонецПроцедуры

//окончание текста модуля
