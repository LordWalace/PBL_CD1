module Pbl(LD, E, D, F, A, Alto, Medio, Baixo, L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, ErroOut, LRGB_Out, D1, D2, D3, D4, A7, B7, C7, D7, E7, F7, G7);

	input E, D, F, A, Alto, Medio, Baixo, LD;
	output L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, ErroOut, LRGB_Out, D1, D2, D3, D4, A7, B7, C7, D7, E7, F7, G7;
	
	//Negações
	not(notBaixo, Baixo);
	not(notMedio, Medio);
	not(notAlto, Alto);
	not(notErro, Erro);
	
	
	//Expressão para Led0: F = Baixo
	and(L0, Baixo);
	
	//Expressão para Led1: F = Medio
	and(L1, Medio);
	
	//Expressão para Led2: F = Medio
	and(L2, Medio);
	
	//Expressão para Led3: F = Medio
	and(L3, Medio);
	
	//Expressão para Led4: F = Medio
	and(L4, Medio);
	
	//Expressão para Led5: F = Alto
	and(L5, Alto);
	
	//Expressão para Led6: F = Alto
	and(L6, Alto);
	
	//Expressão para Led7: F = Alto
	and(L7, Alto);
	
	//Expressão para Led8: F = Alto
	and(L8, Alto);
	
	//Expressão para Led9: F = Alto
	and(L9, Alto);
	
	//Expressão para Bateria: Bateria/Erro: F = !Baixo + Alto !Medio  "Erro LRGB(Vermelho)"
	and(aux, Alto, notMedio);	
	or (Erro, notBaixo, aux);

	and(ErroOut, Erro, LD);
	not(LRGB, !LD);

	and (LRGB_Out, notErro, LRGB);
	
	// Chamada do display
	display(E, D, F, A, LD, Erro, D1, D2, D3, D4, A7, B7, C7, D7, E7, F7, G7);
	
endmodule 