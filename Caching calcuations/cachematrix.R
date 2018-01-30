## The following fucntions store the data of the matirx inverse inorder to retreive the data faster.
## makeCacheMatrix - creates the data in the cache and
## cacheSolve function helps in retreiving the data from the cache

## The function creates the inverse matrix of the input matrix.

makeCacheMatrix <- function(x = matrix()) {

        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        #getting the data
        get <- function() {
                x
        }
        # Set the inverse of the data
        setinverse <- function(solve){ 
                m <<- solve 
        }
        #Getting the inverse of the data
        getinverse <- function() {
                m
        }
        
        
        list(set = set, get = get,setinverse = setinverse,getinverse = getinverse)
        
        
}

## The following function calculates the inerse of the vector created with the above function.
## However, it first checks to see if the inverse has already been calculated. If so, it gets the inverse from the cache and skips the computation. 
## Otherwise, it calculates the inverse of the data and sets the value of the inverse in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
        # Return a matrix that is the inverse of 'x'
        m <- x$getinverse()
        
        if(!is.null(m)) {
                message("retreiving the data from cache")
                return(m)
        }
        #if the data is not in cache then create the inverse
        data <- x$get()
        m <- solve(data, ...)
        x$setinverse(m)
        m
}

