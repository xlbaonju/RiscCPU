        JMP LOOP  
	0
	0
LOOP:   LDA FN2  
        STO TEMP 
        ADD FN1 
        STO FN2
        LDA TEMP 
        STO FN1 
        XOR LIMIT 
        SKZ      
        JMP LOOP
DONE:   HLT     
AGAIN:  LDA ONE
        STO FN1
        LDA ZERO
        STO FN2
        JMP LOOP 
	0
	0
	0
	0
	0
	0
	0
	0
FN1:    1         
FN2:    0        
TEMP:   0       
LIMIT:  144      
ZERO:   0     
ONE:    1    
