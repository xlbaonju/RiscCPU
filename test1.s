BEGIN:   JMP TST_JMP
         HLT        
         HLT        
JMP_OK:  LDA DATA_1
         SKZ
         HLT        
         LDA DATA_2
         SKZ
         JMP SKZ_OK
         HLT        
SKZ_OK:  STO TEMP  
         LDA DATA_1
         STO TEMP   
         LDA TEMP
         SKZ       
         HLT        
         XOR DATA_2
         SKZ       
         JMP XOR_OK
         HLT        
XOR_OK:  XOR DATA_2
         SKZ
         HLT      
END:     HLT       
         JMP BEGIN  
DATA:	 0
DATA_1:  0
DATA_2:  255          
TEMP:    170
	 0        
TST_JMP: JMP JMP_OK
	 HLT
