% author <Larissa Magalhães Pereira> <13747904>
:- consult('basedados.pl'). % carrega o arquivo com os dados

% oceano(X) X é um oceano
% pais(X) X é um país
% continente(X) X é um continente
% fronteira(X,Y) se X faz fronteira com Y, onde X são países ou oceanos e Y são países
% loc(X,Y) se X está localizado em Y, onde X é país e Y é continente

% Resoluções

% a) Quais são os países de um continente que fazem fronteira com oceanos?
escrever_resposta_a([]).
escrever_resposta_a([(Pais, Oceano)|Paises]):-
    loc(Pais, Continente),
    format('~w da ~w faz fronteira com o ~w', [Pais, Continente, Oceano]), nl,
    escrever_resposta_a(Paises).

alternativa_a(Paises):- % a incógnita Paises é uma lista de pares (Pais, Oceano)
    pais(Pais),
    oceano(Oceano),
    fronteira(Oceano, Pais), % analisa se o país faz fronteira com o oceano

    Paises = [(Pais, Oceano)|(_,_)], % adiciona na lista Paises pares (Pais, Oceano) com os países e oceanos que fazem fronteira entre si
    escrever_resposta_a(Paises).


% b) Quais os oceanos que fazem limite com algum país de um continente, mas não com países de outro continente?
escrever_resposta_b([]).
escrever_resposta_b([(Oceano, Continente)|Oceanos]):-
    format('~w faz limite com o continente ~w', [Oceano, Continente]), nl,
    escrever_resposta_b(Oceanos).

oceano_continente(Oceano, Continente):- % confere se determinado oceano faz fronteira com certo continente
    oceano(Oceano),
    continente(Continente),
    pais(Pais),
    loc(Pais, Continente),
    fronteira(Oceano, Pais).

duas_costas(Oceano):- % confere se determinado oceano faz fronteira com mais de um continente
    oceano(Oceano),
    continente(ContinenteA),
    continente(ContinenteB),
    ContinenteA \= ContinenteB,
    oceano_continente(Oceano, ContinenteA),
    oceano_continente(Oceano, ContinenteB).

alternativa_b(Oceanos):- % a incógnita Oceanos é uma lista de tuplas (Oceano, Continente)
    oceano(Oceano),
    \+ duas_costas(Oceano), % analisa se o oceano faz fronteira com mais de um continente, caso faça, pelo \+, retorna falso, ou seja, a condição estabelecida pelo enunciado (do oceano fazer fronteira com apenas um continente) não é seguida

    continente(Continente),
    oceano_continente(Oceano, Continente), % analisa se o oceano faz fronteira com o continente

    Oceanos = [(Oceano, Continente)|(_,_)], % adiciona na lista Oceanos tuplas (Oceano, Continente) com os oceanos e continentes que fazem fronteira entre si
    escrever_resposta_b(Oceanos).


% c) Encontre todos os pares de países localizados em diferentes continentes que fazem fronteira com um mesmo oceano.
escrever_resposta_c([]).
escrever_resposta_c([(Pais1, Pais2, Oceano)|Paises]):-
    loc(Pais1, Continente1), loc(Pais2, Continente2),
    format('~w da ~w e ~w da ~w fazem fronteira com o ~w', [Pais1, Continente1, Pais2, Continente2, Oceano]), nl,
    escrever_resposta_c(Paises).

alternativa_c(Paises):- % a incógnita Paises é uma lista de tuplas (Pais1, Pais2, Oceano)
    oceano(Oceano),
    pais(Pais1),
    pais(Pais2),
    Pais1 \= Pais2, % confere se os países (1 e 2) analisados são diferentes
    % confere se o oceano faz fronteira tanto com o país 1, quanto com o país 2
    fronteira(Oceano, Pais1),
    fronteira(Oceano, Pais2),

    %confere se os países (1 e 2) pertencem a continentes diferentes
    loc(Pais1, Continente1),
    loc(Pais2, Continente2),
    Continente1 \= Continente2,

    Paises = [(Pais1, Pais2, Oceano)|(_,_,_)], % adiciona na lista Paises tuplas (Pais1, Pais2, Oceano) com o oceano e os dois países que seguem a condição determinada, ou seja, pertencem a diferentes continentes e fazem fronteira com o esse mesmo oceano
    escrever_resposta_c(Paises).


% d) Encontre todos os pares de paises A e B, tais que:
%   i) A e B tem a mesma fronteira.
escrever_resposta_d_i([]).
escrever_resposta_d_i([(Pais1, Pais2, Pais3)|Paises]):-
    format('~w e ~w fazem fronteira com ~w', [Pais1, Pais2, Pais3]), nl,
    escrever_resposta_d_i(Paises).

alternativa_d_i(Paises):- % a incógnita Paises é uma lista de tuplas (Pais1, Pais2, Pais3)
    pais(Pais1),
    pais(Pais2),
    pais(Pais3),

    % confere se os países analisados são diferentes
    Pais1 \= Pais2,
    Pais1 \= Pais3,
    Pais2 \= Pais3,

    % confere se os dois países (A/1 e B/2) fazem fronteira com o mesmo país(3)
    fronteira(Pais1, Pais3),
    fronteira(Pais2, Pais3),

    Paises = [(Pais1, Pais2, Pais3)|(_,_,_)], % adiciona na lista Paises tuplas (Pais1, Pais2, Pais3) com os países(A/1 e B/2) e o país(3) fronteira em comum
    escrever_resposta_d_i(Paises).


%   ii) A e B são vizinhos, A faz fronteira com um oceano e B não faz fronteira com um oceano.
escrever_resposta_d_ii([]).
escrever_resposta_d_ii([(Pais1, Pais2, Oceano)|Paises]):-
    format('~w faz fronteira com o ~w e ~w não faz fronteira com nenhum oceano', [Pais1, Oceano, Pais2]), nl,
    escrever_resposta_d_ii(Paises).

pais_costeiro(Pais):- % confere se determinado país tem litoral, ou seja, faz fronteira com um oceano
    pais(Pais),
    oceano(Oceano),
    fronteira(Oceano, Pais).

alternativa_d_ii(Paises):- % a incógnita Paises é uma lista de tuplas (Pais1, Pais2, Oceano)
    oceano(Oceano),
    pais(Pais1),
    fronteira(Oceano, Pais1), % confere se o oceano faz fronteira com o país A/1

    pais(Pais2),
    Pais1 \= Pais2, % confere se os países são diferentes
    \+ pais_costeiro(Pais2), % analisa se o país B/2 faz fronteira com um oceano, caso faça, pelo \+, retorna falso, ou seja, a condição estabelecida pelo enunciado (do país B/2 não fazer fronteira com um oceano) não é seguida

    fronteira(Pais1, Pais2), % confere se os países são vizinhos

    Paises = [(Pais1, Pais2, Oceano)|(_,_,_)], % adiciona na lista Paises tuplas (Pais1, Pais2, Oceano) com o oceano e os dois países que seguem a condição determinada, ou seja, são vizinhos e o país A/1 faz fronteira com o oceano e o país B/2 não tem litoral
    escrever_resposta_d_ii(Paises).
