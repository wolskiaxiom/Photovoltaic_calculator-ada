import matplotlib.pyplot as plt

x = []
y = []
xd = []
yd = []
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

with open("statsForOneDay.txt") as f:
    for line in f:
        tmp = line.split(';')
        if tmp[0] == '\n':
            pass
        else:
            xd.append(int(tmp[0]))
            yd.append(int(tmp[1]))
plt.figure(num=1, figsize=(8, 60), dpi=80)
plt.subplot(211)
plt.plot(x, y, 'ro', color='orange')
plt.xlabel("Miesiace")
plt.ylabel("Ilosc energii")
plt.title("Produkcja energii elektrycznej")

plt.subplot(212)
plt.plot(xd, yd, 'ro', color='green')
plt.xlabel("Dni")
plt.ylabel("Ilosc energii")
plt.show()