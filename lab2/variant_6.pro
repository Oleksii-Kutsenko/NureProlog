% Copyright

implement main
    open core

class predicates
    member : (string, string*) nondeterm.
    last : (string, string*) nondeterm.
    first : (string, string*) nondeterm.

clauses
    member(Elem, [Elem | _Tail]).
    member(Elem, [_Head | Tail]) :-
        member(Elem, Tail).

    last(Elem, [Elem]).
    last(Elem, [_Head | Tail]) :-
        last(Elem, Tail).
    first(Elem, [Elem | Tail]).

    %1
    run() :-
        console::init(),
        console::write("Enter an element", '\n'),
        List = ["5", "6", "7"],
        console::write(List, "\n"),
        Elem = console::readLine(),
        if member(Elem, List) then
            console::write("Element is member of the list"),
            _ = console::readLine(),
            fail()
        else
            console::write("Elelment isn't member of the list"),
            _ = console::readLine(),
            fail()
        end if.

%2
    run() :-
        console::init(),
        console::write("Enter an element", '\n'),
        List = ["1", "2", "3"],
        console::write(List, "\n"),
        Elem = console::readLine(),
        if last(Elem, List) then
            console::write("Element is the last element of list", '\n'),
            _ = console::readLine(),
            fail()
        else
            console::write("Element isn't the last element of list", '\n'),
            _ = console::readLine(),
            fail()
        end if.

%3
    run() :-
        console::init(),
        console::write("Enter an element", '\n'),
        List = ["1", "2", "3"],
        console::write(List, "\n"),
        Elem = console::readLine(),
        if first(Elem, List) then
            console::write("Element is the first element of list", '\n'),
            _ = console::readLine()
        else
            console::write("Element isn't the first element of list", '\n'),
            _ = console::readLine()
        end if.

end implement main

goal
    console::runUtf8(main::run).
