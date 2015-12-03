
default: output/subg_rfspy.hex
CC=sdcc
CFLAGS=-I. --verbose -DRILEYLINK
output:
	mkdir output

output/%.rel : %.c output
	$(CC) $(CFLAGS) -o output/ -c $<

output/subg_rfspy.hex: output/radio.rel output/serial.rel output/main.rel 
	$(CC) $(CFLAGS) output/radio.rel output/serial.rel output/main.rel -o output/subg_rfspy.hex
install: output/subg_rfspy.hex
	cc-tool -n cc1110 --log install.log -ew output/subg_rfspy.hex

test: main.c output
	gcc -g -o output/test -DNON_NATIVE_TEST main.c
