import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
import math
import random


def creat_matrix(nodes, degree):
    connection = np.zeros((nodes, nodes), dtype = 'i1')

    for offset in range(1, int(degree/2)+1):
        for row in range(nodes):
            connection[row, (row+offset)%nodes] = 1
            connection[(row+offset)%nodes, row] = 1

    # print(connection)
    return connection

def reconnect(matrix, p):
    for row in range(len(matrix)-1):
        for column in range(row+1, len(matrix)):
            if(connection[row, column] == 1):
                if(random.random() < p):
                    connection[row, column] = 0
                    connection[column, row] = 0

                    while True:
                        new_connect = random.randint(0,len(matrix)-1)
                        if(new_connect != row) and (connection[row, new_connect] == 0):
                            connection[row, new_connect] = 1
                            connection[new_connect, row] = 1
                            # print(row,',',column,"->",row,',',new_connect)
                            break
    return matrix

def create_graph(matrix):
    graph = nx.Graph()#创建空的网络图

    graph.add_nodes_from(range(len(matrix)))

    for row in range(len(matrix)):
        for column in range(row+1, N):
            if(connection[row, column] == 1):
                graph.add_edge(row, column)

    return graph


N = 100
degree = 4
# break_p = 0.5

# connection = creat_matrix(N, degree)
# # print(connection)

# reconnection = reconnect(connection, break_p)
# # print(C)

# G = create_graph(reconnection)

D_buf = []
C_buf = []

p_buf = []
for i in np.arange(-4, 0, .5):
    p_buf.append(math.pow(10, i))

print("p_buf: ", p_buf)


connection = creat_matrix(N, degree)
G = create_graph(connection)

D_0 = nx.average_shortest_path_length(G)
C_0 = nx.average_clustering(G)

for p in p_buf:
    sum_d = 0
    sum_c = 0
    repeat = 10
    for i in range(repeat):
        connection = creat_matrix(N, degree)
        reconnection = reconnect(connection, p)
        G = create_graph(reconnection)
        
        d = nx.average_shortest_path_length(G)
        sum_d = sum_d + d

        c = nx.average_clustering(G)
        sum_c = sum_c + c
        
    D_buf.append(sum_d/repeat)
    C_buf.append(sum_c/repeat)

    print(p)

D_rate = []
C_rate = []
for i in D_buf:
    D_rate.append((D_buf[i])/D_0)
    C_rate.append((C_buf[i])/C_0)



# print(D_buf[0])
# print(C_buf[0])


plt.semilogx(p_buf, D_rate, color = 'red')
plt.semilogx(p_buf, C_rate, color = 'blue')

plt.show()
# pos = nx.circular_layout(G)
# nx.draw_networkx_nodes(G, pos, node_size=10)
# nx.draw_networkx_edges(G, pos)
# # nx.draw_networkx_labels(G, pos)

# plt.show()



# nx.write_gexf(G,'your_file_name.gexf')


