# VLSI EXPERIMENT-10  Aug-Dec 2020
# Author  :  PaletiKrishnasai CED18I039

from os import name, sep
import re
import networkx as nx
from pathlib import Path


def readfile():
    fp = open(input("Enter the filename: "),'r')
    lines = fp.readlines() # returns all lines in the file as items in list
    return lines

def parse(lines):
    

    data = {
        'supported_gates': ["nor", "nand", "not", "xor", "xnor", "and", "or"],
        'module_name':'',
        'input':[],
        'output':[],
        'wire':[],
        'gates':[],
        'reg':[],
        'nodes':[]
    }

    for line in lines:
        line.lstrip()

    
        if(line.startswith('input')):
            line = line.lstrip('input').split(sep=',')
            line = [x.strip('\n; ') for x in line]
            [data['input'].append(x) for x in line]
        
        elif(line.startswith('output')):
            line = line.lstrip('output').split(sep=',')
            line = [x.strip('\n; ') for x in line]
            [data['output'].append(x) for x in line]
        
        elif(line.startswith('wire')):
            line = line.lstrip('wire').split(sep=',')
            line = [x.strip('\n; ') for x in line]
            [data['wire'].append(x) for x in line]

        elif(line.startswith('reg')):
            line = line.lstrip('reg').split(sep=',')
            line = [x.strip('\n; ') for x in line]
            [data['reg'].append(x) for x in line]

        elif(line.startswith('module')):
            line = line.lstrip('module').split(sep='(')
            line = [x.strip('\n; ') for x in line]
            data['module_name'] = line[0]
        #
        # get intermediate nodes
        elif(any(k in line for k in data['supported_gates'])):
            line = re.split(r'[();,\s]\s*',line)
            line =list(filter(None,line))

            line = [i for i in line if i not in data['supported_gates']]
            # get instantiation names as nodes
            data['gates'].append(line[0])
            for x in line[2:]:
                data["nodes"].append((x,line[0]))
            data["nodes"].append((line[0],line[1]))

    return data

def paths(G,graph):

    
    print('\n')
    print('Input: ', end='')
    print(*graph['input'], sep=', ')
    print('Output: ', end='')
    print(*graph['output'], sep=', ', end='\n\n')

    print()

    for io in [[i, o] for i in graph['input'] for o in graph['output']]:
        for path in nx.all_simple_paths(G, source=io[0], target=io[1]):
            print(*path, sep=' ----> ')

if __name__ =="__main__":
    lines = readfile()
    graph = parse(lines)
    G = nx.DiGraph()
    G.add_edges_from(graph['nodes'])
    paths(G,graph)
    print('\n\n')
