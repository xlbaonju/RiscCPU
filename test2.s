BEGIN:  LDA DATA_2
        AND DATA_3 
        XOR DATA_2
        SKZ
        HLT       
        ADD DATA_1
        SKZ
        JMP ADD_OK
        HLT      
ADD_OK: XOR DATA_3
        ADD DATA_1
        STO TEMP
        LDA DATA_1
        ADD TEMP 
        SKZ
        HLT     
END:    HLT      
        JMP BEGIN
DATA_1: 1          
DATA_2: 170         
DATA_3: 255         
TEMP:	0
