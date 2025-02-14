"""Explore values of unused mystery function at BOOT:$651A"""

table = [9,10,11,12,13,14,15,16]

def do():
	x = table.pop(-1)
	table[:] = [(a+x)%0x100 for a in table] + [x]
	for i in reversed(range(len(table))):
		table[i] += 1
		if table[i] > 255:
			table[i] = 0
		else:
			break

for n in range(2400):
	do()
	print(table)
