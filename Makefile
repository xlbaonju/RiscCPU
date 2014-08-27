all : bas vm
bas : 
	(cd assembler;make)
vm :
	(cd VM;make)
clean :
	(cd assembler;make clean)
	(cd VM;make clean)
