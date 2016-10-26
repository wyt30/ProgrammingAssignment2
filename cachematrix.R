## This R script file contains two functions, "makeCacheMatrix.R" and "cacheSolve.R"
## The objective of the R script is to calculate the inverse of a matrix, and to cache the inverse matrix
## such that the function can call the inverse of the matrix directly from the cache without needing to calculate it again.

## The first function, "makeCacheMatrix" take an inversible matrix as arguement, and returns a list of 4 functions
## - "set": allows user to change the matrix stored in the main function "makeCacheMatrix.R" 
## - "get": simply returns the matrix stored in the main function "makeCacheMatrix.R" 
## - "setinverse": chages the inverse of the matrix stored in the main function "makeCacheMatrix.R" 
## - "getinverse": simply returns the inverse of the matrix stored in the main function "makeCacheMatrix.R" 
## - each of the functions can be called using "$". 

makeCacheMatrix <- function(x = matrix()) {
  Inv <- NULL
  set <- function(y) {
    x <<- y
    Inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) Inv <<- inverse
  getinverse <- function() Inv
  list(set = set, 
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## The second function, "cacheSolve", take the list of 4 functions from "makeCacheMatrix" as arguement.
## If the inverse of the matrix stored in "makeCacheMatrix" is not calculated yet, "cacheSolve" returns the inverse of matrix
## and stores it in the cache.
## If the inverse of the matrix is already calculated, "cacheSolve" will print "getting cached data", and retrieve the inverse
## of the matrix directly from the cache, without calculating it again. 

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  Inv <- x$getinverse()
  if(!is.null(Inv)) {
    message("getting cached data")
    return(Inv)
  }
  data <- x$get()
  Inv <- solve(data, ...)
  x$setinverse(Inv)
  Inv
}

## Example output:
##----------------------
## > source("cachematrix.R")
## > A=matrix(c(1,3,4,2,3,3,4,2.3,4),nrow=3,ncol=3)
## > B<-makeCacheMatrix(A)
## > cacheSolve(B)

##          [,1]  [,2]   [,3]
##[1,]    -0.408 -0.32  0.592
##[2,]     0.224  0.96 -0.776
##[3,]     0.240 -0.40  0.240

## > cacheSolve(B)

##getting cached data
##          [,1]  [,2]   [,3]
##[1,]    -0.408 -0.32  0.592
##[2,]     0.224  0.96 -0.776
##[3,]     0.240 -0.40  0.240
