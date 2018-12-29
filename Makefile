all:
	gcc -c main.adb
	gnatbind -x main.ali
	gnatlink main.ali
	rm *.0 * ali