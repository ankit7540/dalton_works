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
