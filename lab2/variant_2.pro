% Copyright

implement main
    open core

class facts
    arc : (string String, string String).

class predicates
    prolong : (string*, string* [out]) nondeterm.
    dpth : (string*, string, string* [out]) nondeterm.
    member : (string Elem, string* List) nondeterm.

clauses
    arc("a", "b").
    arc("a", "c").
    arc("b", "d").
    arc("c", "d").
    arc("f", "d").
    arc("d", "e").
    arc("e", "c").
    arc("f", "g").

    member(Elem, [Elem | _Tail]).
    member(Elem, [_Head | Tail]) :-
        member(Elem, Tail).

    prolong([Temp | Tail], [New, Temp | Tail]) :-
        arc(Temp, New),
        not(member(New, [Temp | Tail])).

    dpth([Finish | Tail], Finish, [Finish | Tail]).
    dpth(TempWay, Finish, Way) :-
        prolong(TempWay, NewWay),
        dpth(NewWay, Finish, Way).

    run() :-
        console::write("Введите первую вершину графа: "),
        B = console::readLine(),
        console::write("Введите вторую вершину графа: "),
        C = console::readLine(),
        dpth([B], C, _Way),
        console::write("Way exist "),
        _ = console::readLine(),
        !
        or
        console::write("Success"),
        _ = console::readLine(),
        succeed().

end implement main

goal
    console::runUtf8(main::run).
