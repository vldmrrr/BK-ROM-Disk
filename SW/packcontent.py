#!/usr/bin/python
# -*- coding: utf-8
import os
import subprocess
import traceback
import struct
import operator
import optparse
import sys
import codecs

encoding_map = codecs.make_identity_dict(range(256))
pairs = zip(range(0xc0)+[ord(c) for c in u'юабцдефгхийклмнопярстужвьызшэщчъЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧЪ'],range(255))
encoding_map.update(dict( (utf, koi) for (utf, koi) in pairs))
def koi(s):
	return codecs.charmap_encode(s.decode('utf-8'),'strict',encoding_map)[0]

def compress(data):
	uf='uncompressed.content'
	cf='compressed.content'
	with open(uf,'wb') as f:
		f.write(data)
	err=subprocess.call([gOps.compressorPath,uf,cf],stdout=open(os.devnull))
	os.remove(uf)
	if err:
		raise Exception('Error while compressing file')
	with open(cf,'rb') as f:
		cdata=f.read()
	os.remove(cf)
	return cdata

def processTape(cnt):
	(adr,size)=struct.unpack('<HH',cnt[:4])
	if size != len(cnt)-4:
		sys.exit('Size of .BIN file (%d) does not match header (%d): %s'%(len(cnt),size,fpath))
	res={}
	res['adr']=adr
	res['size']=size
	res['cnt']=compress(cnt[4:])
	return res
	

def processFile(fpath):
	with open(fpath,'rb') as f:
		cnt=f.read()
	(name,ext)=os.path.splitext(os.path.basename(fpath))
	ext=ext.upper()
	if ext == '.COD': # basic file
		res = processTape(cnt)
		res['type']='b' 
	else: # for everything else assume binary tape
		res = processTape(cnt)
		res['type']='i'
		
	res['name'] = koi(os.path.basename(fpath))
	print '%5d %5d %s'%(res['size'],len(res['cnt']),fpath)
	return res

def processDir(path):
	menu = {'files':[],'dirs':[]}
	items = os.listdir(path)
	for it in items:
		ipath = os.path.join(path,it)
		if os.path.isfile(ipath):
			try:
				f = processFile(ipath)
				gFiles.append(f)
				menu['files'].append(f)
			except:
				exit("Error while processing %s: %s"%(ipath,traceback.format_exc()))
		if os.path.isdir(ipath):
			dmenu = processDir(ipath)
			if os.path.basename(ipath)[0] != '.': # do not show hidden dirs in menu
				menu['dirs'].append(dmenu)
	menu['name']=koi(os.path.basename(path))
	return menu

def l3b(l):
	return struct.pack('<I',l)[:3]

def pad(s):
	return s if len(s)%2==0 else (s+'\x00')

def cstr(s,maxlen = 32):
	slen = min(len(s),maxlen)
	return pad(s[:slen]+'\x00')

def writeDir(info):
	for d in info['dirs']:
		writeDir(d)
	global gMenu
	info['ofs'] = len(gMenu)
	#print '%s: %d dirs %d files'%(info['name'],len(info['dirs']),len(info['files']))
	gMenu += cstr(info['name']) + struct.pack('<H',len(info['dirs'])+len(info['files']))
	info['dirs'].sort(key=operator.itemgetter('name'))
	for d in info['dirs']:
		gMenu += struct.pack('<H',d['ofs']|0x8000)
	info['files'].sort(key=operator.itemgetter('name'))
	for f in info['files']:
		if f['num'] in gExcludedFiles:
			continue
		gMenu+=struct.pack('<H',f['iofs'])		

def wf(name,cnt):
	with open(name,'wb') as f:
		f.write(cnt)

def makeROM(items):
	finfo=flist=content=''
	for f in gFiles:
		if f['num'] in gExcludedFiles:
			continue
		f['cofs']=len(content)
		content+=f['cnt']
		f['iofs']=len(finfo)
		finfo += cstr(f['name'])+struct.pack('<2H3sc',f['adr'],f['size'],l3b(f['cofs']),f['type'])
		flist += struct.pack('<H',f['iofs'])
	
	global gMenu
	gMenu = ""
	items['name']="BK011 Menu loader"
	writeDir(items)
	cmenu = compress(struct.pack('<H',items['ofs']) + gMenu)
	
	fdata = struct.pack('<H',len(flist))+flist+finfo
	cfdata = compress(fdata)
	
	with open(gOps.loaderPath,'rb') as f:
		ldr = f.read()
	rom = pad(ldr)+struct.pack('<H',len(ldr)+2+len(cfdata)+len(cmenu)) + cfdata+cmenu+content
	return rom


def main():
	usage = '%prog [options]'
	parser = optparse.OptionParser(usage)
	
	parser.add_option("-s", "--size", dest="maxsize",
		default=1024,
		help="Maximum size of created file in KBytes (default: %default)")
	parser.add_option("-l", "--loader", dest="loaderPath",
		default="./menuloader",
		help="Path to menu executable code (loaded at start uncompressed, default: %default)")
	parser.add_option("-c", "--compressor", dest="compressorPath",
		default="./megalz",
		help="Path to compressor program (default: %default)")
	parser.add_option("-i", "--input", dest="inputPath",
		default="./content",
		help="Path to directory with content (default: %default)")
	parser.add_option("-o", "--output", dest="outputPath",
		default="./ROM.bin",
		help="Output file (default: %default)")
	global gOps
	(gOps, args) = parser.parse_args()
	
	if not os.path.isdir(gOps.inputPath):
		sys.exit('Input directory %s does not exist'%gOps.inputPath)
	
	if not os.path.isfile(gOps.loaderPath):
		sys.exit('Loader file %s does not exist'%gOps.loaderPath)
	
	if not os.path.isfile(gOps.compressorPath):
		sys.exit('Compressor exectuable %s does not exist'%gOps.compressorPath)

	global gFiles
	gFiles = []
	items = processDir(gOps.inputPath)
	gFiles.sort(key=operator.itemgetter('name'))
	for i in xrange(len(gFiles)):
		gFiles[i]['num']=i
	
	global gExcludedFiles
	gExcludedFiles=set()
	while True:
		rom = makeROM(items)
		sz = len(rom)
		free =gOps.maxsize*1024-sz		
		if free>=0:
			print "Saving ROM to %s, content size %d bytes"%(gOps.outputPath,sz),
			if (free >0):
				print ", free space size %d bytes"%(free)
			else:
				print
			with open(gOps.outputPath,'wb') as f:
				f.write(rom)
				if (free>0):
					f.write("\xff"*free)
			print "Done"
			sys.exit(0)
		print "Content have size %d b=ytes which exceeds specified ROM size by %d bytes"%(sz,free)
		while True:
			print "Enter comma separated list of file to trye to generate load with this files excluded"
			print "Press 'Enter' to list files in load"
			l=raw_input("Your choice: ")
			if l=='':
				for f in gFiles:
					print '%4d %5d %s'%(f['num']+1, len(f['cnt']),f['name'])
				continue
			try:
				gExcludedFiles = set([int(i)-1 for i in l.split(',')])
			except ValueError:
				print "Invalid input"
				continue
			break

if __name__ == "__main__":
    main()

