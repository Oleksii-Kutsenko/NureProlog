implement main
    open core

class facts
    street_def : (string, string).

class predicates
    special : (string) nondeterm.
    two_street : (string, string) nondeterm.

clauses
    street_def("Moscowskiy", "Geroev Truda").
    street_def("Moscowskiy", "Ak. Pavlova").
    street_def("Industrialniy", "Gritsevtsa").
    street_def("Kievskiy", "Pushkinskaya").
    street_def("Kievskiy", "Bakulina").
    street_def("Kievskiy", "Pobedi").
    street_def("Shevchenkovskiy", "Geroev Truda").
    street_def("Shevchenkovskiy", "Nauki").
    street_def("Shevchenkovskiy", "Petrova").
    street_def("Shevchenkovskiy", "Vsevoloda").
    two_street(Street1, Street2) :-
        street_def(Dis, Street1),
        street_def(Dis, Street2).
    special(N) :-
        street_def(X, N),
        console::write(X, "\n").
    run() :-
        X = console::readLine(),
        special(X),
        fail()
        or
        Y = console::readLine(),
        console::write([ X || street_def(Y, X) ], "\n"),
        fail()
        or
        Street1 = console::readLine(),
        Street2 = console::readLine(),
        if two_street(Street1, Street2) then
            console::write("Yes", "\n")
        else
            console::write("No", "\n")
        end if,
        fail()
        or
        Street = console::readLine(),
        if street_def(_, Street) then
            console::write("Yes", "\n")
        else
            console::write("No", "\n")
        end if,
        fail()
        or
        _ = console::readLine().

end implement main

goal
    console::runUtf8(main::run).
