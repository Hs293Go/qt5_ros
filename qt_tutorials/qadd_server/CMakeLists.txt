include_directories(${CMAKE_BINARY_DIR})
##############################################################################
# Sections
##############################################################################

file(GLOB_RECURSE QT_MOC RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} FOLLOW_SYMLINKS *.hpp)
QT5_WRAP_CPP(QT_MOC_HPP ${QT_MOC})

##############################################################################
# Sources
##############################################################################

file(GLOB_RECURSE QT_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} FOLLOW_SYMLINKS *.cpp)

##############################################################################
# Binaries
##############################################################################

add_executable(qadd_server ${QT_SOURCES} ${QT_MOC_HPP})
target_link_libraries(qadd_server qtutorials)
install(TARGETS qadd_server RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
