RiscCPU
====================================
This repo is about an assembler called bas and a virtual machine whose <br />
instruction set is based on the lesson Fundamentals of IC design last term.

I saw a repo "carp" and became interested in it.You can get it from here:<br />
https://github.com/tekknolagi/carp.git

As carp is to translate the asm source, to some point it is not thorough enough.<br />
Even there is no specific machine for it and no compiled file you can get.<br />
My original plan is to refer to the Carp to write a VM about i386.But i can't<br />
 find something about the i386's instruction.So I refer to the lesson last term.

### Make

`cd RiscCPU`<br />
`make`

### ASM

Compile the test\*.s, there will be a binary file called "test.bin":<br />
`./bas < test\*.s`

### Run
Load the binary file and run the VM, you can see what the cpu happened <br />
during every instruction cycle:<br />
`./vm`

Just for fun,if your asm souce can't pass compiler, forgive me there is <br />
few error checking.
