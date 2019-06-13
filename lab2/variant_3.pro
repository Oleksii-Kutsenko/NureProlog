% Copyright

implement main
    open core

class facts
    has : (string Human, string Object).
    client : (string Human, string Org).

class predicates
    max : (integer, integer, integer [out]) nondeterm.
    isClientATT : (string [out]) nondeterm.

clauses
    has("Bill", "Computer").
    has("Jane", "Telephone").
    has("Jack", "Telephone").
    has("Dick", "Telephone").
    has("Dana", "Telephone").

    client("Bill", "Apple").
    client("Jane", "Spring").
    client("Jack", "AT&T").
    client("Dick", "AT&T").
    client("Dana", "MCI").

    isClientATT(Client) :-
        has(Client, "Telephone"),
        not(client(Client, "Spring")),
        not(client(Client, "MCI")).

    max(A, B, A) :-
        A > B.
    max(A, B, B) :-
        B > A.
    run() :-
        console::write("Enter first integer", '\n'),
        X = toTerm(console::readLine()),
        console::write("Enter second integer", '\n'),
        Y = toTerm(console::readLine()),
        max(X, Y, Z),
        console::write("Maximum is ", Z, '\n'),
        fail().

    run() :-
        isClientATT(X),
        console::write(X),
        _ = console::readLine(),
        fail()
        or
        console::write("Fail").

end implement main

goal
    console::runUtf8(main::run).
