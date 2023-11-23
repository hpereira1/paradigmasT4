%resulucao desse problema https://rachacuca.com.br/logica/problemas/caminhoes-no-porto/

%para rodar o programa, "swipl -o caminhoes caminhoes.pl" -> "solucao(ListaSolucao)."

cor(amarelo).
cor(azul).
cor(branco).
cor(verde).
cor(vermelho).

km(50).
km(100).
km(150).
km(200).
km(250).

motorista(antônio).
motorista(bino).
motorista(jorge).
motorista(pedro).
motorista(stênio).

carga(adubo).
carga(carvao).
carga(enxofre).
carga(soda_caustica).
carga(trigo).

destino(amazonas).
destino(bahia).
destino(mato_grosso).
destino(minas_gerais).
destino(parana).

placa(AAA-1111).
placa(BBB-2222).
placa(CCC-3333).
placa(DDD-4444).
placa(EEE-5555).

%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).
                       
%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.

% X está exatamente à esquerda de Y
exatamenteEsquerda(X, Y, List) :- nextto(X, Y, List).

% X está exatamente à esquerda de Y
exatamenteDireita(X, Y, List) :- nextto(Y, X, List).

%X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :- 

    ListaSolucao = [
        caminhao(Cor1, Km1, Motorista1, Carga1, Destino1, Placa1),
        caminhao(Cor2, Km2, Motorista2, Carga2, Destino2, Placa2),
        caminhao(Cor3, Km3, Motorista3, Carga3, Destino3, Placa3),
        caminhao(Cor4, Km4, Motorista4, Carga4, Destino4, Placa4),
        caminhao(Cor5, Km5, Motorista5, Carga5, Destino5, Placa5)
    ],

    %Jorge é o motorista do caminhão de placa DDD-4444.
    member(caminhao(_, _, jorge, _, _, DDD-4444), ListaSolucao),

    %Na quarta posição está o caminhão que vai para Belo Horizonte.
    Destino4 = minas_gerais,
    
    %O caminhão menos rodado está transportando Carvão.
    member(caminhao(_, 50, _, carvao, _, _), ListaSolucao),
    
    %O caminhão Vermelho está em algum lugar à esquerda do caminhão que vai para o Amazonas.
    aEsquerda(caminhao(vermelho, _, _, _, _, _), caminhao(_, _, _, _, amazonas, _), ListaSolucao),
    
    %O veículo que vai para a região Centro-oeste está ao lado do caminhão que já rodou 100 mil Km.
    aoLado(caminhao(_, _, _, _, mato_grosso, _), caminhao(_, 100, _, _, _, _), ListaSolucao),

    %O caminhão Vermelho está em algum lugar entre o caminhão que está carregando Enxofre e o caminhão Azul, nessa ordem.
    aDireita(caminhao(vermelho, _, _, _, _, _),caminhao(_, _, _, enxofre, _, _),ListaSolucao),
    aEsquerda(caminhao(vermelho, _, _, _, _, _),caminhao(azul, _, _, _, _, _),ListaSolucao),
    
    %Na primeira posição está o caminhão que tem 150 mil Km rodados.
    Km1 = 150,
    
    %Em uma das pontas está o caminhão de placa AAA-1111.
    noCanto(caminhao(_, _, _, _, _, AAA-1111), ListaSolucao),
    
    %O caminhão de placa DDD-4444 está transportando Soda cáustica.
    member(caminhao(_, _, _, soda_caustica, _, DDD-4444), ListaSolucao),
    
    %O caminhão Branco está em algum lugar à direita do caminhão Verde.
    aDireita(caminhao(branco, _, _, _, _, _),caminhao(verde, _, _, _, _, _),ListaSolucao),

    %O veículo de placa BBB-2222 está ao lado do veículo mais rodado.
    aoLado(caminhao(_, _, _, _, _, BBB-2222), caminhao(_, 250, _, _, _, _), ListaSolucao),
    
    %Quem vai para a região Nordeste está em algum lugar à direita do caminhão Vermelho.
    aDireita(caminhao(_, _, _, _, bahia, _),caminhao(vermelho, _, _, _, _, _),ListaSolucao),
    
    %O caminhão Amarelo está exatamente à esquerda do caminhão que tem 200_mil Km rodados.
    exatamenteEsquerda(caminhao(amarelo, _, _, _, _, _),caminhao(_, 200, _, _, _, _),ListaSolucao),
    
    %O veículo de placa CCC-3333 está exatamente à direita do veículo de placa DDD-4444.
    exatamenteDireita(caminhao(_, _, _, _, _, CCC-3333), caminhao(_, _, _, _, _, DDD-4444), ListaSolucao),
    
    %O Stênio está dirigindo para Minas_Gerais.
    member(caminhao(_, _, stênio, _, minas_gerais, _), ListaSolucao),
    
    %O caminhão com Adubo está em algum lugar entre o caminhão que vai para Bahia e o caminhão com Carvão, nessa ordem.
    aDireita(caminhao(_, _, _, adubo, _, _),caminhao(_, _, _, _, bahia, _),ListaSolucao),
    aEsquerda(caminhao(_, _, _, adubo, _, _),caminhao(_, _, _, carvao, _, _),ListaSolucao),

    %O veículo Azul está em algum lugar à direita do veículo de placa AAA-1111.
    aDireita(caminhao(azul, _, _, _, _, _),caminhao(_, _, _, _, _, AAA-1111),ListaSolucao),

    %O caminhão de placa DDD-4444 está ao lado do caminhão que já rodou 100 mil Km.
    aoLado(caminhao(_, _, _, _, _, DDD-4444), caminhao(_, 100, _, _, _, _), ListaSolucao),

    %Antônio é o motorista do caminhão de placa EEE-5555.
    member(caminhao(_, _, antônio, _, _, EEE-5555), ListaSolucao),

    %O caminhão Azul está em algum lugar à esquerda do caminhão Branco.
    aEsquerda(caminhao(azul, _, _, _, _, _),caminhao(branco, _, _, _, _, _),ListaSolucao),

    %Pedro está ao lado do caminhão que vai para o Mato_Grosso.
    aoLado(caminhao(_, _, pedro, _, _, _), caminhao(_, _, _, _, mato_grosso, _), ListaSolucao),

    %Em uma das pontas está o caminhão de placa EEE-5555.
    noCanto(caminhao(_, _, _, _, _, EEE-5555), ListaSolucao),

    %--------------------------------------------------------------------------------------------

    %Testa todas as possibilidades...
    cor(Cor1), cor(Cor2), cor(Cor3), cor(Cor4), cor(Cor5),
    todosDiferentes([Cor1, Cor2, Cor3, Cor4, Cor5]),
    
    km(Km1), km(Km2), km(Km3), km(Km4), km(Km5),
    todosDiferentes([Km1, Km2, Km3, Km4, Km5]),
    
    motorista(Motorista1), motorista(Motorista2), motorista(Motorista3), motorista(Motorista4), motorista(Motorista5),
    todosDiferentes([Motorista1, Motorista2, Motorista3, Motorista4, Motorista5]),
    
    carga(Carga1), carga(Carga2), carga(Carga3), carga(Carga4), carga(Carga5),
    todosDiferentes([Carga1, Carga2, Carga3, Carga4, Carga5]),
    
    destino(Destino1), destino(Destino2), destino(Destino3), destino(Destino4), destino(Destino5),
    todosDiferentes([Destino1, Destino2, Destino3, Destino4, Destino5]),

    placa(Placa1), placa(Placa2), placa(Placa3), placa(Placa4), placa(Placa5),
    todosDiferentes([Placa1, Placa2, Placa3, Placa4, Placa5]).
    
    
