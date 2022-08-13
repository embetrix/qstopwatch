#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "stopwatch.h"
namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

public slots:
    void startStopTimer();
    void resetTimer();
    void update();

signals:

private:
    Ui::MainWindow *ui;
    Stopwatch* watch;
};

#endif // MAINWINDOW_H
