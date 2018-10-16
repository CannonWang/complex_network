import networkx as nx

G = nx.Graph()#创建空的网络图
# G = nx.DiGraph()
# G = nx.MultiGraph()
# G = nx.MultiDiGraph()

# G.add_node('a')#添加点a
# G.add_node('b')#添加点a
# G.add_node(1,1)#用坐标来添加点
G.add_edge('1','3')#添加边,起点为x，终点为y
G.add_edge('1','4')#添加边,起点为x，终点为y
G.add_edge('2','4')#添加边,起点为x，终点为y
G.add_edge('2','5')#添加边,起点为x，终点为y
G.add_edge('3','5')#添加边,起点为x，终点为y
G.add_edge('3','6')#添加边,起点为x，终点为y
G.add_edge('4','6')#添加边,起点为x，终点为y
G.add_edge('4','7')#添加边,起点为x，终点为y
G.add_cycle(range(100))
# G.add_weight_edges_from([('x','y',1.0)])#第三个输入量为权值

# node=['A','B','C']
# edge=[ ['A','B'] , ['B','C'] ]

# G.add_nodes_from(node)
# G.add_edges_from(edge)
nx.write_gexf(G,'your_file_name.gexf')


