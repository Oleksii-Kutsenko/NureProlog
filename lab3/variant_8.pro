% Copyright

implement main
    open core

domains
    treetype =
        tree(integer Value, treetype Prev, treetype Next);
        null.

class predicates
    print_tree : (treetype, integer).
    print_spaces : (integer).

clauses
    print_tree(null, _Depth) :-
        !.
    print_tree(tree(TopValue, Left, Right), Depth) :-
        SubtreesDepth = Depth + 1,
        print_tree(Left, SubtreesDepth),
        print_spaces(Depth),
        console::write(TopValue),
        console::write("<\n"),
        print_tree(Right, SubtreesDepth).

    print_spaces(SpaceNumber) :-
        SpaceNumber <= 0,
        !
        or
        console::write("\t"),
        TailSpaceNumber = SpaceNumber - 1,
        print_spaces(TailSpaceNumber).
    run() :-
        X = tree(0, tree(1, tree(3, null, null), null), tree(2, null, null)),
        print_tree(X, 0),
        _ = console::readLine().

end implement main

goal
    console::runUtf8(main::run).
