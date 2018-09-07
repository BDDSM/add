﻿//начало текста модуля
&НаКлиенте
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВыражениеВнутреннегоЯзыкаИстинно(Парам01)","ВыражениеВнутреннегоЯзыкаИстинно","И выражение внутреннего языка ""Контекст.КоличествоФинальное - Контекст.КоличествоНачальное = 1"" Истинно","Позволяет проверить произвольное выражение встроенного языка","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюЗначениеВыраженияВПеременную(Парам01,Парам02)","ЯЗапоминаюЗначениеВыраженияВПеременную","И Я запоминаю значение выражения ""Ванесса.ПолучитьМассивPIDОкон1С().Количество()"" в переменную ""КоличествоНачальное""","Позволяет сохранить в переменную Контекст произвольное выражение встроенного языка","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально(Парам01,Парам02)","ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально","И Я запоминаю значение выражения ""Ванесса.ПолучитьМассивPIDОкон1С().Количество()"" в переменную ""КоличествоНачальное"" глобально","Позволяет сохранить в переменную КонтекстСохраняемый произвольное выражение встроенного языка","Встроенный язык");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам)","ЗатемЯВыполняюКодВстроенногоЯзыка","И затем я выполняю код встроенного языка","Позволяет выполнить произвольный код на встроенном языке","Встроенный язык");

	Возврат ВсеТесты;
КонецФункции

&НаКлиенте
Процедура ПередНачаломСценария() Экспорт
КонецПроцедуры

&НаКлиенте
Процедура ПередОкончаниемСценария() Экспорт
КонецПроцедуры


&НаКлиенте
//И выражение внутреннего языка "Контекст.КоличествоНачальноеПлюсОдин - Контекст.КоличествоНачальное = 1" Истинно
//@ВыражениеВнутреннегоЯзыкаИстинно(Парам01)
Процедура ВыражениеВнутреннегоЯзыкаИстинно(Выражение) Экспорт
	ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(Выражение);
	Если ЗначениеВыражения <> Истина Тогда
		ВызватьИсключение "Выражение <" + Выражение + "> оказалось равно <" + ЗначениеВыражения + ">, а ожидали <" + Строка(Истина) + ">.";
	КонецЕсли;	 
КонецПроцедуры

&НаКлиенте
//И Я запоминаю выражение внутреннего языка "Ванесса.ПолучитьМассивPIDОкон1С().Количество()" в переменную "КоличествоНачальноеПлюсОдинВторойРаз"
//@ЯЗапоминаюЗначениеВыраженияВПеременную(Парам01,Парам02)
Процедура ЯЗапоминаюЗначениеВыраженияВПеременную(Знач Выражение,ИмяПеременной) Экспорт
	ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(Выражение);
	Контекст.Вставить(ИмяПеременной,ЗначениеВыражения);
КонецПроцедуры

&НаКлиенте
//И Я запоминаю выражение внутреннего языка "Ванесса.ПолучитьМассивPIDОкон1С().Количество()" в переменную "КоличествоНачальноеПлюсОдинВторойРаз" глобально
//@ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально(Парам01,Парам02)
Процедура ЯЗапоминаюЗначениеВыраженияВПеременнуюГлобально(Выражение,ИмяПеременной) Экспорт
	ЗначениеВыражения = Ванесса.ВычислитьВнутреннееВыражение(Выражение);
	Попытка
		КонтекстСохраняемый.Вставить(ИмяПеременной,ЗначениеВыражения);
	Исключение
		Ванесса.СохранитьЗначениеВКонтекстСохраняемый(ИмяПеременной,ЗначениеВыражения);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
//И затем я выполняю код встроенного языка
//@ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам)
Процедура ЗатемЯВыполняюКодВстроенногоЯзыка(ТабПарам) Экспорт
	Текст = "";
	Для Каждого СтрокаТабПарам Из ТабПарам Цикл
		Текст = Текст + СтрокаТабПарам.Кол1 + Символы.ПС;
	КонецЦикла;	
	
	Выполнить(Текст);
КонецПроцедуры


