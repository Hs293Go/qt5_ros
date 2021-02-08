#!/bin/bash

# Blanket change qt4 to qt5 for each combination of caps and numbers
find . -mindepth 2 -type f -exec sed -i 's/QT4/QT5/g; s/Qt4/Qt5/g; s/qt4/qt5/g' {} \;

# sed pattern 1: Replace QtGui with QtWidgets
# sed pattern 2: Strip the Qt prefix from modules in the function rosbuild_prepare_qt5
# sed pattern 3: Append Qt::SomeModule after the ${QT_LIBRARIES} target
find . -mindepth 2 \( -name "CMakeLists.txt" -o -name "*.cmake" \) -type f -exec sed -i 's/QtGui/QtWidgets/g; /rosbuild_prepare_qt5/s/Qt//g; s/${QT_LIBRARIES}/${QT_LIBRARIES} Qt5::Widgets Qt5::Core/g' {} \;

# Prepend 'include_directories(${CMAKE_BINARY_DIR})' to CMakeLists.txt in subdirectories
find ./qt_tutorials -mindepth 2 -name 'CMakeLists.txt' -type f -exec sed -i '1s/^/include_directories(${CMAKE_BINARY_DIR})\n/' {} \;

# sed pattern 1: Replace <QtGui> with <QtWidgets>
# sed pattern 2: Strip the QtGui prefix in includes like <QtGui/QMainQMainWindow>
# sed pattern 3: QApplication::UnicodeUTF8 is deprecated in Qt5. This variable is usually passed as an optional argument, so strip it with the preceding comma
find . -mindepth 2 \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.h" \) -type f -exec sed -i 's/<QtGui>/<QtWidgets>/g; s|QtGui/||g; s/, QApplication::UnicodeUTF8//g' {} \;
