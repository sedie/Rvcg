#' Import common mesh file formats.
#' 
#' Import common mesh file formats and store the results in an object of
#' class "mesh3d" - momentarily only triangular meshes are supported.
#' 
#' 
#' @param file character: file to be read.
#' @param updateNormals logical: if TRUE and the imported file contais faces,
#' vertex normals will be (re)calculated. Otherwise, normals will be a matrix containing zeros.
#' @return Object of class "mesh3d"
#' 
#' with:
#' \item{vb }{4xn matrix containing n vertices as homolougous coordinates}
#' \item{it }{4xm matrix containing vertex indices forming triangular faces}
#' \item{normals }{4xn matrix containing vertex normals}
#' @author Stefan Schlager
#' @seealso \code{\link{vcgSmooth}},
#' @keywords ~kwd1 ~kwd2
#' @export 

vcgImport <- function(file, updateNormals = TRUE) {
    ncfile <- nchar(file)
    ext <- substr(file,ncfile-2,ncfile)
    file <- path.expand(file)
    x <- file
    if (! file.exists(x))
        stop("no such file")
    tmp <- .Call("RallRead", file, updateNormals)
    if (!is.list(tmp))
        stop("mesh is not readable")
    out <- list()
    class(out) <- "mesh3d"
    out$vb <- rbind(matrix(tmp$vb,3,length(tmp$vb)/3),1)
    out$it <- matrix(tmp$it,3,length(tmp$it/3))+1
    out$normals <- rbind(matrix(tmp$normals,3,length(tmp$normals)/3),1)
   
    return(out)
}