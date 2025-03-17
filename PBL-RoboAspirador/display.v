module display(E, D, F, A, LD, Erro, D1, D2, D3, D4, A7, B7, C7, D7, E7, F7, G7);
	
	input E, D, F, A, LD, Erro;
	output D1, D2, D3, D4, A7, B7, C7, D7, E7, F7, G7;
   
	// Deixa os outros digitos do display desligados 
   not(D1, 0);
	not(D2, 0);
	not(D3, 0);
   // Para ligar e desligar usando a entrada LD
	not(D4, LD);
	
	// Fios
   wire and1, and2_0, and2_1, and3, and4, and5, and6, and7, and8, and_B0_1, and_B0_2;
   wire or0, or1, or2;
	wire aux_B2, aux_B1, aux_B0, aux_B0_0;
	
   // Negação das entradas
	not (notE, E);
	not (notD, D);
	not (notF, F);
	not (notA, A);
	not (notErro, Erro);
   not (notB2, out_B2);
   not (notB1, out_B1);
   not (notB0, out_B0);

   // Expressão original B2: F = E D F !A   // Expressão F Modificado = (E D F !A !Erro) + (Erro)
   and (aux_B2, E, D, F, notA, notErro);
	or (out_B2, aux_B2, Erro);
	
	// Expressão original B1: F = !F + !D   // Expressão F Modificado = (!F + !D).(!Erro)  
	or (aux_B1, notF, notD);
	and (out_B1, aux_B1, notErro);
	
	
	// Expressão original B0: F = !D F + !E F   // Expressão F Modificado = ((!D F + !E F) . !Erro) + Erro
	and (and_B0_1, notD, F);
	and (and_B0_2, notE, F);
	or (aux_B0, and_B0_1, and_B0_2);
	and (aux_B0_0, aux_B0, notErro);
	or(out_B0, aux_B0_0, Erro);
	
	// Expressão A: F = B1 B0
   and (and1, out_B1, out_B0);
   // Saída da função A
   or (A7, and1, 0); // Porta OR com 0 serve como "buf" para transmitir and1 como A7

   // Expressão B: F = B1 !B0 + !B2 !B1 B0
   and (and2_0, out_B1, notB0);
	and (and2_1, notB2, notB1, out_B0);
   or  (or0, and2_0, and2_1);
	// Saída da função B
   or (B7, or0, 0); // Porta OR com 0 serve como "buf" para transmitir or0 como B7

   // Expressão C: F = !B2 !B0 + !B2 !B1
   and (and3, notB2, notB0);
   and (and4, notB2, notB1);
   or (or1, and3, and4);
   // Saída da função C
   or (C7, or1, 0); // Porta OR com 0 serve como "buf" para transmitir or1 como C7

   // Expressão D: F = !B0
   and (and5, notB0);
   // Saída da função D
	or (D7, and5, 0); // Porta OR com 0 serve como "buf" para transmitir and5 como D7
	
	// Expressão E: F = B2 B0  
   and (and6, out_B2, out_B0);
   // Saída da função E
	or (E7, and6, 0); // Porta OR com 0 serve como "buf" para transmitir and6 como E7
	
	// Expressão F: F = B2 B0 + B1 B0
   and (and7, out_B2, out_B0);
   and (and8, out_B1, out_B0);
   or (or2, and7, and8);
   // Saída da função F
   or (F7, or2, 0); // Porta OR com 0 serve como "buf" para transmitir or2 como F7

   // Expressão G: F = 0
   // Para sempre fornecer 0, podemos usar uma porta OR com um zero constante
   and (G7, 1'b0, 1'b0); // AND com ambos os termos 0 resulta em 0
	
endmodule 