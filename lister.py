from glob import glob

f = open("list.txt", "w")
pics = glob('*.jpg')

for pic in pics:
	f.write("<a class=\"spotlight\" href=\"gallery" + str(pic) + "\">\n")
	f.write("\t<img src=\"gallery/thumb/" + str(pic) + "\" alt=\"\">\n")
	f.write("</a>\n")

f.close()

