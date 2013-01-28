CHPUT EQU &H00A2

	ORG &H9000
	
DB &HFE
DW progBEGIN
DW progEND
DW progSTART

progBEGIN:
progSTART:
	LD HL, string

loop:
	LD A,0
	CP (HL)
	RET Z
	LD A,(HL)
	CALL CHPUT
	
	INC HL
	JP loop
	
string:
DB 'Hello World!',0

progEND: END
