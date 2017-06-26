#include "typedef.h"
#include "RvcgIO.h"
#include <RcppArmadillo.h>
#include <vcg/complex/complex.h>
#include <vcg/complex/algorithms/inertia.h>

using namespace vcg;
using namespace tri;
using namespace Rcpp;



RcppExport SEXP Rvolume(SEXP mesh_) {
  try {
    MyMesh mesh;
    bool water;
    double volume;
    Rvcg::IOMesh<MyMesh>::mesh3d2Rvcg(mesh,mesh_);
    // enable face normals in MyMesh class to allow volume calculation; important!!
    mesh.face.EnableNormal();
    // test for whether mesh is watertight
    water=vcg::tri::Clean<MyMesh>::IsWaterTight(mesh);
    if (!water) {
      Rprintf("WARNING: mesh is not watertight, volume may not be accurate\n");
    }
    // find volume of mesh
    vcg::tri::Inertia<MyMesh>::Inertia im(mesh);
    volume=im.Mass();
    return wrap(volume);
  } catch (std::exception& e) {
    ::Rf_error( e.what());
    return wrap(1);
  } catch (...) {
    ::Rf_error("unknown exception");
  }
}
