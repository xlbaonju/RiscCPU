This repo is about an assembler called bas and a virtual machine whose instruction set is based on the lesson Fundamentals of IC design last term.

I saw a repo "carp" and became interested in it.You can get it from here:
https://github.com/tekknolagi/carp.git

As carp is to translate the asm source, to some point it is not thorough enough.Even there is no specific machine for it and no compliered file you can get.
My original plan is to refer to the Carp to write a VM about i386.But i can't find something about the i386's instruction.So I refer to the lesson last term.

Comlier the source:
cd RiscCPU
make

Complier the test.s, there will be a binary file called "test.bin"
./bas < test.s

Load the binary file and run the VM, you can see what the cpu happened during every instruction cycle:
./vm

Just for fun, so forgive me there is few error checking.
