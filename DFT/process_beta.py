# python script : generate hyperpolarizability tensor and also three matrices
import numpy as np
beta=np.zeros((3,3,3))
beta[0][0][0]=-0.00002273
beta[1][0][0]=0.00000031
beta[2][0][0]=-0.00000000
beta[0][0][0]=beta[0][0][0]
beta[1][0][0]=beta[1][0][0]
beta[2][0][0]=beta[2][0][0]
beta[0][1][0]=0.00001077
beta[1][1][0]=0.00001840
beta[2][1][0]=0.00000000
beta[0][1][0]=beta[0][1][0]
beta[1][1][0]=beta[1][1][0]
beta[2][1][0]=beta[2][1][0]
beta[0][2][0]=-0.00000000
beta[1][2][0]=0.00000000
beta[2][2][0]=-0.00001834
beta[0][2][0]=beta[0][2][0]
beta[1][2][0]=beta[1][2][0]
beta[2][2][0]=beta[2][2][0]
beta[0][0][0]=beta[0][0][0]
beta[1][0][0]=beta[1][0][0]
beta[2][0][0]=beta[2][0][0]
beta[0][0][0]=beta[0][0][0]
beta[1][0][0]=beta[1][0][0]
beta[2][0][0]=beta[2][0][0]
beta[0][1][0]=beta[0][1][0]
beta[1][1][0]=beta[1][1][0]
beta[2][1][0]=beta[2][1][0]
beta[0][1][0]=beta[0][1][0]
beta[1][1][0]=beta[1][1][0]
beta[2][1][0]=beta[2][1][0]
beta[0][2][0]=beta[0][2][0]
beta[1][2][0]=beta[1][2][0]
beta[2][2][0]=beta[2][2][0]
beta[0][2][0]=beta[0][2][0]
beta[1][2][0]=beta[1][2][0]
beta[2][2][0]=beta[2][2][0]
beta[0][0][1]=beta[0][1][0]
beta[1][0][1]=beta[1][1][0]
beta[2][0][1]=beta[2][1][0]
beta[0][0][1]=beta[0][1][0]
beta[1][0][1]=beta[1][1][0]
beta[2][0][1]=beta[2][1][0]
beta[0][1][1]=0.00002244
beta[1][1][1]=0.00000618
beta[2][1][1]=-0.00000000
beta[0][1][1]=beta[0][1][1]
beta[1][1][1]=beta[1][1][1]
beta[2][1][1]=beta[2][1][1]
beta[0][2][1]=0.00000000
beta[1][2][1]=-0.00000000
beta[2][2][1]=0.00004129
beta[0][2][1]=beta[0][2][1]
beta[1][2][1]=beta[1][2][1]
beta[2][2][1]=beta[2][2][1]
beta[0][0][1]=beta[0][1][0]
beta[1][0][1]=beta[1][1][0]
beta[2][0][1]=beta[2][1][0]
beta[0][0][1]=beta[0][1][0]
beta[1][0][1]=beta[1][1][0]
beta[2][0][1]=beta[2][1][0]
beta[0][1][1]=beta[0][1][1]
beta[1][1][1]=beta[1][1][1]
beta[2][1][1]=beta[2][1][1]
beta[0][1][1]=beta[0][1][1]
beta[1][1][1]=beta[1][1][1]
beta[2][1][1]=beta[2][1][1]
beta[0][2][1]=beta[0][2][1]
beta[1][2][1]=beta[1][2][1]
beta[2][2][1]=beta[2][2][1]
beta[0][2][1]=beta[0][2][1]
beta[1][2][1]=beta[1][2][1]
beta[2][2][1]=beta[2][2][1]
beta[0][0][2]=beta[0][2][0]
beta[1][0][2]=beta[1][2][0]
beta[2][0][2]=beta[2][2][0]
beta[0][0][2]=beta[0][2][0]
beta[1][0][2]=beta[1][2][0]
beta[2][0][2]=beta[2][2][0]
beta[0][1][2]=beta[0][2][1]
beta[1][1][2]=beta[1][2][1]
beta[2][1][2]=beta[2][2][1]
beta[0][1][2]=beta[0][2][1]
beta[1][1][2]=beta[1][2][1]
beta[2][1][2]=beta[2][2][1]
beta[0][2][2]=-0.00001771
beta[1][2][2]=0.00003867
beta[2][2][2]=0.00000000
beta[0][2][2]=beta[0][2][2]
beta[1][2][2]=beta[1][2][2]
beta[2][2][2]=beta[2][2][2]
beta[0][0][2]=beta[0][2][0]
beta[1][0][2]=beta[1][2][0]
beta[2][0][2]=beta[2][2][0]
beta[0][0][2]=beta[0][2][0]
beta[1][0][2]=beta[1][2][0]
beta[2][0][2]=beta[2][2][0]
beta[0][1][2]=beta[0][2][1]
beta[1][1][2]=beta[1][2][1]
beta[2][1][2]=beta[2][2][1]
beta[0][1][2]=beta[0][2][1]
beta[1][1][2]=beta[1][2][1]
beta[2][1][2]=beta[2][2][1]
beta[0][2][2]=beta[0][2][2]
beta[1][2][2]=beta[1][2][2]
beta[2][2][2]=beta[2][2][2]
beta[0][2][2]=beta[0][2][2]
beta[1][2][2]=beta[1][2][2]
beta[2][2][2]=beta[2][2][2]

print(beta)
# post processing of the beta tensor

# splitting to three matrices

# betaX----------------------------------------------
betaX=np.zeros((3,3))
for i in range(3):
    for j in range(3):
        betaX[i][j] = beta[0][i][j]

#print(betaX)
np.savetxt('beta0.txt',(betaX), fmt='%6.7e')
np.savetxt('b0.txt',(betaX), fmt='%6.7e')


# betaY ---------------------------------------------

betaY=np.zeros((3,3))
for i in range(3):
    for j in range(3):
        betaY[i][j] = beta[1][i][j]
#print(betaY)

np.savetxt('beta1.txt',(betaY), fmt='%6.7e')
np.savetxt('b1.txt',(betaY), fmt='%6.7e')


# betaZ ---------------------------------------------
betaZ=np.zeros((3,3))
for i in range(3):
    for j in range(3):
        betaZ[i][j] = beta[2][i][j]
#print(betaZ)

np.savetxt('beta2.txt',(betaZ), fmt='%6.7e')
np.savetxt('b2.txt',(betaZ), fmt='%6.7e')

# ---------------------------------------------------
