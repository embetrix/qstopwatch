#
# (C) Copyright 2025
# Embetrix Embedded Systems Solutions, ayoub.zaki@embetrix.com
#

cmake_minimum_required(VERSION 3.16)

project(qstopwatch VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find Qt6 packages
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

# Add the QML resource file and source files
qt6_add_resources(QML_RESOURCES qml.qrc)

# Create executable with qt6_add_executable for better QML integration
qt6_add_executable(qstopwatch
    main.cpp
    stopwatch.cpp
    stopwatch.h
)

# Add QML files with caching enabled
qt6_add_qml_module(qstopwatch
    URI QStopwatch
    VERSION 1.0
    QML_FILES Main.qml
    NO_RESOURCE_TARGET_PATH
)

target_link_libraries(qstopwatch PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

