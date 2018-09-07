﻿Перем Ванесса;

Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯСоздалFixtureСправочникаПоМакету(Парам01)","ЯСоздалFixtureСправочникаПоМакету","И я создал fixture справочника по макету ""Макет""");

	Возврат ВсеТесты;
КонецФункции

Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры


//я создал fixture по макету "Макет"
//@ЯСоздалFixtureПоМакету(Парам01Строка)
Процедура ЯСоздалFixtureСправочникаПоМакету(ИмяМакета) Экспорт
	Макет = ПолучитьМакет(ИмяМакета);
	Ванесса.СоздатьДанныеПоТабличномуДокументу(Макет);
КонецПроцедуры
