import matplotlib.pyplot as plt

x = []
y = []
xd = []
xy = []
cum = []
plt.xscale("linear")

with open("stats.txt") as f:
    for line in f:
        tmp = line.split(';')
        if tmp[0] == '\n':
            pass
        else:
            x.append(int(tmp[0]))
            y.append(int(tmp[1]))
            cum.append(int(tmp[2].replace('\n', '')))

with open("statsfor one day.txt") as f:
    for line in f:
        tmp = line.split(';')
        if tmp[0] == '\n':
            pass
        else:
            xd.append(int(tmp[0]))
            yd.append(int(tmp[1]))

plt.plot(x, y, 'ro', color='orange')
plt.xlabel("Miesiace")
plt.ylabel("Ilosc energii")
plt.title("Produkcja energii elektrycznej")
plt.savefig('plot.png')

plt.plot(x, y, 'ro', color='green')
plt.xlabel("Dni")
plt.ylabel("Ilosc energii")
plt.title("Produkcja energii elektrycznej")
plt.savefig('plotperday.png')