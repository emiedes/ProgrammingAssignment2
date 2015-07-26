source("cachematrix.R")

m1 <- matrix(c(2, 2, 3, 2), nrow=2, ncol=2)
m1
inverse1 <- solve(m1)
m2 <- matrix(c(3,1,5, 2,-3,-1, -5,2,4), nrow=3, ncol=3)
m2
inverse2 <- solve(m2)

special <- makeCacheMatrix(m1)
special$get()
special$getInverse()

cacheSolve(special)
special$getInverse()
cacheSolve(special)
special$getInverse()

special$set(m2)
special$get()
special$getInverse()
cacheSolve(special)
special$getInverse()
cacheSolve(special)
special$getInverse()
