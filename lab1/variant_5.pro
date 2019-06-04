% Copyright

implement main
    open core

class facts
    arc : (string, string).

class predicates
    createList : (string*, string*, string* ListOut [out]) nondeterm.
    secondTask : (string*, integer, string* [out]) nondeterm.
    prolong : (string*, string* [out]) nondeterm.
    sprolong : (string*, string* [out]) nondeterm.
    write : (string**, string*, string* [out]) nondeterm.
    dpth : (string*, string, string* [out]) nondeterm.
    member : (string, string*) nondeterm.
    append : (string*, string*, string* [out]).
    search : (string*, string*, integer) nondeterm.
    lastTask : () nondeterm.

clauses
    arc("a", "b").
    arc("b", "f").
    arc("d", "e").
    arc("a", "f").
    arc("f", "e").
    arc("c", "d").
    arc("c", "f").

    append([], B, B).
    append([H | Tail], B, [H | NewTail]) :-
        append(Tail, B, NewTail).

    member(Elem, [Elem | _Tail]).
    member(Elem, [_Head | Tail]) :-
        member(Elem, Tail).

    write([], Temp, Temp).
    write([[Head | _] | Tail], Temp, Res) :-
        append(Temp, [Head], NewTemp),
        write(Tail, NewTemp, Res).

    %1
    createList([], Visited, Visited).
    createList([H | T], Visited, List) :-
        Acc =
            [ X ||
                arc(H, X),
                not(member(X, Visited)),
                not(member(X, T))
            ],
        append(Acc, T, NewAcc),
        append([H], Visited, NewVisited),
        createList(NewAcc, NewVisited, List).

    %2
    secondTask(ListIn, 0, ListIn).
    secondTask(ListIn, Length, ListOut) :-
        sprolong(ListIn, NewWay),
        NewLength = Length - 1,
        secondTask(NewWay, NewLength, ListOut).

    sprolong([Temp | Tail], [New, Temp | Tail]) :-
        arc(New, Temp),
        not(member(New, [Temp | Tail])).

    %3
    prolong([Temp | Tail], [New, Temp | Tail]) :-
        arc(Temp, New),
        not(member(New, [Temp | Tail])).

    dpth([Finish | Tail], Finish, [Finish | Tail]).
    dpth(TempWay, Finish, Way) :-
        prolong(TempWay, NewWay),
        dpth(NewWay, Finish, Way).

    %4
    search(_TempWay, _Visited, 1).
    search(TempWay, _Visited, Length) :-
        prolong(TempWay, NewAcc),
        NewLength = Length - 1,
        search(NewAcc, [], NewLength).

    %5
    lastTask() :-
        arc(_, X),
        not(arc(X, _)),
        console::write(X).

    %1
    run() :-
        console::init(),
        console::write("Enter node", '\n'),
        Node = console::readLine(),
        createList([Node], [], List),
        console::write(List, '\n'),
        fail()
        or
        console::write("Enter node", '\n'),
        Node = console::readLine(),
        console::write("Enter length", '\n'),
        Length = toTerm(console::readLine()),
        X = [ ListOut || secondTask([Node], Length, ListOut) ],
        write(X, [], Res),
        console::write(list::removeDuplicates(Res), '\n'),
        fail()
        or
        console::init(),
        console::write("Enter first node", '\n'),
        Start = console::readLine(),
        console::write("Enter second node", '\n'),
        Finish = console::readLine(),
        if dpth([Start], Finish, _Way) then
            console::write("Nodes are connected", '\n')
        else
            console::write("Nodes aren't connected", '\n')
        end if,
        fail()
        or
        console::write("Enter length", '\n'),
        Length = toTerm(console::readLine()),
        if search(["a"], [], Length) then
            console::write("Way with length ", Length, " exits", '\n')
        else
            console::write("Way with length ", Length, " doesn't exist", '\n')
        end if,
        fail()
        or
        if lastTask() then
            console::write(" is the node with no extended edges")
        else
            console::write("Node with no extended edges doesn't exist")
        end if,
        _ = console::readLine().

end implement main

goal
    console::runUtf8(main::run).
