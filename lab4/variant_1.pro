% Copyright

implement main
    open core

class facts
    arc : (string CityFrom, string CityTo, integer Length).

class predicates
    path : (string CityFrom, string CityTo, string* Path [out], integer Length [out]) nondeterm.
    member : (string Elem, string* List) nondeterm.
    equal : (string FirstItem, string SecondItem) determ.
    connected : (string CityFrom, string CityTo [out], integer Length [out]) nondeterm.
    connected : (string CityFrom, string CityTo, integer Length [out]) nondeterm.
    travel : (string CityFrom, string CityTo, string* Visited, string* Path [out], integer Length [out]) nondeterm.
    min : (string*** List) nondeterm.
    print_path : (string* List) nondeterm.

clauses
    arc("Киев", "Минск", 430).
    arc("Киев", "Санкт-Петербург", 1050).
    arc("Киев", "Москва", 750).
    arc("Киев", "Белгород", 435).
    arc("Киев", "Одесса", 435).
    arc("Киев", "Кишенев", 395).
    arc("Киев", "Харьков", 405).
    arc("Киев", "Днепр", 390).
    arc("Киев", "Запорожье", 440).
    arc("Киев", "Кривой_Рог", 350).
    arc("Москва", "Минск", 750).
    arc("Москва", "Санкт-Петербург", 696).
    arc("Москва", "Воронеж", 529).
    arc("Москва", "Харьков", 749).
    arc("Москва", "Ростов-на-Дону", 1092).
    arc("Воронеж", "Минск", 971).
    arc("Воронеж", "Санкт-Петербург", 1243).
    arc("Воронеж", "Белгород", 255).
    arc("Воронеж", "Львов", 1209).
    arc("Воронеж", "Одесса", 990).
    arc("Воронеж", "Харьков", 326).
    arc("Воронеж", "Луганск", 467).
    arc("Воронеж", "Ростов-на-Дону", 563).
    arc("Воронеж", "Львов", 1209).
    arc("Минск", "Санкт-Петербург", 790).
    arc("Белгород", "Одесса", 777).
    arc("Белгород", "Кишенев", 803).
    arc("Белгород", "Харьков", 76).
    arc("Белгород", "Луганск", 423).
    arc("Львов", "Люблин", 217).
    arc("Харьков", "Люблин", 1084).
    arc("Харьков", "Одесса", 717).
    arc("Харьков", "Кишенев", 712).
    arc("Харьков", "Днепр", 234).
    arc("Харьков", "Запорожье", 298).
    arc("Харьков", "Ялта", 741).
    arc("Харьков", "Луганск", 336).
    arc("Харьков", "Изюм", 124).
    arc("Харьков", "Донецк", 295).
    arc("Харьков", "Ростов-на-Дону", 457).
    arc("Днепр", "Запорожье", 104).
    arc("Днепр", "Луганск", 417).
    arc("Днепр", "Донецк", 258).
    arc("Днепр", "Кривой_Рог", 148).
    arc("Кривой_Рог", "Запорожье", 193).
    arc("Кривой_Рог", "Донецк", 406).
    arc("Донецк", "Ростов-на-Дону", 253).
    arc("Ростов-на-Дону", "Луганск", 202).
    arc("Киев", "Житомир", 131).

    print_path([Head]) :-
        console::write(Head, " ").
    print_path([Head | Tail]) :-
        print_path(Tail),
        console::write(Head, " ").

    min([[PathX, [LengthX]]]) :-
        print_path(PathX),
        console::write(" ", LengthX, "\n").
    min([[PathX, [LengthX]], [PathY, [LengthY]] | Tail]) :-
        if toTerm(LengthX) > toTerm(LengthY) then
            %console::write(PathY, LengthY, "\n"),
            min([[PathY, [LengthY]] | Tail])
        else
            min([[PathX, [LengthX]] | Tail])
        end if.

    connected(CityFrom, CityTo, Length) :-
        arc(CityFrom, CityTo, Length)
        or
        arc(CityTo, CityFrom, Length).

    member(Elem, [Elem | _Tail]).
    member(Elem, [_Head | Tail]) :-
        member(Elem, Tail).

    equal(FirstItem, FirstItem).

    path(CityFrom, CityTo, Path, Length) :-
        travel(CityFrom, CityTo, [CityFrom], Path, Length).

    travel(CityFrom, CityFrom, Visited, Path, Length) :-
        Path = [CityFrom],
        Length = 0,
        !.
    travel(CityFrom, CityTo, Visited, [CityTo | Visited], Length) :-
        connected(CityFrom, CityTo, Length).
    travel(CityFrom, CityTo, Visited, Path, Length) :-
        connected(CityFrom, TempCity, Length1),
        not(equal(TempCity, CityTo)),
        not(member(TempCity, Visited)),
        travel(TempCity, CityTo, [TempCity | Visited], Path, Length2),
        Length = Length1 + Length2.

    run() :-
        List = [ [Path, [toString(Length)]] || path("Санкт-Петербург", "Санкт-Петербург", Path, Length) ],
        min(List),
        _ = console::readLine(),
        fail()
        or
        _ = console::readLine().

end implement main

goal
    console::runUtf8(main::run).
