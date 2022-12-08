% author <Larissa Magalh�es Pereira> <13747904>
:- consult('basedados.pl'). % carrega o arquivo com os dados

% oceano(X) X � um oceano
% pais(X) X � um pa�s
% continente(X) X � um continente
% fronteira(X,Y) se X faz fronteira com Y, onde X s�o pa�ses ou oceanos e Y s�o pa�ses
% loc(X,Y) se X est� localizado em Y, onde X � pa�s e Y � continente

% Resolu��es

% a) Quais s�o os pa�ses de um continente que fazem fronteira com oceanos?
escrever_resposta_a([]).
escrever_resposta_a([(Pais, Oceano)|Paises]):-
    loc(Pais, Continente),
    format('~w da ~w faz fronteira com o ~w', [Pais, Continente, Oceano]), nl,
    escrever_resposta_a(Paises).

alternativa_a(Paises):- % a inc�gnita Paises � uma lista de pares (Pais, Oceano)
    pais(Pais),
    oceano(Oceano),
    fronteira(Oceano, Pais), % analisa se o pa�s faz fronteira com o oceano

    Paises = [(Pais, Oceano)|(_,_)], % adiciona na lista Paises pares (Pais, Oceano) com os pa�ses e oceanos que fazem fronteira entre si
    escrever_resposta_a(Paises).


% b) Quais os oceanos que fazem limite com algum pa�s de um continente, mas n�o com pa�ses de outro continente?
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

alternativa_b(Oceanos):- % a inc�gnita Oceanos � uma lista de tuplas (Oceano, Continente)
    oceano(Oceano),
    \+ duas_costas(Oceano), % analisa se o oceano faz fronteira com mais de um continente, caso fa�a, pelo \+, retorna falso, ou seja, a condi��o estabelecida pelo enunciado (do oceano fazer fronteira com apenas um continente) n�o � seguida

    continente(Continente),
    oceano_continente(Oceano, Continente), % analisa se o oceano faz fronteira com o continente

    Oceanos = [(Oceano, Continente)|(_,_)], % adiciona na lista Oceanos tuplas (Oceano, Continente) com os oceanos e continentes que fazem fronteira entre si
    escrever_resposta_b(Oceanos).


% c) Encontre todos os pares de pa�ses localizados em diferentes continentes que fazem fronteira com um mesmo oceano.
escrever_resposta_c([]).
escrever_resposta_c([(Pais1, Pais2, Oceano)|Paises]):-
    loc(Pais1, Continente1), loc(Pais2, Continente2),
    format('~w da ~w e ~w da ~w fazem fronteira com o ~w', [Pais1, Continente1, Pais2, Continente2, Oceano]), nl,
    escrever_resposta_c(Paises).

alternativa_c(Paises):- % a inc�gnita Paises � uma lista de tuplas (Pais1, Pais2, Oceano)
    oceano(Oceano),
    pais(Pais1),
    pais(Pais2),
    Pais1 \= Pais2, % confere se os pa�ses (1 e 2) analisados s�o diferentes
    % confere se o oceano faz fronteira tanto com o pa�s 1, quanto com o pa�s 2
    fronteira(Oceano, Pais1),
    fronteira(Oceano, Pais2),

    %confere se os pa�ses (1 e 2) pertencem a continentes diferentes
    loc(Pais1, Continente1),
    loc(Pais2, Continente2),
    Continente1 \= Continente2,

    Paises = [(Pais1, Pais2, Oceano)|(_,_,_)], % adiciona na lista Paises tuplas (Pais1, Pais2, Oceano) com o oceano e os dois pa�ses que seguem a condi��o determinada, ou seja, pertencem a diferentes continentes e fazem fronteira com o esse mesmo oceano
    escrever_resposta_c(Paises).


% d) Encontre todos os pares de paises A e B, tais que:
%   i) A e B tem a mesma fronteira.
escrever_resposta_d_i([]).
escrever_resposta_d_i([(Pais1, Pais2, Pais3)|Paises]):-
    format('~w e ~w fazem fronteira com ~w', [Pais1, Pais2, Pais3]), nl,
    escrever_resposta_d_i(Paises).

alternativa_d_i(Paises):- % a inc�gnita Paises � uma lista de tuplas (Pais1, Pais2, Pais3)
    pais(Pais1),
    pais(Pais2),
    pais(Pais3),

    % confere se os pa�ses analisados s�o diferentes
    Pais1 \= Pais2,
    Pais1 \= Pais3,
    Pais2 \= Pais3,

    % confere se os dois pa�ses (A/1 e B/2) fazem fronteira com o mesmo pa�s(3)
    fronteira(Pais1, Pais3),
    fronteira(Pais2, Pais3),

    Paises = [(Pais1, Pais2, Pais3)|(_,_,_)], % adiciona na lista Paises tuplas (Pais1, Pais2, Pais3) com os pa�ses(A/1 e B/2) e o pa�s(3) fronteira em comum
    escrever_resposta_d_i(Paises).


%   ii) A e B s�o vizinhos, A faz fronteira com um oceano e B n�o faz fronteira com um oceano.
escrever_resposta_d_ii([]).
escrever_resposta_d_ii([(Pais1, Pais2, Oceano)|Paises]):-
    format('~w faz fronteira com o ~w e ~w n�o faz fronteira com nenhum oceano', [Pais1, Oceano, Pais2]), nl,
    escrever_resposta_d_ii(Paises).

pais_costeiro(Pais):- % confere se determinado pa�s tem litoral, ou seja, faz fronteira com um oceano
    pais(Pais),
    oceano(Oceano),
    fronteira(Oceano, Pais).

alternativa_d_ii(Paises):- % a inc�gnita Paises � uma lista de tuplas (Pais1, Pais2, Oceano)
    oceano(Oceano),
    pais(Pais1),
    fronteira(Oceano, Pais1), % confere se o oceano faz fronteira com o pa�s A/1

    pais(Pais2),
    Pais1 \= Pais2, % confere se os pa�ses s�o diferentes
    \+ pais_costeiro(Pais2), % analisa se o pa�s B/2 faz fronteira com um oceano, caso fa�a, pelo \+, retorna falso, ou seja, a condi��o estabelecida pelo enunciado (do pa�s B/2 n�o fazer fronteira com um oceano) n�o � seguida

    fronteira(Pais1, Pais2), % confere se os pa�ses s�o vizinhos

    Paises = [(Pais1, Pais2, Oceano)|(_,_,_)], % adiciona na lista Paises tuplas (Pais1, Pais2, Oceano) com o oceano e os dois pa�ses que seguem a condi��o determinada, ou seja, s�o vizinhos e o pa�s A/1 faz fronteira com o oceano e o pa�s B/2 n�o tem litoral
    escrever_resposta_d_ii(Paises).
