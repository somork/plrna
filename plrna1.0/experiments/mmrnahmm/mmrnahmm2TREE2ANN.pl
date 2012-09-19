dataTREE2ANNOT('../../data/rfam95.90.30.canon.50.tab.part.not.3.dat', _).

modelTREE2ANNOT(G, H, A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=model(G),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(t(begin),I)),
        next_call_from_global_store(B, J),
        rTREE2ANNOT(I, b, [], G, H, J),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(end, _, _, [], [], _).

rTREE2ANNOT(unpaired(G), H, I, [J|K], [:|L], A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(unpaired(G),H,I,[J|K]),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(e(unpaired,H),J)),
        can_empty_stackTREE2ANNOT(I, K, _),
        next_call_from_global_store(C, msw(t(G,(H,J)),M)),
        next_call_from_global_store(B, N),
        rTREE2ANNOT(M, J, I, K, L, N),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(push, G, H, [I|J], [<|K], A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(push,G,H,[I|J]),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(e(push,G),(I,L))),
        can_empty_stackTREE2ANNOT([L|H], J, _),
        next_call_from_global_store(C, msw(t(push,(G,I,L)),M)),
        next_call_from_global_store(B, N),
        rTREE2ANNOT(M, (I,L), [L|H], J, K, N),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(pull, G, [], H, I, A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(pull,G,[],H),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(t(pullout),J)),
        next_call_from_global_store(B, K),
        rTREE2ANNOT(J, G, [], H, I, K),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(pull, G, H, [I|J], [>|K], A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(pull,G,H,[I|J]),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        get_stackTREE2ANNOT(H, I, L, _),
        next_call_from_global_store(C, msw(t(pull,(G,I)),M)),
        next_call_from_global_store(B, N),
        rTREE2ANNOT(M, I, L, J, K, N),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

get_stackTREE2ANNOT([A|B], A, B, _).

can_empty_stackTREE2ANNOT([], _, _).

can_empty_stackTREE2ANNOT([A|B], [A|C], _) :-
        can_empty_stackTREE2ANNOT(B, C, _).

can_empty_stackTREE2ANNOT([A|B], [C|D], _) :-
        A\=C,
        can_empty_stackTREE2ANNOT([A|B], D, _).


