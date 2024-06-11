// Declaracao do modulo do contador regressivo 5 ate 0
module Dezenas_Segundos (clock, QDSegundos, Pulso);

	// Declaracao de portas
   input clock;
	input Pulso;
	output [3:0] QDSegundos;
	
	// Fios intermediarios
	wire N_Q0, N_Q1, N_Q2;
	wire [3:0] D;
	wire And_NQ0_Q1, And_NQ0_Q2, And_NQ, And_Q1_Q2, And_Q0_Q2; 
	
	// Inversor das portas Q
	not (N_Q0, QDSegundos[0]);
	not (N_Q1, QDSegundos[1]);
	not (N_Q2, QDSegundos[2]);
	
	// Expressoes da Entrada D0 
	and And1 (And_NQ0_Q1, N_Q0, QDSegundos[1]);						
	and And2 (And_NQ0_Q2, N_Q2, N_Q0, QDSegundos[2]);				
	or Or1	(D[0], And_NQ0_Q1, And_NQ0_Q2);	
	
	// Expressoes da Entrada D1 
	and And3 (And_NQ, N_Q0, N_Q1, N_Q2);						
	and And4 (And_Q1_Q2, QDSegundos[1], QDSegundos[2]);				
	or Or2 (D[1], And_NQ, And_Q1_Q2);	

	// Expressoes da Entrada D2						
	and And5 (And_Q0_Q2, QDSegundos[0], QDSegundos[2]);				
	or Or3	(D[2], And_NQ, And_Q0_Q2);	
	
	// Funcionamento do circuito
	
	// Bit menos significativo D0
	ffd Ds_Q0 (.D(D[0]),
				  .clk(clock),
				  .Q(QDSegundos[0])
	);
	
	// Bit D1
	ffd Ds_Q1 (.D(D[1]),
				  .clk(clock),
				  .Q(QDSegundos[1])
	);
	
	// Bit mais significativo D2
	ffd Ds_Q2 (.D(D[2]),
				  .clk(clock),
				  .Q(QDSegundos[2])
	);
	
endmodule 