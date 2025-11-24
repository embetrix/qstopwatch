cmake_minimum_required(VERSION 3.16)

project(qstopwatch VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Gui Widgets)


add_executable(qstopwatch
    main.cpp
    mainwindow.cpp
    mainwindow.h
    stopwatch.cpp
    stopwatch.h
    mainwindow.ui
)

target_link_libraries(qstopwatch PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Widgets
)

