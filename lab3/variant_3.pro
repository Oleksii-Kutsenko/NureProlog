implement main
    open core

class facts
    prime : (integer Number).

class predicates
    init : ().
clauses
    init() :-
        assert(prime(2)),
        assert(prime(3)),
        assert(prime(5)),
        assert(prime(7)),
        assert(prime(11)).
    run() :-
        init(),
        stdio::write([ X || prime(X) ]),
        _ = stdio::readLine().

end implement main

goal
    console::runUtf8(main::run).
