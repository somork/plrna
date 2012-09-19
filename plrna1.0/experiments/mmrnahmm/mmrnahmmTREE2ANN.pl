dataTREE2ANNOT('../../data/rfam95.90.30.canon.50.tab.part.not.3.dat', _).

modelTREE2ANNOT(G, H, A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=model(G),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(t(begin),I)),
        next_call_from_global_store(B, J),
        rTREE2ANNOT(I, [], G, H, J),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(end, _, [], [], _).

rTREE2ANNOT(unpaired(G), H, [I|J], [:|K], A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(unpaired(G),H,[I|J]),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(e(unpaired),I)),
        can_empty_stackTREE2ANNOT(H, J, _),
        next_call_from_global_store(C, msw(t(G,I),L)),
        next_call_from_global_store(B, M),
        rTREE2ANNOT(L, H, J, K, M),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(push, G, [H|I], [<|J], A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(push,G,[H|I]),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(e(push),(H,K))),
        can_empty_stackTREE2ANNOT([K|G], I, _),
        next_call_from_global_store(C, msw(t(push,(H,K)),L)),
        next_call_from_global_store(B, M),
        rTREE2ANNOT(L, [K|G], I, J, M),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(pull, [], G, H, A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(pull,[],G),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        next_call_from_global_store(C, msw(t(pullout),I)),
        next_call_from_global_store(B, J),
        rTREE2ANNOT(I, [], G, H, J),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

rTREE2ANNOT(pull, G, [H|I], [>|J], A) :-
        split_viterbit_tree_into_parts(A, D, E, F),
        D=r(pull,G,[H|I]),
        global_store_for_list_of_calls(B, E),
        global_store_for_list_of_calls(C, F),
        get_stackTREE2ANNOT(G, H, K, _),
        next_call_from_global_store(C, msw(t(pull,H),L)),
        next_call_from_global_store(B, M),
        rTREE2ANNOT(L, K, I, J, M),
        clean_global_store_for_list_of_calls(B),
        clean_global_store_for_list_of_calls(C).

get_stackTREE2ANNOT([A|B], A, B, _).

can_empty_stackTREE2ANNOT([], _, _).

can_empty_stackTREE2ANNOT([A|B], [A|C], _) :-
        can_empty_stackTREE2ANNOT(B, C, _).

can_empty_stackTREE2ANNOT([A|B], [C|D], _) :-
        A\=C,
        can_empty_stackTREE2ANNOT([A|B], D, _).


