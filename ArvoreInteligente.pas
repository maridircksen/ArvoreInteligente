{
Acadêmicas: Julia Salvador e Mariana Dircksen 
Desenvolver trabalho para inserir perguntas e respostas em uma árvore binária, de tal forma que a árvore armazene as informações, 
gerando um "aprendizado de máquina". Nesta atividades os nós folhas serão sempre as respostas, enquanto os demais serão perguntas
}

Program ArvoreInteligente;

type
  PonteiroNodaArvore = ^NodaArv;
  NodaArv = record
    Pergunta: string;
    noSim, noNao: PonteiroNodaArvore;
    cidadeNome: string;
  end;

{Neste procedimento a árvore iniciará com um nó pai como pergunta e terá como nós filhos 2 cidades.}
procedure criaNo(var noRaiz: PonteiroNodaArvore);
	begin
	  New(noRaiz);
	  noRaiz^.Pergunta := 'A cidade que você pensou é Capital do Alto vale do Itajaí?';
	  
	  New(noRaiz^.noSim);
	  noRaiz^.noSim^.Pergunta := 'Rio do Sul';
	  noRaiz^.noSim^.noSim := nil;
	  noRaiz^.noSim^.noNao := nil;
	  
		New(noRaiz^.noNao);
	  noRaiz^.noNao^.Pergunta := 'Ituporanga';
	  noRaiz^.noNao^.noSim := nil;
	  noRaiz^.noNao^.noNao := nil;
	end;
	
	
{Procedimento que inicia o jogo de adivinhação}
procedure cidadePensada(var noAtual: PonteiroNodaArvore; var Contador: integer);
var
  Resposta: char;
  sCidade, sCaracteristica: string;
begin
  if (noAtual^.Pergunta <> 'cidadeModificada') then
  begin
    writeln('Sua cidade possui como carcaterística ou sua cidade é? (S/N): ', noAtual^.Pergunta);
    readln(Resposta);
    //Upcase utilizado para o usário conseguir informar como resposta letras minúsculas (n/s)
    Resposta := UpCase(Resposta);
  end
  else
  begin
    Resposta := 'N';
  end;

  if (Resposta = 'S') then
  begin
    if (noAtual^.noSim <> nil) then
      cidadePensada(noAtual^.noSim, Contador)
    else
      writeln('Você pensou na cidade ', noAtual^.Pergunta);
  end
  else if (Resposta = 'N') and (noAtual^.noNao <> nil) then
  begin
    cidadePensada(noAtual^.noNao, Contador);
  end
  else
  begin
    clrscr;
    writeln('Informe uma característica da cidade que você pensou:');
    readln(sCaracteristica);
    clrscr;
    writeln('Qual cidade você pensou?');
    readln(sCidade);
    clrscr;

    noAtual^.Pergunta := sCaracteristica;

    New(noAtual^.noSim);
    noAtual^.noSim^.Pergunta := sCidade;
    noAtual^.noSim^.noSim := nil;
    noAtual^.noSim^.noNao := nil;

    New(noAtual^.noNao);
    noAtual^.noNao^.Pergunta := 'cidadeModificada';
    noAtual^.noNao^.noSim := nil;
    noAtual^.noNao^.noNao := nil;
  end;
end;

{Procedimento de interação com o usuário}
procedure MenuTela();
var
  noRaiz: PonteiroNodaArvore ;
  i,iContador: integer;
    
begin
	writeln('Bem-vindo ao Jogo de Adivinhação de Cidades!');
	writeln('-----------------------------------------');
  writeln('Clique em qualquer tecla');
  readkey;
  clrscr;
  iContador := 0;
  i:= 1;
  while (i <> 0) do
  begin
    clrscr;
    if (noRaiz = nil) then
      criaNo(noRaiz);

    writeln('Pense em uma cidade de Santa Catarina e Responda com Sim ou Não (S para Sim e N para Não)');
    cidadePensada(noRaiz, iContador);
    writeln;
    writeln('Para sair do jogo, digite 0.');
    writeln('Para continuar, digite qualquer outro número:');
    readln(i);
  end;
end;
  
begin
   MenuTela;
end.
