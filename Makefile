all:
	gcc -c src/how_many_modules.adb src/main.adb
	gnatbind -x main.ali
	gnatlink main.ali
	rm -f *.o *.ali

