## These R source file allows defining a 'special' matrix which is able
## to store a regular matrix and its inverse matrix.
## The inverse matrix is stored as a "cache", to avoid recomputing
## the inverse and thus saving computing time.
##
## A cacheSolve function is offered to compute the inverse of such
## special matrices.
## This function is able to decide when the inverse has to be recomputed
## and when it can be retrieved from the cache.
##
## In the additional file test.R you can find an R script to try it.

## makeCacheMatrix returns a "special matrix" that can also store its inverse
## as cached data.
makeCacheMatrix <- function(mtx = matrix()) {
    # mtx is the matrix to work with
    # cachedMtxt is the cached inverse matrix of mtx
    cachedMtx <- NULL

    # set sets a new value of mtx and NULL's cachedMtx
    # so it has to be recomputed and cached again
    set <- function(y) {
        mtx <<- y
        cachedMtx <<- NULL
    }

    # get returns the matrix data
    get <- function() mtx

    # setInverse saves the inverse as cached data
    setInverse <- function(inverse) cachedMtx <<- inverse

    # getInverse returns the cached inverse (may be valid or NULL)
    getInverse <- function() cachedMtx

    # The return value is a list of the four functions
    list(set = set, get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}

## cacheSolve computes the inverse of a "special matrix"
## The input is assumed to be invertible (as per assignment instructions)
## When possible, cacheSolve avoids recomputing the inverse
## but instead, return a cached inverse, thus saving computing time.
cacheSolve <- function(x, ...) {
	# First, try to get the inverse from the cache
	currentInverse = x$getInverse()
	if (is.null(currentInverse)) {
		# DEBUG
		print("Recomputing inverse...")

		# No cached inverse available
		# I have to compute it

		# Get the matrix
		mtx <- x$get()
		# Compute its inverse
		inverse <- solve(mtx)

		# Store it back in the cache
		x$setInverse(inverse)
	} else {
		# DEBUG
		print("Reusing the cache...")

		# The cached inverse is available
		# Let's reuse it
		inverse = currentInverse
	}

	# Finally, return the computed inverse
	# I use "invisible" to avoid priting the returned value
	invisible(inverse)
}
