#' compute volume of a triangular mesh
#'
#' compute volume of a triangular mesh
#' @param mesh triangular mesh of class mesh3d
#' @return volume of mesh
#' @examples
#' 
#' vcgVolume(vcgTetrahedron(normals=TRUE))
#' @export
vcgVolume <- function(mesh) {
    if(is.null(mesh$normals)) {
        stop("Mesh does not have normals, cannot estimate volume\n")
    }
    out <- .Call("Rvolume",mesh)
    return(out)
}
