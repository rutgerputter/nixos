self: super:

{
  intel-graphics-compiler = super.intel-graphics-compiler.overrideAttrs (old: {
    postPatch = ''
      if [ -f IGC/MDAutogen/CMakeLists.txt ]; then
        substituteInPlace IGC/MDAutogen/CMakeLists.txt \
          --replace 'cmake_minimum_required(VERSION 3.0)' 'cmake_minimum_required(VERSION 3.5...4.0)'
      else
        echo "WARNING: IGC/MDAutogen/CMakeLists.txt not found, skipping patch"
      fi
    '';

    cmakeFlags = (old.cmakeFlags or []) ++ [
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    ];
  });
}