#!/bin/bash
set -e

# 🧭 Configuración
VERSION="8.0.0"
PKG_NAME="node-addon-api"
SOURCE_DIR="$PWD"
BUILD_DIR="$PWD/build/${PKG_NAME}"

echo "🚀 Empaquetando ${PKG_NAME} versión ${VERSION}"

# 🔄 Limpiar build anterior si existe
rm -rf "$BUILD_DIR"

# 📁 Crear estructura del paquete
mkdir -p "$BUILD_DIR/usr/include/node"
mkdir -p "$BUILD_DIR/DEBIAN"

# 📥 Copiar headers
cp "$SOURCE_DIR"/*.h "$BUILD_DIR/usr/include/node/"

# 📝 Crear archivo control
cat > "$BUILD_DIR/DEBIAN/control" <<EOF
Package: ${PKG_NAME}
Version: ${VERSION}
Architecture: all
Maintainer: César Benjamin <cesarbenjamindotnet@gmail.com>
Section: libdevel
Priority: optional
Depends: libnode-dev
Description: Header-only C++ wrapper for N-API (embedding fork compatible with libnode)
EOF

# 🛠  Construir .deb
dpkg-deb --build "$BUILD_DIR"

# ✅ Mostrar resultado
echo "✅ Paquete generado:"
ls -lh "$BUILD_DIR/${PKG_NAME}.deb"
